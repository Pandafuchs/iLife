IntroFrames = {}

CIntroFrame = {}

function CIntroFrame:constructor(iID ,iDuration, fFunction)
	self.ID = iID
	self.Duration = iDuration
	
	self.fFunction = fFunction
	self.fExecute = bind(self.fFunction, self)

	self.Elements = {}
	
	IntroFrames[self.ID] = self
end

function CIntroFrame:destructor()
	for k,v in ipairs(self.Elements) do
		destroyElement(v)
	end
end

function CIntroFrame:run()
	self.fExecute()
end

function CIntroFrame:getDuration()
	return self.Duration
end