CJobManager = {}

function CJobManager:constructor()
	result = CDatabase:getInstance():query("SELECT * FROM Jobs")
	if(#result > 0) then
		for key, value in pairs(result) do
			new(CJob, value["ID"], value["Name"], value["Koords"])
		end
		outputServerLog("Es wurden "..tostring(#result).." Jobs gefunden!")
	else
		outputServerLog("Es wurden keine Jobs gefunden!")
	end
end

function CJobManager:destructor()

end