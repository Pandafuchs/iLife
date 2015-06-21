-- #######################################
-- ## Project: 		 iLife				##
-- ## For MTA: San Andreas				##
-- ## Name: Script.lua		        	##
-- ## Author: Noneatme(Gunvarrel)		##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

cConfig_Friendlist = inherit(cConfiguration);

--[[

]]

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cConfig_Friendlist:constructor(...)
    -- Klassenvariablen --

    -- Funktionen --

    addEventHandler("onClientPlayerJoin", getRootElement(), function()
        if(source:getName()) then
            if(toboolean(self:getConfig(source:getName()))) then
                showInfoBox("info", source:getName().." ist Online.");
            end
        end
    end)
    addEventHandler("onClientPlayerQuit", getRootElement(), function()
        if(source:getName()) then
            if(toboolean(self:getConfig(source:getName()))) then
                showInfoBox("info", source:getName().." ist Offline.");
            end
        end
    end)
    -- Events --
    cConfiguration.constructor(self, "cfg/friendlist.xml");
end

-- EVENT HANDLER --
