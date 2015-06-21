-- #######################################
-- ## Project: MTA iLife				##
-- ## Name: CustomWorldTextures.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

CustomWorldTextures = {};
CustomWorldTextures.__index = CustomWorldTextures;

addEvent("onClientDownloadFinnished", true);
--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function CustomWorldTextures:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// LoaderCustomWorldTextures
-- ///// Returns: void		//////
-- ///////////////////////////////

function CustomWorldTextures:LoadCustomWorldTextures()
	for index, tex in pairs(self.tex) do
		if(fileExists(self.pfade.textures..tex)) then
			self.shaders[tex] = dxCreateShader(self.pfade.shaders.."texture.fx");
			dxSetShaderValue(self.shaders[tex], "Tex", dxCreateTexture(self.pfade.textures..tex));
			local tex2 = tex;
			for index, d in pairs(self.gsubs) do
				tex2 = string.gsub(tex2, d, "");
			end
			engineApplyShaderToWorldTexture(self.shaders[tex], tex2)
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CustomWorldTextures:Constructor(...)
	-- Klassenvariablen --
	
	self.gsubs				= 
	{".jpg", ".png"}
	
	self.tex				=
	{"veding1_64.png", "veding2_64.png", "vgsn_scrollsgn.png", "plateback1.png", "plateback2.png", "plateback3.png", "platecharset.png", "newsvan92decal128.png", "cj_hi_fi_1.png", "petroltr92decal256.png", "ammo_bx.png", "frate64_blue.jpg", "frate64_red.jpg", "frate64_yellow.jpg", "frate_doors64yellow.jpg", "frate_doors128red.jpg", "frate_doors64.jpg", "SNIPERcrosshair.png"};
	
	
	
	self.pfade				= {};
	self.pfade.textures 	= "res/textures/objects/";
	self.pfade.shaders		= "res/shader/";
	
	self.shaders			= {}
	
	-- Methoden --
	self.replaceTex			= function(...) self:LoadCustomWorldTextures(...) end;
	
	-- Events --
	addEventHandler("onClientDownloadFinnished", getLocalPlayer(), self.replaceTex)
	--logger:OutputInfo("[CALLING] CustomWorldTextures: Constructor");
end

-- EVENT HANDLER --
