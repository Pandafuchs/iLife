CDriveInManager = inherit(cSingleton)

function CDriveInManager:constructor()
	local start = getTickCount()
	local qh = CDatabase:getInstance():query("Select * From drivein")
	for i,v in ipairs(qh) do
		local drivein = createMarker(v["X"], v["Y"], v["Z"], "corona", 4, 255, 0, 0)
		enew(drivein, CDriveIn, v["ID"], v["Type"], v["X"], v["Y"], v["Z"], v["Filiale"])
	end
	outputDebugString("Es wurden "..#DriveIns.." Driveins gefunden (" .. getTickCount() - start .. "ms)",3)
end
