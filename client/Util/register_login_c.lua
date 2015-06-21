--[[x,y = guiGetScreenSize()

LoginWin = guiCreateWindow(x/2 - 150,y/2 - 110,300,220,"Willkommen",false)

TabPanel = guiCreateTabPanel(17,30,261,152,false,LoginWin)

TabLogin = guiCreateTab("Login",TabPanel)
LblUsername = guiCreateLabel(11,27,70,16,"Benutzername",false,TabLogin)
LoginUsername = guiCreateEdit(76,26,171,21,"",false,TabLogin)
LblPassword = guiCreateLabel(11,60,70,16,"Passwort",false,TabLogin)
LoginPassword = guiCreateEdit(76,58,171,21,"",false,TabLogin)
guiEditSetMasked(LoginPassword,true)

TabRegister = guiCreateTab("Register",TabPanel)
LblRegisterUsername = guiCreateLabel(11,27,70,16,"Benutzername",false,TabRegister)
EditRegisterUsername = guiCreateEdit(76,26,171,21,"",false,TabRegister)
LblRegisterPassword = guiCreateLabel(11,60,70,16,"Passwort",false,TabRegister)
EditRegisterPassword = guiCreateEdit(76,58,171,21,"",false,TabRegister)
guiEditSetMasked(EditRegisterPassword,true)
LblRegisterEmail = guiCreateLabel(35,92,35,16,"Email",false,TabRegister)
EditRegisterEmail = guiCreateEdit(76,90,171,21,"",false,TabRegister)

BtnAction = guiCreateButton(182,188,95,19,"LOS",false,LoginWin)

guiSetVisible ( LoginWin, false )
]]--


-- Muss Beizeiten mal komplett neu gemacht werden, sehr statisch geschrieben und nicht OOP
local usingNewLogin		= true;
local x,y 				= guiGetScreenSize()

Login =
{
	["Window"] 	= false,
	["Label"] 	= {},
	["Image"] 	= {},
	["Button"] 	= {},
	["Edit"] 	= {},
}

Login["Window"] 		= new(CDxWindow, "Herzlich Willkommen!", 370, 270, true, false, "Center|Middle", 0, 0, {tocolor(100, 255, 100, 200), false, "Einloggen"}, "Passwort oder Name vergessen? Klicke auf 'Passwort Vergessen' und forder ein neues an!")
Login["Image"][1] 		= new(CDxImage, 0, 0, 368, 270-29, "/res/images/bg.png",tocolor(255,255,255,255), Login["Window"])
Login["Label"][1] 		= new(CDxLabel, "Passwort:", 222, 103, 136, 30, tocolor(255,255,255,255), 2, "default", "left", "center", Login["Window"])
Login["Edit"][1] 		= new(CDxEdit, "Text", 220, 139, 139, 38, "Masked", tocolor(0,0,0,255), Login["Window"])
Login["Button"][1] 		= new(CDxButton, "Einloggen", 220, 186, 139, 38, tocolor(255,255,255,255), Login["Window"])
Login["Button"][2] 		= new(CDxButton, "Passwort vergessen", 10, 190, 170, 30, tocolor(255,255,255,255), Login["Window"])

LoginAttempt = false

Login["Edit"][1]:addClickFunction(
function ( button, state )
	if (Login["Edit"][1]:getText() == "Text") then
		Login["Edit"][1]:setText("")
	end
end
)

Login["Button"][1]:addClickFunction(
function ( button, state )
	if (not (LoginAttempt)) then
		LoginAttempt = true
        local pw = teaDecode(_Gsettings.currentPassword, tostring(config:getConfig("password_key")))
        local sha = true;

        if not(pw) or (Login["Edit"][1]:getText() ~= "Text") then
            pw = Login["Edit"][1]:getText()
            sha = false;
            config:setConfig("password_key", generateSalt(pw))
            _Gsettings.currentPasswordNew = teaEncode(pw, config:getConfig("password_key"))
        end

		triggerServerEvent ( "onPlayerLoginS", getLocalPlayer(), pw)
		loadingSprite:setEnabled(true);
	end
end
)
Login["Button"][2]:addClickFunction(
	function ( button, state )
		Login["Window"]:hide()
		confirmDialog:hideConfirmDialog()

		local function yes()
			triggerServerEvent("onPlayerPasswortVergessen", localPlayer, confirmDialog.guiEle["edit"]:getText())
		end

		local function no()
			Login["Window"]:hide();
			Login["Window"]:show();
		end

		confirmDialog:showConfirmDialog("Bitte gebe deine E-Mail Adresse ein. Wir werden dir eine E-Mail mit deinen Informationen senden.", yes, no, true, true)
	end
)
addEvent("enableLoginAgain", true)
addEventHandler("enableLoginAgain", getRootElement(),
function()
	LoginAttempt = false
	loadingSprite:setEnabled(false);
end
)

