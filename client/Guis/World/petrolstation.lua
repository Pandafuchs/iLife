Petrolstation = {
	["Window"] = false,
	["Label"] = {},
	["Button"] = {},
	["Edit"] = {}
}

addEvent("PetrolstationGuiOpen",true)
addEventHandler("PetrolstationGuiOpen", getLocalPlayer(), function()
	if (not clientBusy) then
		closePetrolstationGui()
		
		Petrolstation["Window"] = new(CDxWindow, "Tankstelle", 305, 427, true, true, "Center|Middle")

		Petrolstation["Label"][1] = new(CDxLabel, "Tanken:", 0, 20, 300, 20, tocolor(255,255,255,255), 1.5, "default", "center", "center", Petrolstation["Window"])
		Petrolstation["Label"][2] = new(CDxLabel, "Preis pro Liter: "..formNumberToMoneyString(3), 20, 70, 280, 20, tocolor(255,255,255,255), 1.3, "default", "left", "center", Petrolstation["Window"])
		Petrolstation["Label"][3] = new(CDxLabel, "Fahrzeugstatus: "..math.round(getElementData(getPedOccupiedVehicle(localPlayer), "Fuel")).."/100 Liter", 20, 95, 280, 20, tocolor(255,255,255,255), 1.3, "default", "left", "center", Petrolstation["Window"])
		Petrolstation["Label"][4] = new(CDxLabel, "Menge:", 10, 140, 290, 30, tocolor(255,255,255,255), 2, "default", "left", "center", Petrolstation["Window"])
		Petrolstation["Edit"][1] = new(CDxEdit, "0", 10, 175, 280, 50, "Number", tocolor(0,0,0,255), Petrolstation["Window"])
		Petrolstation["Button"][1] = new(CDxButton, "Liter tanken", 5, 230, 290, 50, tocolor(255,255,255,255), Petrolstation["Window"])
		Petrolstation["Button"][2] = new(CDxButton, "Voll tanken", 5, 290, 290, 50, tocolor(255,255,255,255), Petrolstation["Window"])
		
		Petrolstation["Button"][1]:addClickFunction(
		function ()
			if (tonumber(Petrolstation["Edit"][1]:getText())>0) and tonumber(Petrolstation["Edit"][1]:getText())<= 100-math.round(getElementData(getPedOccupiedVehicle(localPlayer), "Fuel")) then
				triggerServerEvent("onClientFillVehicle", getRootElement(),tonumber(Petrolstation["Edit"][1]:getText()))
				closePetrolstationGui()
			else
				showInfoBox("error", "So viel kannst du nicht tanken!")
			end
		end
		)
		
		Petrolstation["Button"][2]:addClickFunction(
		function ()
			triggerServerEvent("onClientFillVehicle", getRootElement(), 100-math.round(getElementData(getPedOccupiedVehicle(localPlayer), "Fuel"))+1)
			closePetrolstationGui()
		end
		)

		Petrolstation["Window"]:add(Petrolstation["Label"][1])
		Petrolstation["Window"]:add(Petrolstation["Label"][2]) 
		Petrolstation["Window"]:add(Petrolstation["Label"][3])
		Petrolstation["Window"]:add(Petrolstation["Label"][4])
		Petrolstation["Window"]:add(Petrolstation["Edit"][1])
		Petrolstation["Window"]:add(Petrolstation["Button"][1])
		Petrolstation["Window"]:add(Petrolstation["Button"][2])
		
		Petrolstation["Window"]:setHideFunction(function() closePetrolstationGui() end)
		
		Petrolstation["Window"]:show()
		PetrolstationGuiShown = true
	end
end
)
 
function closePetrolstationGui()
	if (Petrolstation["Window"] ~= false) then
		Petrolstation["Window"]:hide()
		delete(Petrolstation["Window"])
		Petrolstation["Window"] = false
	end
end