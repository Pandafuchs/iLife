--[[PlayerListScroll = 0

FactionColors = {
[1] = tocolor(255,255,255,255),
[2] = tocolor(125,125,255,255),
[3] = tocolor(0,0,0,255),
[4] = tocolor(0,125,0,255),
[5] = tocolor(150,0,230,255),
[6] = tocolor(230,145,0,255),
[7] = tocolor(0,103,199,255),
[8] = tocolor(135,135,135,255),
[9] = tocolor(0,0,0,255),
[10] = tocolor(0,0,0,255),
[1337] = tocolor(125,125,125,255)
}

PlayerList = {
["Window"] = false,
["Label"] = {},
["List"] = {}
}

--PlayerList["Label"][1] = new(CDxLabel, "", 120, 30, 190, 120, tocolor(255,255,255,255), 1.2, "default", "center", "center", Infobox["Window"])

--PlayerList["Window"]:add(PlayerList["Label"][1])

function hidePlayerList()
	if (PlayerList["Window"]) then
		PlayerListScroll = PlayerList["List"][1].Scroll
		PlayerList["Window"]:hide()
		delete(PlayerList["Window"])
	end
	if ( (getKeyBoundToFunction( changePlayerListMode )) and (getKeyBoundToFunction( changePlayerListMode ) ~= "") ) then
		unbindKey("mouse2", "both", changePlayerListMode)
	end
end

function showPlayerList(key, state, view)
	hidePlayerList()
	PlayerList["Window"] = new(CDxWindow, "Spielerliste - ", 600, 427, true, false, "Center|Middle")
	if (view == 1) then
		PlayerList["Label"] = nil
		PlayerList["Label"] = {}

		local Faction = {
		[1]= {},
		[2]= {},
		[3]= {},
		[4]= {},
		[5]= {},
		[6]= {},
		[7]= {},
		[8]= {},
		[9]= {},
		[10]= {},
		[1337] = {}
		}

		]]
		--[[
		allPlayers =  {} --getElementsByType("player")

		for i=1,120,1 do
			outputChatBox(i)
			table.insert(allPlayers, "Test"..i)
		end]]
		--[[
		allPlayers = getElementsByType("player")

		for key, value in ipairs(allPlayers) do
			if (getElementData(value,"Fraktion")) then
				table.insert(Faction[getElementData(value,"Fraktion")+1], value)
			else
				table.insert(Faction[1337],value)
			end
			--table.insert(Faction[1], value)
		end
		players = 0
		for key, value in ipairs(Faction) do
			if (key ~= 1337) and (key ~= 1) then
				for key2, value2 in ipairs(value) do
					players = players+1
					PlayerList["Label"][players] = new(CDxLabel, getPlayerName(value2), 2+120*( math.floor((players-1)/25)), 2+16*(math.floor((players-1)%25)), 115, 15, FactionColors[key], 1, "default", "left", "center", PlayerList["Window"])
					PlayerList["Window"]:add(PlayerList["Label"][players])
				end
			end
		end
		PlayerList["Window"]:setTitle("Fraktionsmitglieder : "..tostring(players))
	else
		PlayerList["List"][1] = new(CDxList, 5, 5, 585, 380, tocolor(125,125,125,200), PlayerList["Window"], true)

		PlayerList["List"][1]:addColumn("Name")
		PlayerList["List"][1]:addColumn("Fraktion")
		PlayerList["List"][1]:addColumn("Status")
		PlayerList["List"][1]:addColumn("Spielzeit")

		local sortedPlayers = {}

		for k,v in ipairs(getElementsByType("player")) do
			table.insert(sortedPlayers, getPlayerName(v))
		end

		table.sort(sortedPlayers)

		for i,n in ipairs(sortedPlayers) do
			v = getPlayerFromName(n)
			if getElementData(v, "online") then
				PlayerList["List"][1]:addRow(getPlayerName(v).."|"..getElementData(v,"Fraktionsname").."|"..getElementData(v,"Status").."|"..math.floor(getElementData(v,"Playtime")/60)..":"..(getElementData(v,"Playtime")%60))
			else
				PlayerList["List"][1]:addRow(getPlayerName(v).."| |Verbindet...| ")
			end
		end
		PlayerList["List"][1].Scroll = PlayerListScroll

		PlayerList["Window"]:setTitle("Spielerliste - Online: "..#getElementsByType("player").." Spieler")
		PlayerList["Window"]:add(PlayerList["List"][1])
	end

	PlayerList["Window"]:setReadOnly(true)

	PlayerList["Window"]:show()

	bindKey("mouse2", "both", changePlayerListMode)
end

function changePlayerListMode(key, state)
	if (key == "mouse2") then
		if (state == "up") then
			showPlayerList("", "", 2)
		else
			showPlayerList("" ,"" ,1)
		end
	end
end

bindKey("tab", "down", showPlayerList, 2)
bindKey("tab", "up", hidePlayerList)

]]