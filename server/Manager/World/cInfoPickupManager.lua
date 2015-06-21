CInfoPickupManager = inherit(cSingleton)
 
function CInfoPickupManager:constructor()
	local start = getTickCount()
	local qh = CDatabase:getInstance():query("select * from infopickups")
	for i,v in ipairs(qh) do
		local infopickup = createPickup(v["X"],v["Y"],v["Z"],3,1239,0)
		setElementInterior(infopickup,v["Int"])
		setElementDimension(infopickup,v["Dim"])
		enew(infopickup,CInfoPickup,v["ID"],v["X"],v["Y"],v["Z"],v["Int"],v["Dim"],v["Text"])
	end 
	outputDebugString("Es wurden "..#InfoPickups.." Infopickups gefunden (" .. getTickCount() - start .. "ms)", 3)
end