Login["Window"]:add(Login["Image"][1])
Login["Window"]:add(Login["Label"][1])
Login["Window"]:add(Login["Edit"][1])
Login["Window"]:add(Login["Button"][1])
Login["Window"]:add(Login["Button"][2])



--[[
	dxDrawText("Passwort:",222.0,103.0,358.0,132.0,tocolor(255,255,255,255),2.0,"default","left","top",false,false,true)
        dxDrawImage(220.0,186.0,139.0,38.0,"images/bg.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
        dxDrawImage(220.0,139.0,139.0,38.0,"images/bg.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
        dxDrawImage(0.0,0.0,368.0,241.0,"images/bg.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
    end

dxDrawText("Passwort",678.0,391.0,812.0,414.0,tocolor(255,255,255,255),1.0,"default","left","top",false,false,true)

]]


addEventHandler("onClientResourceStart", getRootElement(),
	function(startedResource)
		if (startedResource == getThisResource()) then
			Register_Button = {}
			Register_Label = {}
			Register_Edit = {}
			Register_Radio = {}
			Register_Image = {}

			Register_Image[1] = guiCreateStaticImage(0.17685,0.18945,0.6463,0.6211,"res/images/Perso.png",true)
			Register_Radio[1] = guiCreateRadioButton(0.3627,0.8664,0.1799,0.0393,"Männlich",true,Register_Image[1])
			guiRadioButtonSetSelected(Register_Radio[1],true)
			guiSetFont(Register_Radio[1],"default-bold-small")
			Register_Radio[2] = guiCreateRadioButton(0.4507,0.8664,0.1799,0.0393,"Weiblich",true,Register_Image[1])
			guiSetFont(Register_Radio[2],"default-bold-small")
			Register_Edit[1] = guiCreateEdit(0.353,0.3019,0.3298,0.0692,getPlayerName(getLocalPlayer()),true,Register_Image[1])
			guiEditSetReadOnly(Register_Edit[1],true)
			guiEditSetMaxLength(Register_Edit[1],16)
			Register_Edit[2] = guiCreateEdit(0.353,0.4167,0.3298,0.0692,"",true,Register_Image[1])
			Register_Edit[3] = guiCreateEdit(0.353,0.5299,0.3298,0.0692,"",true,Register_Image[1])
			guiEditSetMasked(Register_Edit[3],true)
			guiEditSetMaxLength(Register_Edit[3], 16)
			Register_Edit[4] = guiCreateEdit(0.353,0.6494,0.3298,0.0692,"",true,Register_Image[1])
			guiEditSetMasked(Register_Edit[4],true)
			guiEditSetMaxLength(Register_Edit[4], 16)
			Register_Edit[5] = guiCreateEdit(0.3946,0.7563,0.0493,0.0692,"12",true,Register_Image[1])
			guiEditSetMaxLength(Register_Edit[5],2)
			Register_Label[1] = guiCreateLabel(0.3598,0.772,0.0348,0.0393,"Tag:",true,Register_Image[1])
			guiLabelSetColor(Register_Label[1],0,0,0)
			guiSetFont(Register_Label[1],"default-bold-small")
			Register_Label[2] = guiCreateLabel(0.4584,0.772,0.0426,0.0393,"Monat:",true,Register_Image[1])
			guiLabelSetColor(Register_Label[2],0,0,0)
			guiSetFont(Register_Label[2],"default-bold-small")
			Register_Edit[6] = guiCreateEdit(0.5029,0.7563,0.0493,0.0692,"12",true,Register_Image[1])
			Register_Label[3] = guiCreateLabel(0.5677,0.772,0.0426,0.0393,"Jahr:",true,Register_Image[1])
			guiLabelSetColor(Register_Label[3],0,0,0)
			guiSetFont(Register_Label[3],"default-bold-small")
			Register_Edit[7] = guiCreateEdit(0.6054,0.7563,0.0996,0.0692,"1995",true,Register_Image[1])
			Register_Button[1] = guiCreateButton(0.6925,0.8428,0.1654,0.0865,"Bestätigen",true,Register_Image[1])
			guiSetVisible ( Register_Image[1], false)
		end
	end
)



local localPlayer = getLocalPlayer ( )

function dxDraw()
	local duration = 3000
	local degree = 20
	if (getTickCount()%duration < duration/2) then
		if (getTickCount()%duration < duration/4) then
			secs = (getTickCount()%(duration/2)*(degree/(duration/2)))
		else
			secs = degree-(getTickCount()%(duration/2)*(degree/(duration/2)))
		end
	else
		if (getTickCount()%duration < 3*duration/4) then
			secs = 360-(getTickCount()%(duration/2)*(degree/(duration/2)))
		else
			secs = (360-degree)+(getTickCount()%(duration/2)*(degree/(duration/2)))
		end
	end

	local screenX,screenY = guiGetScreenSize()
	dxDrawImage(screenX-200, screenY-200, 175, 175,"res/images/rewrite.png",secs,0,0)
	dxDrawRectangle ( screenX-5, screenY-5, 5, 5)
end

function requestServer(startedResource)
	if (startedResource == getThisResource()) then
		triggerServerEvent("onClientJoin", getLocalPlayer())
	end
end
addEventHandler("onClientResourceStart", getRootElement(), requestServer)

function dxDrawClick(btn, state, X, Y)
	local screenX,screenY = guiGetScreenSize()
	if (isPointInRectangle(X,Y,screenX-200, screenY-200,175,175)) then
		if ( (btn == "left") and (state=="down") ) then
			hideLoginWindow()
			Intro:setEndFunc(
				function()
					Login["Window"]:show()
					loginCamDrive ()
					guiSetInputEnabled(true)
					showCursor ( true )
					fadeCamera ( false,0,0,0,0)
					fadeCamera ( true, 5)
					showPlayerHudComponent ( "all", false)
				    hud:Toggle(false)
					_G["Loginsound"] = playSound("http://www.vio-race.de/servermusic/mapmusic/realsteel-ft-banana_dark-time.mp3",true)
					--_G["Loginsound"] = playSound("http://rewrite.ga/iLife/intro.mp3",true)
					setGameSpeed(1)
					addEventHandler("onClientRender", getRootElement(), dxDraw)
					addEventHandler("onClientClick", getRootElement(), dxDrawClick)
				end
			)
			Intro:start()
		end
	end
end

function joinHandler(status, n_, tblSounds, sKey)
	loadingSprite:setEnabled(false);

	if (status == 0) then
		-- Nicht registriert ! Intro + Register Window !
		Intro:setEndFunc(
			function()
				guiSetVisible ( Register_Image[1], true)
				guiBringToFront ( Register_Image[1] )
				loginCamDrive ()
				guiSetInputEnabled(true)
				showCursor ( true )
				fadeCamera ( false,0,0,0,0)
				fadeCamera ( true, 5)
				showPlayerHudComponent ( "all", false)
				hud:Toggle(false)
				_G["Loginsound"] = playSound("http://www.vio-race.de/servermusic/mapmusic/realsteel-ft-banana_dark-time.mp3",true)
				--_G["Loginsound"] = playSound("http://rewrite.ga/iLife/intro.mp3",true)
				setGameSpeed(1)
				addEventHandler("onClientRender", getRootElement(), dxDraw)
			end
		)
		Intro:start()
	else
		if(usingNewLogin == false) then

			Login["Window"]:show()
			loginCamDrive ()
			guiSetInputEnabled(true)
			showCursor ( true )
			fadeCamera ( false,0,0,0,0)
			fadeCamera ( true, 5)
			showPlayerHudComponent ( "all", false)
		    hud:Toggle(false)
			--_G["Loginsound"] = playSound("http://rewrite.ga/iLife/intro.mp3",true)
			_G["Loginsound"] = playSound("http://www.vio-race.de/servermusic/mapmusic/realsteel-ft-banana_dark-time.mp3",true)
			addEventHandler("onClientRender", getRootElement(), dxDraw)
			addEventHandler("onClientClick", getRootElement(), dxDrawClick)
			setGameSpeed(1)
			guiSetInputEnabled(true);

		else
			mainMenu:Start(tblSounds, sKey);
		end

	end
end
addEvent("playerJoin", true)
addEventHandler("playerJoin", getRootElement(), joinHandler)

function onRegisterClickBtn ( button, state )
	if (button == "left" and state == "up") then
		if (source == Register_Button[1]) then

			-- Gui Daten abfangen
			name = guiGetText( Register_Edit[1] )
			email = guiGetText( Register_Edit[2] )
			password = guiGetText( Register_Edit[3] )
			geburtsdatum = guiGetText( Register_Edit[7] ).."-"..guiGetText( Register_Edit[6] ).."-"..guiGetText( Register_Edit[5] )

			if (guiRadioButtonGetSelected(Register_Radio[2]) == true) then
				geschlecht = 1
			else
				geschlecht = 0
			end

			--Validation
			fehler = false
			if (name ~= getPlayerName(getLocalPlayer())) then
				fehler = true
				fehlertext = "Du kannst dich nicht mit einem anderen Namen registrieren!"
			end
			if (#name <3 or #name>16) then
				fehler = true
				fehlertext = "Dein Benutzername ist zu lang oder zu kurz!"
			end

			if (guiGetText(Register_Edit[4]) ~= password) then
				fehler = true
				fehlertext = "Die eingegebenen Passwörter stimmen nicht überein!"
			end

			if ( (gettok ( email, 2, "@" ) == false) or (gettok ( gettok ( email, 2, "@" ), 2, "." ) == false) or (gettok ( gettok ( email, 2, "@" ), 1, "." ) == "trashmail" )) then
				fehler = true
				fehlertext = "Es wurde eine ungültige E-Mail Adresse eingegeben!"
			end

			if (#password <5 or #password >16) then
				fehler = true
				fehlertext = "Ihr gewähltes Passwort ist zu lang oder zu kurz!"
			end
			if ( (tonumber(guiGetText(Register_Edit[7])) < 1950) or (tonumber( guiGetText(Register_Edit[7] )) > 2012) or (tonumber( guiGetText(Register_Edit[6])) > 12) or (tonumber(guiGetText(Register_Edit[6]))<1) or  (tonumber(guiGetText(Register_Edit[5]))<1) or (tonumber(guiGetText(Register_Edit[6]))>31)) then
				fehler = true
				fehlertext = "Geben sie bitte ein gültiges Geburtsdatum an!"
			end
			if (LoginAttempt) then
				fehler = true
				fehlertext = "Bitte warten...!"
			end

			if (fehler == true) then
				showInfoBox("error",fehlertext)
			else
				-- Registration triggern
				password = string.gsub(password, '<', '')
				password = string.gsub(password, '>', '')
				password = string.gsub(password, '|', '')
				password = string.gsub(password, '°', '')
				password = string.gsub(password, '^', '')
				triggerServerEvent ( "onPlayerRegister", getLocalPlayer(),string.gsub(name, '#%x%x%x%x%x%x', ''), email, password, geburtsdatum, geschlecht)
				LoginAttempt = true
			end

		end
	end
end



addEventHandler("onClientResourceStart", getRootElement(),
	function(startedResource)
		if (startedResource == getThisResource()) then
			addEventHandler( "onClientGUIClick",Register_Button[1], onRegisterClickBtn, false )
		end
	end
)

--[[
function onEnterLogin ( button, state, LoginUsername )
	triggerServerEvent ( "onPlayerLogin", getLocalPlayer(),guiGetText(Login_Edit[1]) )
end
addEventHandler( "onClientGUIAccepted",Login_Edit[1], onEnterLogin,false)
]]

LoggedIn = false
function hideLoginWindow(register, justvisual)

	if (justvisual) then
		if (isElement(_G["Loginsound"])) then
			destroyElement(_G["Loginsound"])
		end
		showPlayerHudComponent ( "all", false)
		guiSetInputEnabled(false)
		Login["Window"]:hide()
		destroy(Login["Window"])
		guiSetVisible ( Register_Image[1], false )
		showCursor ( false )
		removeEventHandler ( "onClientRender", getRootElement(), camRender )
		cancelCameraIntro ()
		removeEventHandler("onClientRender", getRootElement(), dxDraw)
		removeEventHandler("onClientClick", getRootElement(), dxDrawClick)
		setGameSpeed(1)
		hud:Toggle(false);
		return true
	end
	if(usingNewLogin == false) or register then

		if (isElement(_G["Loginsound"])) then
			destroyElement(_G["Loginsound"])
		end
		showPlayerHudComponent ( "all", false)
		guiSetInputEnabled(false)
		--guiSetVisible ( Login_Window[1], false )
		Login["Window"]:hide()
		destroy(Login["Window"])
		guiSetVisible ( Register_Image[1], false )
		showCursor ( false )
		removeEventHandler ( "onClientRender", getRootElement(), camRender )
		cancelCameraIntro ()
		removeEventHandler("onClientRender", getRootElement(), dxDraw)
		removeEventHandler("onClientClick", getRootElement(), dxDrawClick)
		setGameSpeed(1)
	    showPlayerHudComponent ( "crosshair", true)
		hud:Toggle(true);


	else
		mainMenu:Stop();
		showPlayerHudComponent ( "crosshair", true)


    end

    if(toboolean(config:getConfig("save_password"))) then
        if(_Gsettings.currentPasswordNew) then
            config:setConfig("saved_password", _Gsettings.currentPasswordNew)
        end
    end
	hud:Toggle(true);

	showCursor ( false )
	Login["Window"]:hide()
	guiSetVisible ( Register_Image[1], false )

	LoggedIn = true
end
addEvent( "hideLoginWindow", true )
addEventHandler( "hideLoginWindow", getRootElement(), hideLoginWindow )

-- Kameraflug --
function loginCamDrive1 () -- 1 & 2

	local x1, y1, z1 = 1495.1999511719,-1636.8000488281,16.89999961853
	local x2, y2, z2 = 1525.0999755859,-1661.5999755859,14.199999809265
	local x1t, y1t, z1t = 1525.0999755859,-1661.5999755859,14.199999809265
	local x2t, y2t, z2t = 1526,-1725.5999755859,14.199999809265
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive2, time + 5, 1 )
end

function loginCamDrive2 () -- 2 & 3

	local x1, y1, z1 = 1525.0999755859,-1661.5999755859,14.199999809265
	local x2, y2, z2 = 1526,-1725.5999755859,14.199999809265
	local x1t, y1t, z1t = 1526,-1725.5999755859,14.199999809265
	local x2t, y2t, z2t = 1590.8000488281,-1753.4000244141,16.700000762939
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive3, time + 5, 1 )
end

function loginCamDrive3 () -- 3 & 4

	local x1, y1, z1 = 1526,-1725.5999755859,14.199999809265
	local x2, y2, z2 = 1590.8000488281,-1753.4000244141,16.700000762939
	local x1t, y1t, z1t = 1590.8000488281,-1753.4000244141,16.700000762939
	local x2t, y2t, z2t = 1657.8000488281,-1769,6.1999998092651
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive4, time + 5, 1 )
end

function loginCamDrive4 () -- 4 & 5

	local x1, y1, z1 = 1590.8000488281,-1753.4000244141,16.700000762939
	local x2, y2, z2 = 1657.8000488281,-1769,6.1999998092651
	local x1t, y1t, z1t = 1657.8000488281,-1769,6.1999998092651
	local x2t, y2t, z2t = 1844.0999755859,-1812.5,6.1999998092651
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive5, time + 5, 1 )
end

function loginCamDrive5 () -- 5 & 6

	local x1, y1, z1 = 1657.8000488281,-1769,6.1999998092651
	local x2, y2, z2 = 1844.0999755859,-1812.5,6.1999998092651
	local x1t, y1t, z1t = 1844.0999755859,-1812.5,6.1999998092651
	local x2t, y2t, z2t = 1899.8000488281,-1825.9000244141,28
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive6, time + 5, 1 )
end

