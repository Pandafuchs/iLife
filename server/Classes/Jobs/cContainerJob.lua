-- #######################################
-- ## Project: MTA iLife				##
-- ## Name: ContainerJob.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}	-- Local Settings

ContainerJob = {}
ContainerJob.__index = ContainerJob

addEvent("onServerContainerJobCrateAbgeb", true)

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function ContainerJob:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end

-- ///////////////////////////////
-- ///// Abgeben	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ContainerJob:Abgeben(uPlayer)
	if not(self.abgegeben[getPlayerName(uPlayer)]) then
		if not(self.container[getPlayerName(uPlayer)]) then
			self.container[getPlayerName(uPlayer)] = 0
		end
		
		self.container[getPlayerName(uPlayer)] = self.container[getPlayerName(uPlayer)]+1
		
		if(self.container[getPlayerName(uPlayer)] < self.maxContainer) then
			uPlayer:incrementStatistics("Job", "Geld_erarbeitet", self.geld)
			uPlayer:addMoney(self.geld)
			self.abgegeben[getPlayerName(uPlayer)] = true
			setTimer(function() self.abgegeben[getPlayerName(uPlayer)] = false end, self.refreshTime, 1)
			
			uPlayer:showInfoBox("sucess", "+ $"..self.geld.."\nFalls keine Container vorhanden sind, musst du auf die neue Lieferung warten.")
		else
			uPlayer:showInfoBox("error", "Du hast dein Maximum von "..self.maxContainer.." Container pro Tag erreicht.")
		end
	else
		uPlayer:showInfoBox("error", "Bitte warte 25 Sekunden nachdem du einen Container abgegeben hast!")
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ContainerJob:Constructor(...)
	-- Klassenvariablen --
	self.refreshTime	= 25000		-- Sicherheit
	self.geld			= 142*getEventMultiplicator()			-- Geld in $
	self.maxContainer	= 75			-- Max. Container / Tag
	
	self.abgegeben		= {}
	
	self.container		= {}
	
	
	self.kran1			= new(CJob,6, "Kranfuehrer - Docks", "2640.9885253906|-2338.4719238281|13.6328125")
	self.kran2			= new(CJob, 7, "Kranfuehrer - Bahnhof", "1938.9680175781|-1966.7340087891|13.546875")
	
	
	-- Methoden --
	self.abgebFunc	= function(...) self:Abgeben(client, ...) end
	
	-- Events --
	addEventHandler("onServerContainerJobCrateAbgeb", getRootElement(), self.abgebFunc)
	--logger:OutputInfo("[CALLING] ContainerJob: Constructor")
end

-- EVENT HANDLER --
