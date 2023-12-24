local function HatOn(data, slot)
    local metadata = slot.metadata
    if metadata.drawableId == nil then print("This mask has no data. Do not spawn it in. Instead go to a clothing store then remove the mask") end
    if GetPedPropIndex(cache.ped, 0) ~= -1 then exports.qbx_core:Notify("You are already wearing a hat", "error") return end

    if lib.progressCircle({
        label = "Putting Hat On..",
        duration = 500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {},
        anim = { dict = "mp_masks@standard_car@ds@", clip = "put_on_mask", flag = 49 }
    }) then
        exports.ox_inventory:useItem(data, function(data)
            if data then
                metadata = data.metadata
                ClearPedProp(cache.ped, 0)
                SetPedPropIndex(cache.ped, 0, metadata.drawableId, metadata.textureId, true)

                if GetResourceState('illenium-appearance') ~= 'started' then return end
                local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
                TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
            end
        end)
    else
        return
    end
end
exports('hat', HatOn)

local function HatOff(hat, tex)
    if GetPedPropIndex(cache.ped, 0) == -1 then exports.qbx_core:Notify("You are not wearing a hat", "error") return end

    if lib.progressCircle({
        label = "Taking Hat Off..",
        duration = 500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {},
        anim = { dict = "missheist_agency2ahelmet", clip = "take_off_helmet_stand", flag = 49 }
    }) then
        ClearPedProp(cache.ped, 0)
        SetPedPropIndex(cache.ped, 0, -1, 0, true)
        TriggerServerEvent("mp-masks:server:GiveHatItem", hat, tex)

        if GetResourceState('illenium-appearance') ~= 'started' then return end
        local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
        TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
    end
end

local function ToggleHat()
    local hat = GetPedPropIndex(cache.ped, 0)
    local tex = GetPedPropTextureIndex(cache.ped, 0)

    local hasHat = exports.ox_inventory:Search('count', 'hat')

    if hat == 0 then
        if hasHat >= 1 then
            HatOn()
        else
            exports.qbx_core:Notify("You don\'t have a hat", "error")
        end
    else
        HatOff(hat, tex)
    end
end

RegisterCommand("hat", function()
    ToggleHat()
end, false)