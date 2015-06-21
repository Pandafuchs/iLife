CChainManager = inherit(cSingleton)
BusinessChains	= {}


function CChainManager:constructor()
	local start = getTickCount()
	local result = CDatabase:getInstance():query("SELECT * FROM chains")
	if(#result > 0) then
		for key, value in pairs(result) do
			new (CChain, value["ID"], value["Name"], value["Money"], value["Value"], value["Owner"])
			BusinessChains[tonumber(value["ID"])] = {}
		end
		outputServerLog("Es wurden "..tostring(#result).." Chains gefunden! (" .. getTickCount() - start .. "ms)")
	else
		outputServerLog("Es wurden keine Chains gefunden!")
	end
end

function CChainManager:destructor()

end