Chains = {}

CChain = {}

function CChain:constructor(iID, sName, iMoney, iValue, iOwner)
	self.ID = iID
	self.Name = sName
	self.Money = iMoney
	self.Value = iValue
	self.Owner = iOwner
	
	Chains[self.ID] = self
end

function CChain:destructor()

end

function CChain:getID()
	return self.ID
end

function CChain:save()
	CDatabase:getInstance():query("UPDATE chains SET Money=?, Value=?, Owner=?", self.Money, self.Value, self.Owner)
end