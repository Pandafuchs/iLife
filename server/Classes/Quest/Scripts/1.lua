local QuestID = 1
local Quest = Quests[QuestID]

Quest.Texts = {
	["Accepted"] = "Erf\\uelle die Quest!",
	["Finished"] = "Gebe die Quest ab!"
}

Quest.playerReachedRequirements = 
	function(thePlayer, bOutput)
		-- This quest can not be accepted!
		return false
	end

Quest.getTaskPosition = 
	function()
		--Should return int, dim, x, y, z
		return 0,0,0,0,0
	end

Quest.onAccept = 
	function(thePlayer)
		return true
	end

Quest.onProgress = 
	function(thePlayer)
		return true
	end

Quest.onResume = 
	function(thePlayer)
		return true
	end
	
Quest.onFinish = 
	function(thePlayer)
		return true
	end

Quest.onAbort = 
	function(thePlayer)
		return true
	end
	
----outputDebugString("Loaded Questscript: server/Classes/Quest/Scripts/"..tostring(QuestID)..".lua")