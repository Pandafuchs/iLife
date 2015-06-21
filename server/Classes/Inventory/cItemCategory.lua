ItemCategories = {}

CItemCategory = {}

addEvent("onClientRequestItemCategories", true)
addEventHandler("onClientRequestItemCategories", getRootElement(),
    function()
        triggerClientEvent(source, "onClientItemCategoriesRecieve", source, toJSON(ItemCategories))
    end
)

function CItemCategory:constructor(iID, sName, sDesc)
	self.ID                = iID
	self.Name              = sName
	self.Description    = sDesc

	ItemCategories[self.ID] = self
end

function CItemCategory:destructor()

end

function CItemCategory:getID()
	return self.ID
end
