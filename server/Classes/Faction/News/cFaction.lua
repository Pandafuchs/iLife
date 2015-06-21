Factions= {}

CFaction = {}

function CFaction:constructor(iID, sName, sShortName, iDepotmoney, iType, sSkins, sColor, sRanknames, sKoords, iDistanz)
	self.ID 		= iID
	self.Name 		= sName
	self.ShortName 	= sShortName
	self.Depotmoney = iDepotmoney
	self.Type 		= iType
	self.Vehicles 	= {}
	self.Skins 		= {}
	self.Koords		= sKoords;
	self.Distanz	= iDistanz;
	self.Members 	= {}
	
	local result = CDatabase:getInstance():query("SELECT Name, Rank FROM Userdata WHERE Fraktion=?",self.ID)
	
	for k,v in ipairs(result) do
		self.Members[k] = {}
		self.Members[k]["Name"] = v["Name"]
		self.Members[k]["Rang"] = v["Rank"]
	end
	
	for i=1, 5, 1 do
		self.Skins[i] = gettok(sSkins, i, "|")
	end
	
	self.Color 		= sColor
	self.Ranknames 	= {}
	
	for i=1, 5, 1 do
		self.Ranknames[i] = gettok(sRanknames, i, "|")
	end
	
	local koords	= split(self.Koords, "|", -1);
	local x, y, z	= tonumber(koords[1]), tonumber(koords[2]), tonumber(koords[3]);
	
	if(x ~= 0) and (y ~= 0) and (z ~= 0) then
		self.FactionPickup	= createPickup(x, y, z, 3, 1272, 50);
		
		local leaderString 		= "-";
		local coLeaderString	= "-";
		
		for Member, tbl in pairs(self.Members) do
			local rang = tonumber(tbl["Rang"])
			if(rang >= 5) then
				if(#leaderString > 1) then
					leaderString = leaderString..", "..tbl["Name"]
				else
					leaderString = tbl["Name"]
				end
			elseif(rang == 4) then
				if(#coLeaderString > 1) then
					coLeaderString = coLeaderString..", "..tbl["Name"]
				else
					coLeaderString = tbl["Name"]
				end
			end			
		end

		
		self.colShapeHitFunc	= bind(self.colShapeHit, self);
		self.colShapeLeaveFunc	= bind(self.colShapeLeave, self);
		
		self.FactionColshape	= createColSphere(x, y, z, 20);
				
		
		setElementData(self.FactionColshape, "faction:Name", self.Name);
		setElementData(self.FactionColshape, "faction:ID", self.ID);
		setElementData(self.FactionColshape, "faction:Leader", leaderString);
		setElementData(self.FactionColshape, "faction:CoLeader", coLeaderString);
		setElementData(self.FactionColshape, "faction:Distanz", iDistanz);
		
		outputChatBox(getElementData(self.FactionColshape, "faction:ID"))
		
		addEventHandler("onColShapeHit", self.FactionColshape, self.colShapeHitFunc)
		addEventHandler("onColShapeLeave", self.FactionColshape, self.colShapeLeaveFunc)
	end
	
	Factions[self.ID] = self
	self:spawnCars()
end

function CFaction:colShapeHit(uElement, dim)
	if(getElementType(uElement) == "player") then
		local tbl = getElementData(uElement, "p:visitedFaction");
		if not(tbl) then
			tbl = {}
		end
		tbl[self.FactionColshape] = self.FactionColshape;
		setElementData(uElement, "p:visitedFaction", tbl)
	end
end

function CFaction:colShapeLeave(uElement, dim)
	if(getElementType(uElement) == "player") then
		local tbl = getElementData(uElement, "p:visitedFaction");
		if not(tbl) then
			tbl = {}
		end
		tbl[self.FactionColshape] = nil;
		setElementData(uElement, "p:visitedFaction", tbl)
	end
end


function CFaction:destructor()
end

function CFaction:getName()
	return self.Name
end

function CFaction:getID()
	return self.ID
end

function CFaction:getType()
	return self.Type
end

function CFaction:getRankName(Rank)
	return self.Ranknames[tonumber(Rank)]
end

function CFaction:getRankSkin(Rank)
	return self.Skins[tonumber(Rank)]
end

function CFaction:getColors()
	return tonumber(gettok(self.Color, 1, "|")),tonumber(gettok(self.Color, 2, "|")),tonumber(gettok(self.Color, 3, "|"))
end

function CFaction:spawnCars()
	vResult = CDatabase:getInstance():query("SELECT * FROM Faction_Vehicle WHERE FID=?", self.ID)
	
	for key, value in ipairs(vResult) do
			local theVehicle = createVehicle(value["VID"], gettok(value["Koords"],1,"|"), gettok(value["Koords"],2,"|"), gettok(value["Koords"],3,"|"), gettok(value["Koords"],4,"|"), gettok(value["Koords"],5,"|"), gettok(value["Koords"],6,"|"), "Faction "..self.ID)
			enew(theVehicle, CFactionVehicle, value["ID"], value["VID"], value["FID"], value["Int"], value["Dim"], value["Koords"], value["Color"], value["Tuning"], value["KM"], value["Typ"], value["Left"])
	end
	outputServerLog("Es wurden "..#vResult.." Vehicles fuer die Fraktion "..self.ShortName.." gefunden.")
end

function CFaction:getMembers()
	return self.Members
end

function CFaction:getData()
	return {
		["Name"] = self.Name,
		["Money"] = self.Depotmoney,
		["Boni"] = {[1]=250, [2]=250, [3]=250, [4]=250, [5]=250},
		["Type"] = self.Type
	}
end

function CFaction:sendMessage(sMessage) 
	for k,v in ipairs(getElementsByType("player")) do
		if (v:getFaction() == self ) then
			local r,g,b = self:getColors()
			outputChatBox("Achtung: ".. sMessage, v, r, g, b, false)
		end
	end
end

function CFaction:addMember(thePlayer) 
	table.insert(self.Members, {["Name"]=thePlayer:getName(),["Rang"]=thePlayer:getRank()})
end

function CFaction:removeMember(PlayerName) 
	for k,v in ipairs(self.Members) do
		if (v["Name"] == PlayerName) then
			if (getPlayerFromName(v["Name"])) then
				getPlayerFromName(v["Name"]):setFaction(Factions[0])
				getPlayerFromName(v["Name"]):setRank(0)
				getPlayerFromName(v["Name"]):setSkin(137)
			end
			table.remove(self.Members, k)
		end
	end
end