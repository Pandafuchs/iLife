CQuestManager = inherit(cSingleton)

function CQuestManager:constructor()
	self.PersistentClasses = {}
	self:loadPersistentScripts()
end

function CQuestManager:destructor()

end

function CQuestManager:loadPersistentScripts()
	--Johnnytum
	self.PersistentClasses["Johnnytum"] = new(CJohnnytum)
end

QuestManager = new(CQuestManager)