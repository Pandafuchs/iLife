-- #######################################
-- ## Project: 		 iLife				##
-- ## For MTA: San Andreas				##
-- ## Name: Script.lua		        	##
-- ## Author: Noneatme(Gunvarrel)		##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

cConfig_ModList = inherit(cConfiguration);

--[[

]]

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cConfig_ModList:constructor(...)
    -- Klassenvariablen --


    -- Funktionen --


    -- Events --
    cConfiguration.constructor(self, "cfg/modlist.xml");
end

-- EVENT HANDLER --
