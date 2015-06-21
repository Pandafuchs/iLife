-- #######################################
-- ## Project: 							##
-- ## Name: Script.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings


cFunc["create_objects"] = function()
--	mapManager              = cMapManager:new();

	radialMenuManager 		= RadialMenuManager:New();
	churchBellManager 		= ChurchBellManager:New();
	carStart 				= CarStart:New();
	aussichtsPunkt 			= AussichtsPunkt:New();
	animationManager		= AnimationManager:New();
	tuningGarageManager 	= TuningGarageManager:New();
	boneAttachManager 		= BoneAttachManager:New();
	objectMover				= ObjectMover:New();
	
	if not(DEFINE_DEBUG) then
		moveableObjectLoader	= MoveableObjectLoader:New();
	end
	furnitureRemover		= FurnitureRemover:New();
	mainMenuManager			= MainMenuManager:New();
	customSirenManager		= CustomSirenManager:New();
	carWashManager			= CarWashManager:New();
	offlineMSGManager		= OfflineMSGManager:New();
	
	einkaufszentrum			= Einkaufszentrum:New();

	-- Fraktionen
	-- News
	ofactions				= {};
	ofactions.News			= NewsFaction:New();
	ofactions.Mechanic		= MechanicFaction:New();
	containerJob			= ContainerJob:New();
	sniper					= Sniper:New();
	weatherManager			= WeatherManager:New();

	waffentruckManager      = cWaffentruckManager:new();
	fireworkManager         = cFireworkManager:new();

	DrugCookJob             = new(CDrugCookJob)
end

CObjectCreator = {}
CObjectCreator.public = {}
CObjectCreator.public["create_objects"] = cFunc["create_objects"]

-- EVENT HANDLER --