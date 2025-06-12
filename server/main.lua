lib.callback.register('iFox_PedOutfit:GetPlayerHasClothBag', function(source, item)
    return exports.ox_inventory:GetItemCount(source, item) >= 1
end)