function loginCamDrive6 () -- 6 & 7

	local x1, y1, z1 = 1844.0999755859,-1812.5,6.1999998092651
	local x2, y2, z2 = 1899.8000488281,-1825.9000244141,28
	local x1t, y1t, z1t = 1899.8000488281,-1825.9000244141,28
	local x2t, y2t, z2t = 1910.0999755859,-1739.8000488281,14.5
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive7, time + 5, 1 )
end

function loginCamDrive7 () -- 7 & 8

	local x1, y1, z1 = 1899.8000488281,-1825.9000244141,28
	local x2, y2, z2 = 1910.0999755859,-1739.8000488281,14.5
	local x1t, y1t, z1t = 1910.0999755859,-1739.8000488281,14.5
	local x2t, y2t, z2t = 1918.9000244141,-1593.8000488281,30.799999237061
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive8, time + 5, 1 )
end

function loginCamDrive8 () -- 8 & 9

	local x1, y1, z1 = 1910.0999755859,-1739.8000488281,14.5
	local x2, y2, z2 = 1918.9000244141,-1593.8000488281,30.799999237061
	local x1t, y1t, z1t = 1918.9000244141,-1593.8000488281,30.799999237061
	local x2t, y2t, z2t = 1860.5,-1601.5999755859,24.799999237061
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive9, time + 5, 1 )
end

