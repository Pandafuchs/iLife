addEventHandler("onClientClick", getRootElement(),
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		if (button == "right" and state == "down") then
			if (clickedWorld) then
				if (getElementType(clickedWorld) == "player") and not(getElementData(localPlayer, "inlobby")) then
					showPlayerClickGui(clickedWorld)
				end
			end
		end
		if (button == "left" and state == "down") then
			if (clickedWorld) then
				if (getElementType(clickedWorld) == "player") and not(getElementData(localPlayer, "inlobby")) then
					if(getElementData(clickedWorld, "crack") == true) then
						triggerServerEvent("onPlayerGrabRequest", localPlayer, getPlayerName(clickedWorld));
					end
				end
			end
		end
	end
)

PlayerClick = {
	["Window"] = false,
	["Image"] = {},
	["List"] = {},
	["Button"] = {}
}

function showPlayerClickGui(thePlayer)
	if (not clientBusy) then
		hidePlayerClickGui()

		PlayerClick["Window"] = new(CDxWindow, "Spieler", 500, 320, true, true, "Center|Middle")

		PlayerClick["List"][1] = new(CDxList, 5, 10, 335, 280, tocolor(125,125,125,200), PlayerClick["Window"])
		PlayerClick["List"][1]:addColumn("Attribut")
		PlayerClick["List"][1]:addColumn("Wert")

		local faction = getElementData(thePlayer, "Fraktionsname");
		if(thePlayer:getData("CorporationNameFull")) then
			faction = thePlayer:getData("CorporationNameFull")
		end

		PlayerClick["List"][1]:addRow("Name|"..thePlayer:getName())
		PlayerClick["List"][1]:addRow("Fraktion|"..faction)
		PlayerClick["List"][1]:addRow("Status|"..getElementData(thePlayer, "Status"))
		PlayerClick["List"][1]:addRow("Wanteds|"..getElementData(thePlayer, "Wanteds"))
		PlayerClick["List"][1]:addRow("STVO Punkte|"..getElementData(thePlayer, "STVO"))
		PlayerClick["List"][1]:addRow("Jailtime|"..getElementData(thePlayer, "Jailtime").." m")
		PlayerClick["List"][1]:addRow("Registrierdatum|"..(getElementData(thePlayer, "RegisterDate")))
		PlayerClick["List"][1]:addRow("Geburtsdatum|"..(getElementData(thePlayer, "Birthday")))
		PlayerClick["List"][1]:addRow("Spielzeit|"..(math.floor(getElementData(thePlayer, "Playtime")/60)).." Stunden "..(getElementData(thePlayer, "Playtime") % 60).." Minuten")

		if (thePlayer ~= getLocalPlayer()) then
			PlayerClick["Button"][1] = new(CDxButton, "Handeln", 350, 10, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])
			PlayerClick["Button"][2] = new(CDxButton, "Nummer anzeigen", 350, 50, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])
			PlayerClick["Button"][3] = new(CDxButton, "Freund hinzufügen", 350, 90, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])
			PlayerClick["Button"][4] = new(CDxButton, "Auto Verkaufen", 350, 130, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

			PlayerClick["Button"][1]:addClickFunction(
				function()
					hidePlayerClickGui()
					triggerServerEvent("onTradeStart", getLocalPlayer(), thePlayer)
				end
			)

			PlayerClick["Button"][2]:addClickFunction(
				function()
					showInfoBox("info", "Der Spieler hat die Telefonnummer: "..getElementData(thePlayer, "Phonenumber") or "Unbekannt")
				end
			)

			PlayerClick["Button"][3]:addClickFunction(
				function()
					if(toboolean(cConfig_Friendlist:getInstance():getConfig(thePlayer:getName())) == true) then
						cConfig_Friendlist:getInstance():setConfig(thePlayer:getName(), "false")
						showInfoBox("info", "Spieler wurde von der Freundesliste entfernt.")
					else
						cConfig_Friendlist:getInstance():setConfig(thePlayer:getName(), "true")
						showInfoBox("sucess", "Spieler wurde auf die Freundesliste gesetzt!")
					end
				end
			)
			PlayerClick["Button"][4]:addClickFunction(
				function()
					hidePlayerClickGui()
					requestUserVehicles(thePlayer);
				end
			)

			PlayerClick["Window"]:add(PlayerClick["Button"][1])
			PlayerClick["Window"]:add(PlayerClick["Button"][2])
			PlayerClick["Window"]:add(PlayerClick["Button"][3])
			PlayerClick["Window"]:add(PlayerClick["Button"][4])

			if (getElementData(localPlayer, "Fraktion") == 1) or (getElementData(localPlayer, "Fraktion") == 2) then
				PlayerClick["Button"][5] = new(CDxButton, "Durchsuchen", 350, 210, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

				PlayerClick["Button"][5]:addClickFunction(
					function()
						hidePlayerClickGui()
						triggerServerEvent("onCopExaminePlayer", getLocalPlayer(), thePlayer)
					end
				)

				PlayerClick["Window"]:add(PlayerClick["Button"][5])

				PlayerClick["Button"][6] = new(CDxButton, "Illegales Entfernen", 350, 250, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

				PlayerClick["Button"][6]:addClickFunction(
					function()
						hidePlayerClickGui()
						triggerServerEvent("onCopTakeIllegalThings", getLocalPlayer(), thePlayer)
					end
				)

				PlayerClick["Window"]:add(PlayerClick["Button"][6])
			end

		else
			PlayerClick["Button"][1] = new(CDxButton, "Status ändern", 350, 10, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

			PlayerClick["Button"][1]:addClickFunction(
				function()
					hidePlayerClickGui()
					showChooseStatusGui()
				end
			)

			PlayerClick["Button"][2] = new(CDxButton, "Spawn ändern", 350, 55, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

			PlayerClick["Button"][2]:addClickFunction(
				function()
					hidePlayerClickGui()
					showChangeSpawnGui()
				end
			)
			PlayerClick["Button"][3] = new(CDxButton, "Einstellungen", 350, 55+45, 140, 35, tocolor(255,255,255,255), PlayerClick["Window"])

			-- Don't mind me, just a fucked up function coming through --
			PlayerClick["Button"][3]:addClickFunction(
				function()
					hidePlayerClickGui()
					cEinstellungsGUI:new():show()
				end
			)
			PlayerClick["Window"]:add(PlayerClick["Button"][1])
			PlayerClick["Window"]:add(PlayerClick["Button"][2])
			PlayerClick["Window"]:add(PlayerClick["Button"][3])
			PlayerClick["List"][1]:addRow("Handgeld|$"..getElementData(thePlayer, "Geld"))


		end

		PlayerClick["Window"]:add(PlayerClick["List"][1])
		PlayerClick["Window"]:show()
	end
end

function hidePlayerClickGui()
	if (PlayerClick["Window"]) then
		PlayerClick["Window"]:hide()
		delete(PlayerClick["Window"])
		PlayerClick["Window"] = false
	end
end

addCommandHandler("self", function() showPlayerClickGui(getLocalPlayer()) end)

--[[
local function bindDat()
	if not(clientBusy) then
		showCursor(not (isCursorShowing()), false)
		clientBusy = not(clientBusy)
	end
end

local function loadKeybind(bBool, sKey)
	if not(bBool) then
		if(fileExists("res/keybinds.cfg")) then
			local file = fileOpen("res/keybinds.cfg")
			local input = fileRead(file, fileGetSize(file));
			fileClose(file);
			bindKey(input, "both", bindDat);

			return input;
		end
	else
		if(fileExists("res/keybinds.cfg")) then
			fileDelete("res/keybinds.cfg")
		end
		local file = fileCreate("res/keybinds.cfg");
		fileWrite(file, sKey);

	end
end
loadKeybind();

addCommandHandler("bindcursor", function(cmd, sKey)
	if not(sKey) then
		local asdf = loadKeybind();
		if(asdf) then
			unbindKey(asdf, "both", bindDat);
			outputChatBox("Cursorbind entfernt!", 0, 255, 0)
		end
	else
		loadKeybind(true, sKey);
	end
end)
]]
