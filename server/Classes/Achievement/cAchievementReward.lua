AchievementRewards = {}

CAchievementReward = {}

function CAchievementReward:constructor(iID, iPoints, sStatus, JSONItems)
	
	self.ID = iID
	self.Points = iPoints
	self.Status = sStatus
	self.Items = fromJSON(JSONItems)
	
	AchievementRewards[iID] = self
end

function CAchievementReward:destructor()

end

function CAchievementReward:execute(thePlayer)
	thePlayer:addBonuspoints(self.Points)
	if (self.Status) and (self.Status ~= "NULL") then
		thePlayer:addStatus(self.Status)
	end
	if (type(self.Items) == "table") then
		if (table.size(self.Items) > 0) then
			for k,v in pairs(self.Items) do
				thePlayer:getInventory():addItem(Items[tonumber(k)],tonumber(v))
			end
		end
	end
end

function CAchievementReward:getPoints()
	return self.Points
end

function CAchievementReward:getStatus()
	return self.Status
end

function CAchievementReward:getItems()
	return self.Items
end