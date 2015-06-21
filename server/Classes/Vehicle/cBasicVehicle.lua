--
-- Created by IntelliJ IDEA.
-- User: Noneatme
-- Date: 23.12.2014
-- Time: 15:03
-- Project: MTA iLife
--
CBasicVehicle = inherit(CVehicle)

function CBasicVehicle:constructor(id,model,x,y,z,rx,ry,rz)
	self.ID = id
	self.Model = model
	self.X = x
	self.Y = y
	self.Z = z
	self.RX = rx
	self.RY = ry
	self.RZ = rz

	self.openForEveryoneVehicle	= true;

	self.checkPermissionFunc = function(uPlayer)
		if(uPlayer:getOccupiedVehicle() == self) then
			return true;
		end
	end

	--self.switchEngineBla = bind(function(self, player, key, state)  carStart:Toggle(player, key, state, self) end, self);
	CVehicle.constructor(self, "BasicVehicle", false)
end

function CBasicVehicle:destructor()

end