function loginCamDrive9 () -- 9 & 10

	local x1, y1, z1 = 1918.9000244141,-1593.8000488281,30.79999923706
	local x2, y2, z2 = 1860.5,-1601.5999755859,24.799999237061
	local x1t, y1t, z1t = 1860.5,-1601.5999755859,24.799999237061
	local x2t, y2t, z2t = 1777.5999755859,-1601.3000488281,16.299999237061
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive10, time + 5, 1 )
end

function loginCamDrive10 () -- 10 & 11

	local x1, y1, z1 = 1860.5,-1601.5999755859,24.799999237061
	local x2, y2, z2 = 1777.5999755859,-1601.3000488281,16.299999237061
	local x1t, y1t, z1t = 1777.5999755859,-1601.3000488281,16.299999237061
	local x2t, y2t, z2t = 1671.9000244141,-1592.9000244141,20
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive11, time + 5, 1 )
end

function loginCamDrive11 () -- 11 & 12

	local x1, y1, z1 = 1777.5999755859,-1601.3000488281,16.299999237061
	local x2, y2, z2 = 1671.9000244141,-1592.9000244141,20
	local x1t, y1t, z1t = 1671.9000244141,-1592.9000244141,20
	local x2t, y2t, z2t = 1646.5,-1599,40.799999237061
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive12, time + 5, 1 )
end

