local QuestID = 22
local Quest = Quests[QuestID]

Quest.Texts = {
	["Accepted"] = "Bezahle dem Priester das Geld!",
	["Finished"] = "Erf\uelle deinen Geist!"
}

Quest.playerReachedRequirements = 
	function(thePlayer, bOutput)
		if ( thePlayer:isQuestFinished(Quests[21]) ) then
			return true
		end
		return false
	end

Quest.getTaskPosition = 
	function()
		--Should return int, dim, x, y, z
		return 0, 0, 2232.759765625, -1333.4404296875, 23.981597900391
	end

Quest.onAccept = 
	function(thePlayer)
		Quest:playerFinish(thePlayer)
		return true
	end
		
Quest.onResume = 
	function(thePlayer)
		return true
	end

Quest.onProgress = 
	function(thePlayer)
		return true
	end

Quest.onFinish = 
	function(thePlayer)
		outputChatBox("Priester: Viel Spa\\sz!", thePlayer, 255,255,255)
		return true
	end

Quest.onAbort = 
	function(thePlayer)
		return true
	end

--outputDebugString("Loaded Questscript: server/Classes/Quest/Scripts/"..tostring(QuestID)..".lua")