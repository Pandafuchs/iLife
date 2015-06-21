-- #######################################
-- ## Project: MTA iLife				##
-- ## Name: FrameTextur.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

FrameTextur = {};
FrameTextur.__index = FrameTextur;

addEvent("onClientDownloadFinnished", true);
--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function FrameTextur:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// ApplyShader 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FrameTextur:ApplyShader()
	self.uShader	= dxCreateShader(self.path.shader.."texture.fx");
	self.uTexture	= dxCreateTexture(self.path.textures..self.sTexturePath);
	dxSetShaderValue(self.uShader, "Tex", self.uTexture);

	-- Apply Shader --
	engineApplyShaderToWorldTexture(self.uShader, self.sTextureName, self.uFrame);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FrameTextur:Constructor(uFrame, sTextureName, sTexturePath)
	-- Klassenvariablen --
	self.uFrame				= uFrame;
	self.sTextureName		= sTextureName;
	self.sTexturePath		= sTexturePath;

	self.path				= {};
	self.path.shader		= "res/shader/";
	self.path.textures		= "res/textures/";

	-- Methoden --
	addEventHandler("onClientDownloadFinnished", getLocalPlayer(), function()

		self:ApplyShader()

	end)
	
	-- Events --

	--logger:OutputInfo("[CALLING] FrameTextur: Constructor");
	end

	-- EVENT HANDLER --
