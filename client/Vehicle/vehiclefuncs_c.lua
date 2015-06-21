--[[function vehHasRadio(theVehicle)
	if (getElementData(theVehicle,"ExtendedRadio")== 1) then
		return true
	else
		return false
	end
end

--GETTER

function vehGetRadioStream(theVehicle)
	return getElementData(theVehicle, "RadioStream")
end

function vehGetRadioState(theVehicle)
	return getElementData(theVehicle, "RadioChannelState")
end

function vehGetRadioMinDis(theVehicle)
	return getElementData(theVehicle, "RadioMinDis")
end

function vehGetRadioMaxDis(theVehicle)
	return getElementData(theVehicle, "RadioMaxDis")
end

function vehGetRadioVolume(theVehicle)
	return getElementData(theVehicle, "RadioVolume")
end

function vehGetRadioMaxVolume(theVehicle)
	return getElementData(theVehicle, "RadioMaxVolume")
end

function vehGetRadioStarted(theVehicle)
	return getElementData(theVehicle, "RadioStarted")
end

--SETTER

function vehSetRadioStream(theVehicle, value)
	return setElementData(theVehicle, "RadioStream", value)
end

function vehSetRadioState(theVehicle, value)
	return setElementData(theVehicle, "RadioChannelState", value)
end

function vehSetRadioMinDis(theVehicle, value)
	return setElementData(theVehicle, "RadioMinDis", value)
end

function vehSetRadioMaxDis(theVehicle, value)
	return setElementData(theVehicle, "RadioMaxDis", value)
end

function vehSetRadioVolume(theVehicle, value)
	return setElementData(theVehicle, "RadioVolume", value)
end

function vehSetRadioMaxVolume(theVehicle, value)
	return setElementData(theVehicle, "RadioMaxVolume", value)
end

function vehSetRadioStarted(theVehicle, value)
	return setElementData(theVehicle, "RadioStarted", value)
end

--Test


--]]