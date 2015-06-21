DriveIns = {}
CDriveIn = {}

 --[[///
	Klasse: CDriveIn
	Attribute:
		ID : INT(21)
		Type : INT (21)
			//Definition:
			= 1 // Burgershot
			= 2 // CluckinBell
			= 3 // Donuts
			= 4 // Well Stacked Pizza
			= 5 // Petrol Station
		X : Float()
		Y : Float()
		Z : Float
 ]]-----

function CDriveIn:constructor(ID, Type,X,Y,Z, iFiliale)
	self.ID = ID
	self.Type = Type
	self.X = X
	self.Y = Y
	self.Z = Z
    self.Filiale = (tonumber(iFiliale))

	DriveIns[self.ID] = self

	self.eOnHit = bind(CDriveIn.onHit, self)
	addEventHandler("onMarkerHit", self, self.eOnHit)
end

function CDriveIn:onHit(vehicle, matching)
	if (matching) then
        if getElementType(vehicle) == "vehicle" then

			setElementVelocity(vehicle, 0, 0, 0)

			local driver = getVehicleOccupant(vehicle)
			if(driver) then
	            driver.TankstellenID = self.Filiale

				if (self.Type == 1) then
					triggerClientEvent(driver, "onItemShopOpen", driver, 4)
					return true
				end
				if (self.Type == 2) then
					triggerClientEvent(driver, "onItemShopOpen", driver, 5)
					return true
				end
				if (self.Type == 3) then
					triggerClientEvent(driver, "onItemShopOpen", driver, 6)
					return true
				end
				if (self.Type == 4) then
					triggerClientEvent(driver, "onItemShopOpen", driver, 7)
					return true
				end
				if (self.Type == 5) then
					triggerClientEvent(driver, "PetrolstationGuiOpen", driver)
					return true
				end
			end
        end
	end
end


addEvent("onClientFillVehicle", true)
addEventHandler("onClientFillVehicle", getRootElement(),
	function(amount)
		if (isPedInVehicle(client)) then

            local canBuy            = true;
            local bizPurchase       = false;
            local biz;
            local einheitenCost     = 0;

            local fil               = client.TankstellenID

            if(fil) and (fil ~= 0) then
                if(cBusinessManager:getInstance().m_uBusiness[fil]) then
                    biz = cBusinessManager:getInstance().m_uBusiness[fil];

                    einheitenCost	= math.floor((amount*biz:getLagereinheitenMultiplikator()))

            		if(biz:getLagereinheiten() >= einheitenCost) then
            			canBuy 			= true;
            			bizPurchase 	= true;
            		else
            			canBuy = false;
            			client:showInfoBox("error", "Diese Tankstelle ist leer! Sie muss erst wieder aufgefuellt werden.")
            		end
                end
            end
            if(canBuy) then
                local money = amount*3
    			if (getElementData(getPedOccupiedVehicle(client), "Fraktion") or client:payMoney(money)) then
    				local veh = getPedOccupiedVehicle(client)
    				veh:setFuel(veh:getFuel()+amount)
    				client:showInfoBox("info", "Du hast ein Fahrzeug betankt!")


                    if(bizPurchase) and not(getElementData(getPedOccupiedVehicle(client), "Fraktion")) then
                        local businessGeld = money
                        biz:addLagereinheiten(-einheitenCost)
        				if(biz:getCorporation() ~= 0) then
        					biz:getCorporation():addSaldo(businessGeld);
        				end
                    end
    			end
            end
		else
			client:showInfoBox("error", "Welches Fahrzeug willst du betanken?")
		end
	end
)
