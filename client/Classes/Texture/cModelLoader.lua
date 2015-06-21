-- #######################################
-- ## Project: MTA iLife				##
-- ## Name: ModelLoader.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

ModelLoader = {};
ModelLoader.__index = ModelLoader;

addEvent("onClientDownloadFinnished", true)
--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function ModelLoader:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// LoadModels 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ModelLoader:LoadModels()
	for model, id in pairs(self.models) do
		local dff 	= engineLoadDFF("res/models/"..model..".dff", 0);
		local txd	= engineLoadTXD("res/textures/"..model..".txd", true);
		
		engineImportTXD(txd, id);
		engineReplaceModel(dff, id);
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ModelLoader:Constructor(...)
	-- Klassenvariablen --
	self.models =
	{
		["Info_v2"] = 1239,
	};

	-- Methoden --

	addEventHandler("onClientDownloadFinnished", getLocalPlayer(), function()
		self:LoadModels()
	end)

	-- Events --

	--logger:OutputInfo("[CALLING] ModelLoader: Constructor");
end

-- EVENT HANDLER --
