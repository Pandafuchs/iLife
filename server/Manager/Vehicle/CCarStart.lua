-- #######################################
-- ## Project: 	HUD iLife				##
-- ## For MTA: San Andreas				##
-- ## Name: CarStart.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

CarStart = {};
CarStart.__index = CarStart;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function CarStart:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Toggle		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CarStart:Toggle(player, key, state)
	local vehicle = getPedOccupiedVehicle(player)
	if(isPedInVehicle(player)) and (getVehicleOccupant(getPedOccupiedVehicle(player)) == player) and (vehicle) then

		if(state == "down") then
			if(getVehicleEngineState(vehicle) ~= true) then
				if not(self.vehicleStarting[vehicle]) then
					self.vehicleStarting[vehicle] = true;
				end

				local ammount = 800;

				if(math.random(0, 20) == 1) then
					ammount = math.random(1500, 4000);
				end
				self.vehicleStartTimer[vehicle] = setTimer(self.startVehicle, ammount, 1, player, vehicle, class)
				triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_start");
			else

				vehicle:switchEngine(player)

				triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_absauf");
			end
		else
			if(self.vehicleStarting[vehicle] == true) then
				self.vehicleStarting[vehicle] = false;
				if(isTimer(self.vehicleStartTimer[vehicle])) then
					killTimer(self.vehicleStartTimer[vehicle]);
				end
				triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_absauf");
			end
		end
	end
end

-- ///////////////////////////////
-- ///// StartVehicle 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CarStart:StartVehicle(player, vehicle)
	if (vehicle:getFuel() <= 0) then
		triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_absauf");
		self.vehicleStarting[vehicle] = false;
		self.vehicleEngine[vehicle] = false;
		return false
	end
	if(math.random(0, 10) ~= 1) then
		local sucess = vehicle:switchEngine(player)
		if(sucess ~= "nope") then
			triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_start_go");
			self.vehicleStarting[vehicle] = false;
			self.vehicleEngine[vehicle] = true;
		end
	else
		triggerClientEvent(getRootElement(), "onVehicleStartSound", getRootElement(), vehicle, "engine_absauf");
		self.vehicleStarting[vehicle] = false;
		self.vehicleEngine[vehicle] = false;
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CarStart:Constructor(...)
	self.toggleVehicle = function(player, key, state) self:Toggle(player, key, state) end;
	self.startVehicle	= function(player, vehicle) self:StartVehicle(player, vehicle) end;

	self.vehicleStartTimer = {}
	self.vehicleStarting = {}

	self.vehicleEngine = {}

	--[[
	for index, player in pairs(getElementsByType("player")) do
	bindKey(player, "x", "both", self.toggleVehicle)
	end
	]]
	--outputDebugString("[CALLING] CarStart: Constructor");
end

-- EVENT HANDLER --
