-- #######################################
-- ## Project: MTA iLife				##
-- ## Name: WeatherIDs.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

WeatherIDs = {};
WeatherIDs.__index = WeatherIDs;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function WeatherIDs:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GetWeatherFromID	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WeatherIDs:GetWeatherFromID(iID)
	for weather, ids in pairs(self.ids) do
		for index, weatherID in pairs(ids) do
			if(weatherID == (tonumber(iID) or 0)) then
				return weather;
			end
		end
	end
	return false;
end

-- ///////////////////////////////
-- GetRandomWeatherIDFromCategory
-- ///// Returns: void		//////
-- ///////////////////////////////

function WeatherIDs:GetRandomWeatherIDFromCategory(sCategory)
	return self.ids[sCategory][math.random(1, #self.ids[sCategory])];
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WeatherIDs:Constructor(...)
	-- Klassenvariablen --
	
	self.ids		= 
	{
		["clear"] 	= {0, 1, 2, 3, 5, 11, 27, 28, 29}, 
		["sunny"] 	= {13, 17, 18, 23, 24, 25, 26, 36}, 
		["cloudy"] 	= {6, 7, 10, 12, 14, 20, 21, 22, 30, 31}, 
		["rainy"] 	= {8, 16}, 
		["foggy"] 	= {4, 9, 19, 32}, 
	
    }

    self.rainyIDS   =
    {
        [8] = true,
        [16] = true,
        [4] = true,
        [9] = true,
        [19] = true,
        [32] = true,
    }
	
	-- Methoden --
	
	
	-- Events --
	
	--logger:OutputInfo("[CALLING] WeatherIDs: Constructor");
end

-- EVENT HANDLER --