function loginCamDrive12 () -- 12 & 13

	local x1, y1, z1 = 1671.9000244141,-1592.9000244141,20
	local x2, y2, z2 = 1646.5,-1599,40.799999237061
	local x1t, y1t, z1t = 1646.5,-1599,40.799999237061
	local x2t, y2t, z2t = 1598.3000488281,-1543.9000244141,78.099998474121
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive13, time + 5, 1 )
end

function loginCamDrive13 () -- 13 & 14

	local x1, y1, z1 = 1646.5,-1599,40.799999237061
	local x2, y2, z2 = 1598.3000488281,-1543.9000244141,78.099998474121
	local x1t, y1t, z1t = 1598.3000488281,-1543.9000244141,78.099998474121
	local x2t, y2t, z2t = 1495.1999511719,-1636.8000488281,16.89999961853
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive14, time + 5, 1 )
end

function loginCamDrive14 () -- 14 & 1

	local x1, y1, z1 = 1598.3000488281,-1543.9000244141,78.099998474121
	local x2, y2, z2 = 1495.1999511719,-1636.8000488281,16.89999961853
	local x1t, y1t, z1t = 1495.1999511719,-1636.8000488281,16.89999961853
	local x2t, y2t, z2t = 1525.0999755859,-1661.5999755859,14.199999809265
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive1, time + 5, 1 )
end

