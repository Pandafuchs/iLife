-- #######################################
-- ## Project: 		 iLife				##
-- ## For MTA: San Andreas				##
-- ## Name: cTempomatManager.lua		        	##
-- ## Author: Noneatme(Gunvarrel		##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

cTempomatManager = inherit(cSingleton);

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function cTempomatManager:new(...)
    local obj = setmetatable({}, {__index = self});
    if obj.constructor then
        obj:constructor(...);
    end
    return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function cTempomatManager:constructor(...)
    -- Klassenvariablen --


    -- Funktionen --


    -- Events --
end

-- EVENT HANDLER --
