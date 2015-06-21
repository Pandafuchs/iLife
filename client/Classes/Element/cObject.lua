--
-- Created by IntelliJ IDEA.
-- User: Noneatme
-- Date: 23.12.2014
-- Time: 13:36
-- Project: MTA iLife
--

CObject = inherit(CElement)

registerElementClass("object", CObject)

function CObject:constructor()

end

function CObject:destructor()

end

function CObject:setMass(...)
	return setObjectMass(self, ...)
end