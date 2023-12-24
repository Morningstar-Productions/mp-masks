local function MaskOn(data, slot)
    local metadata = slot.metadata
    if metadata.drawableId == nil then print("This mask has no data. Do not spawn it in. Instead go to a clothing store then remove the mask") end
    if GetPedDrawableVariation(cache.ped, 1) ~= 0 then exports.qbx_core:Notify("You are already wearing a mask", "error") return end

    if lib.progressCircle({
        label = "Putting Mask On..",
        duration = 500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        anim = { dict = "mp_masks@standard_car@ds@", clip = "put_on_mask", flag = 49 }
    }) then
        exports.ox_inventory:useItem(data, function(data)
            if data then
                metadata = data.metadata
                SetPedComponentVariation(cache.ped, 1, metadata.drawableId, metadata.textureId)

                if GetResourceState('illenium-appearance') ~= 'started' then return end
                local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
                TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
            end
        end)
    else
        return
    end
end
exports('mask', MaskOn)

local function MaskOff(mask, tex)
    if GetPedDrawableVariation(cache.ped, 1) == 0 then exports.qbx_core:Notify("You are not wearing a mask", "error") return end

    if lib.progressCircle({
        label = "Taking Mask Off..",
        duration = 500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        anim = { dict = "missfbi4", clip = "takeoff_mask", flag = 49 }
    }) then
        SetPedComponentVariation(cache.ped, 1, 0)
        TriggerServerEvent("mp-masks:server:GiveMaskItem", mask, tex)

        if GetResourceState('illenium-appearance') ~= 'started' then return end
        local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
        TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
    end
end

local function ToggleMask()
    local mask = GetPedDrawableVariation(cache.ped, 1)
    local tex = GetPedTextureVariation(cache.ped, 1)

    local hasMask = exports.ox_inventory:Search('count', 'mask')

    print('check for work')

    if mask == 0 then
        if hasMask >= 1 then
            MaskOn()
        else
            exports.qbx_core:Notify("You don\'t have a mask", "error")
        end
    else
        MaskOff(mask, tex)
    end
end

RegisterCommand("mask", function()
    ToggleMask()
end, false)