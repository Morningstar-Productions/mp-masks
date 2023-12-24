RegisterNetEvent('mp-masks:server:GiveHatItem', function(hat, tex)
    if hat == 0 then return end
    local src = source

    local metadata = { drawableId = hat, textureId = tex }
    exports.ox_inventory:AddItem(src, "hat", 1, metadata)
end)

RegisterNetEvent('mp-masks:server:RemoveHatItem', function(item)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)

    if not Player then return end

    exports.ox_inventory:RemoveItem(src, item.name, 1)
end)