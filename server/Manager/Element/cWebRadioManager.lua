cWebRadioManager = inherit(cSingleton)
cWebRadioManager.tInstances = {}

function cWebRadioManager:constructor()
	local start = getTickCount()
	
	local result = CDatabase:getInstance():query("SELECT * FROM webradios;")
	for k,v in ipairs(result) do
		table.insert(self.tInstances, new(cWebRadio, v["iID"], v["strName"], v["strURL"]))
	end
	outputServerLog("Es wurden "..tostring(#result).." Webradios gefunden!(Ende: " .. getTickCount() - start .. "ms)")
end

function cWebRadioManager:destructor()

end