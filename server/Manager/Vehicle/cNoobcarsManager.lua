CNoobcarsManager = inherit(cSingleton)
 
function CNoobcarsManager:constructor()
	local start = getTickCount()
	local qh = CDatabase:getInstance():query("Select * From noobcars")
	for i,v in ipairs(qh) do
		local noobcar = createVehicle(v["Model"],v["X"], v["Y"], v["Z"],v["RX"],v["RY"],v["RZ"],"NOOBCAR")
		enew(noobcar, CNoobcars, v["ID"], v["Model"], v["X"], v["Y"], v["Z"], v["RX"],v["RY"],v["RZ"])
	end
	outputDebugString("Es wurden "..#Noobcars.." Noobcars gefunden (" .. getTickCount() - start .. "ms)",3)
end
