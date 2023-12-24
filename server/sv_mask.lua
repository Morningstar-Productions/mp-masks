RegisterNetEvent('mp-masks:server:GiveMaskItem', function(mask, tex)
    if mask == 0 then return end
    local src = source

    local metadata = { drawableId = mask, textureId = tex }
    exports.ox_inventory:AddItem(src, "mask", 1, metadata)
end)

RegisterNetEvent('mp-masks:server:RemoveMaskItem', function(item)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)

    if not Player then return end

    exports.ox_inventory:RemoveItem(src, item.name, 1)
end)