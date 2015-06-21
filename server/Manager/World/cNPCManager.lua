CNPCManager = {}

function CNPCManager:constructor()

self.Skins = {14,28,79,168,135,143}

local qh = CDatabase:getInstance():query("Select * From npc")
	for i,v in ipairs(qh) do
		--[[
		local typ = math.random(1,6)
		local npc = createPed(self.Skins[typ],v["X"],v["Y"],v["Z"],v["Rot"])
		enew(npc,CNPC,v["ID"],v["X"],v["Y"],v["Z"],v["Rot"],typ)
		]]
	end
	outputDebugString("Es wurden "..#NPCs.." NPCs gefunden",3)
end