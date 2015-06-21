_createBlip = createBlip

createBlip = function(...)
	local blip = _createBlip(...)
	for index, player in pairs(getElementsByType("player")) do
		if(player) and (player.Rank) then
			triggerClientEvent(player, "onHudBlipRefresh", player)
		end
	end
	return blip
end

_createBlipAttachedTo = createBlipAttachedTo

createBlipAttachedTo = function(...)
	local blip = _createBlipAttachedTo(...)
	for index, player in pairs(getElementsByType("player")) do
		if(player) and (player.Rank) then
			triggerClientEvent(player, "onHudBlipRefresh", player)
		end
	end
	return blip
end