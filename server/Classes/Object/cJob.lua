Jobs = {}

CJob = {}

function CJob:constructor(iID, sName, sKoords)
	self.ID = iID
	self.Name = sName
	self.Koords = sKoords
	
	Jobs[self.ID] = self
end

function CJob:destructor()

end

addEvent("onClientRequestJobs", true)
addEventHandler("onClientRequestJobs", getRootElement(), 
	function()
		triggerClientEvent(client, "onClientRecieveJobs", getRootElement(), Jobs)
	end
)