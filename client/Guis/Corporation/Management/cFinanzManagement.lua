--
-- Created by IntelliJ IDEA.
-- User: Noneatme
-- Date: 05.02.2015
-- Time: 13:38
-- To change this template use File | Settings | File Templates.
--

cCorporationFinanzManagementGUI = inherit(cSingleton);

--[[

]]



-- ///////////////////////////////
-- ///// show        		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cCorporationFinanzManagementGUI:show(...)
    if not(self.enabled) and not(clientBusy) then
        self:createElements(...)
        self.enabled = true
        clientBusy      = self.enabled
    end
end

-- ///////////////////////////////
-- ///// hide          		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cCorporationFinanzManagementGUI:hide()
    if(self.guiEle["window"]) then
        self.guiEle["window"]:hide();
        delete(self.guiEle["window"])
        self.guiEle["window"] = false;
        self.enabled = false;
        clientBusy      = self.enabled
    end
end

-- ///////////////////////////////
-- ///// createElements		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cCorporationFinanzManagementGUI:createElements(uCorp)
    if(uCorp) then
        self.uCorp = uCorp
    end
    if not(uCorp) then
        uCorp = self.uCorp;
    end
    if not(self.guiEle["window"]) then

        self.guiEle["window"] 	= new(CDxWindow, "Finanzmanagement", 500, 350, true, true, "Center|Middle", 0, 0, {tocolor(125, 125, 255, 255), false, "Finanzmanagement"}, "Hier kannst du die Finanzen deiner Corporation verwalten.")
        self.guiEle["window"].xtraHide = function(...) self:hide(...) end
        self.guiEle["window"]:setCloseClass(cCorporationManagementGUI)

        self.guiEle["list1"]   = new(CDxList, 3, 5, 200, 320, tocolor(255, 255, 255, 255), self.guiEle["window"])

        self.guiEle["list1"]:addColumn("Corporation")
        self.guiEle["list1"]:addColumn("Status", true)

        self.guiEle["label1"]   = new(CDxLabel, "Saldo: $"..uCorp.m_iSaldo, 200, 10, 300, 20, tocolor(255, 255, 255, 255), 1.25, "default-bold", "center", "top", self.guiEle["window"])

        self.guiEle["button1"]  = new(CDxButton, "Geld Einzahlen", 210, 50, 135, 30, tocolor(255, 255, 255, 255), self.guiEle["window"])
        self.guiEle["button2"]  = new(CDxButton, "Geld Auszahlen", 350, 50, 135, 30, tocolor(255, 255, 255, 255), self.guiEle["window"])

        self.guiEle["button3"]  = new(CDxButton, "Geld senden", 210, 90, 135, 30, tocolor(255, 255, 255, 255), self.guiEle["window"])

        self.guiEle["button4"]  = new(CDxButton, "Zinssatz aendern", 210, 170, 135, 30, tocolor(255, 255, 255, 255), self.guiEle["window"])
        self.guiEle["button5"]  = new(CDxButton, "Lohn aendern", 350, 170, 135, 30, tocolor(255, 255, 255, 255), self.guiEle["window"])

        self.guiEle["button1"]:addClickFunction(function()
            local function ja()
                local value     = tonumber(confirmDialog.guiEle["edit"]:getText())
                if(value) and (value > 0) then
                    triggerServerEvent("onClientCorporationFinanzManagerGeldEinzahlen", localPlayer, value)
                else
                    showInfoBox("error", "Ungueltige Eingabe!")
                end
            end

            local function nein()

            end

            confirmDialog:showConfirmDialog("Wieviel Geld (in $) moechtest du einzahlen?", ja, nein, true, true, false)
        end)

        self.guiEle["button2"]:addClickFunction(function()
            local function ja()
                local value     = tonumber(confirmDialog.guiEle["edit"]:getText())
                if(value) and (value > 0) then
                    triggerServerEvent("onClientCorporationFinanzManagerGeldAuszahlen", localPlayer, value)
                else
                    showInfoBox("error", "Ungueltige Eingabe!")
                end
            end

            local function nein()

            end

            confirmDialog:showConfirmDialog("Wieviel Geld (in $) moechtest du auszahlen?", ja, nein, true, true, false)
        end)

        self.guiEle["button3"]:addClickFunction(function()
            local corp          = self.guiEle["list1"]:getRowData(1)
            if(corp ~= "nil") then
                local function ja()
                    local value     = tonumber(confirmDialog.guiEle["edit"]:getText())
                    if(value) and (value > 0) then
                        triggerServerEvent("onClientCorporationFinanzManagerGeldSende", localPlayer, corp, value)
                    else
                        showInfoBox("error", "Ungueltige Eingabe!")
                    end
                end

                local function nein()

                end

                confirmDialog:showConfirmDialog("Wieviel Geld moechtest du an diese Corporation senden?", ja, nein, true, true, false)
            else
                showInfoBox("error", "Du musst eine Corporation auswaehlen!")
            end
        end)

        self.guiEle["button4"]:addClickFunction(function()
            local function ja()
                local value     = tonumber(confirmDialog.guiEle["edit"]:getText())
                if(value) and (value >= 0) and (value <= 100) then
                    triggerServerEvent("onClientCorporationFinanzManagerZinssatzAendere", localPlayer, value)
                else
                    showInfoBox("error", "Ungueltige Eingabe!")
                end
            end

            local function nein()

            end

            confirmDialog:showConfirmDialog("Bitte gebe einen Zinssatz (0-100%) in Prozent an.", ja, nein, true, true, false)
        end)

        self.guiEle["button5"]:addClickFunction(function()
            local function ja()
                local value     = tonumber(confirmDialog.guiEle["edit"]:getText())
                if(value) and (value >= 0) and (value <= 5000) then
                    triggerServerEvent("onClientCorporationFinanzManagerLohnAendere", localPlayer, value)
                else
                    showInfoBox("error", "Ungueltige Eingabe!")
                end
            end

            local function nein()

            end

            confirmDialog:showConfirmDialog("Bitte gebe einen Lohn ein (0-5000$), welcher jedem Spieler bei Payday gezahlt wird! (Wenn genug Geld vorhanden ist.)", ja, nein, true, true, false)
        end)

        for index, ele in pairs(self.guiEle) do
            if(index ~= "window") then
                self.guiEle["window"]:add(ele)
            end
        end

        self.guiEle["window"]:show();

    end
end

-- ///////////////////////////////
-- ///// onGuiRefresh 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cCorporationFinanzManagementGUI:onGuiRefresh(connections, iSaldo)
    if(self.enabled) then
        self.guiEle["list1"]:clearRows()
        self.guiEle["label1"]:setText("Saldo: $"..iSaldo)
        for i = 1, #connections, 1 do
            if(connections[i]) and (connections[i][1]) and (connections[i][2]) then
                local corp1         = connections[i][1].m_sFullName
                local state         = connections[i][2]

                self.guiEle["list1"]:addRow(corp1.."|res/images/corporation/miniicons/connections/"..state..".png,", 1)
            end
        end
    end

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cCorporationFinanzManagementGUI:constructor(...)
    -- Klassenvariablen --

    addEvent("onClientPlayerCorporationFinanzManagementGUIRefresh", true)

    self.guiEle         = {}
    self.enabled        = false;

    -- Funktionen --
    self.m_funcOnRefresh        = function(...) self:onGuiRefresh(...) end

    -- Events --
    addEventHandler("onClientPlayerCorporationFinanzManagementGUIRefresh", getLocalPlayer(), self.m_funcOnRefresh)
end

-- EVENT HANDLER --
