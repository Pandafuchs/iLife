-- #######################################
-- ## Project: 	HUD iLife				##
-- ## For MTA: San Andreas				##
-- ## Name: TrainCrossManager.lua		##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

TrainCrossManager = {};
TrainCrossManager.__index = TrainCrossManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function TrainCrossManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Render				//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function TrainCrossManager:Render()
	-- Linie bei dem Kran am Hauptbanhof Los Santos

	
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function TrainCrossManager:Constructor(...)

	-- Container der Gefroren ist --

    
	-- Klassenvariablen --
	self.objectID 	= 973;
	self.radius 	= 200;
	
	self.crosses = 
	{
		-- Vom Tunnel, LS --
		TrainCrossing:New({self.objectID, 2281.3999023438, -1149.5, 26.60000038147, 0, 0, 89.989013671875}, {self.objectID, 2292.6000976563, -1149.6999511719, 26.60000038147, 0, 0, 269.99450683594}, self.radius),
		
		TrainCrossing:New({self.objectID, 2281.5, -1384.0999755859, 23.89999961853, 0, 0, 90}, {self.objectID, 2292.69921875, -1384.099609375, 24, 0, 0, 270}, self.radius),
		TrainCrossing:New({self.objectID, 2207.5, -1646.3000488281, 15.10000038147, 0, 0, 75.997436523438}, {self.objectID, 2218.3994140625, -1648.8994140625, 15.10000038147, 0, 0, 255.99792480469}, self.radius),
		TrainCrossing:New({self.objectID, 2195.3000488281, -1733.5999755859, 13.199999809265, 0, 0, 90}, {self.objectID, 2206.3000488281, -1732.6999511719, 13.199999809265, 0, 0, 270}, self.radius),
		TrainCrossing:New({self.objectID, 2194.6000976563, -1894.5, 13.60000038147, 0, 0, 90}, {self.objectID, 2206.6000976563, -1894.4000244141, 13.5, 0, 0, 270}, self.radius),
		TrainCrossing:New({self.objectID, 1961.8000488281, -1961.6999511719, 13.60000038147, 0, 0, 180}, {self.objectID, 1961.9000244141, -1950.1999511719, 13.60000038147, 0, 0, 0}, self.radius),
		TrainCrossing:New({self.objectID, 2269.80005, -1483.90002, 22.4, 0, 0, 75.998}, {self.objectID, 2280.6001, -1484.09998, 22.4, 0, 0, 256}, self.radius),
		

		-- Docks --
		TrainCrossing:New({self.objectID, 2257.3000488281, -2106.5, 13.60000038147, 0, 0, 135.49987792969}, {self.objectID, 2264.3000488281, -2099.5, 13.60000038147, 0, 0, 315.5}, self.radius),
		TrainCrossing:New({self.objectID, 2272.1999511719, -2238.6000976563, 13.60000038147, 0, 0, 45.494384765625}, {self.objectID, 2279.3000488281, -2245.8000488281, 13.60000038147, 0, 0, 225.5}, self.radius),
		
		
		--TrainCrossing:New({self.objectID, }, {self.objectID, }, self.radius),
		
	}
	
	-- Events --
	
	self.renderFunc = function() self:Render() end
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	--outputDebugString("[CALLING] TrainCrossManager: Constructor");
end

-- EVENT HANDLER --
