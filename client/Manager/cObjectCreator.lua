--
-- Created by IntelliJ IDEA.
-- User: Noneatme
-- Date: 21.12.2014
-- Time: 22:07
-- To change this template use File | Settings | File Templates.
--

cObjectCreator = {};

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function cObjectCreator:new(...)
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

function cObjectCreator:constructor(...)
	-- Klassenvariablen --

	hud = Hud:New()


	triggerEvent("onClientDownloadFinnished", localPlayer)
	-- Funktionen --


	-- Events --

end

-- EVENT HANDLER --




cObjectCreator:new()
