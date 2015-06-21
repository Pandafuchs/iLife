CParachuteManager = {}
 
function CParachuteManager:constructor()
	local qh = CDatabase:getInstance():query("Select * From Parachutes")
	for i,v in ipairs(qh) do
		local absprungplatz = createMarker(v["X"],v["Y"],v["Z"]-0.8,"cylinder",1)
		enew(absprungplatz,CParachute,v["ID"],v["X"],v["Y"],v["Z"])
	end
	outputDebugString("Es wurden "..#Parachutes.." Parachutes gefunden",3)
end
 
ParachuteManager = new(CParachuteManager)