function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )

	object1 = createObject ( 367, x1, y1, z1 )
	object2 = createObject ( 367, x1t, y1t, z1t )
	setElementAlpha ( object1, 0 )
	setElementAlpha ( object2, 0 )
	moveObject ( object1, time, x2, y2, z2 )
	moveObject ( object2, time, x2t, y2t, z2t )

	addEventHandler ( "onClientRender", getRootElement(), camRender )
	setTimer ( removeCamHandler, time, 1 )
	setTimer (
		function()
			if (isElement(object1)) then
				destroyElement(object1)
			end
			if (isElement(object2)) then
				destroyElement(object2)
			end
		end
	, time, 1)
end

function removeCamHandler ()

	removeEventHandler ( "onClientRender", getRootElement(), camRender )
end

function camRender ()

	if not getCameraTarget ( lp ) then
		local x1, y1, z1 = getElementPosition ( object1 )
		local x2, y2, z2 = getElementPosition ( object2 )
		setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
	else
		removeCamHandler ()
		end
end

function cancelCameraIntro ()

	removeEventHandler ( "onClientRender", getRootElement(), camRender )
	if ( isElement(object1) ) then
		destroyElement ( object1 )
	end

	if ( isElement(object2) ) then
		destroyElement ( object2 )
	end

	if isTimer ( cameraTimer ) then
		killTimer ( cameraTimer )
	end
end

function loginCamDrive ()

	speedfactor = getDistanceBetweenPoints3D ( -2681.7158203125, 1934.0498046875, 216.9231262207, -2682.2709960938, 1825.5369873047, 152.13279724121 ) / 10000
	loginCamDrive1 ()
end
