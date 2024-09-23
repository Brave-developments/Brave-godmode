local godModeEnabled = false

-- Listen for the 'setGodMode' event from the server
RegisterNetEvent('setGodMode')
AddEventHandler('setGodMode', function(enable)
    godModeEnabled = enable
    SetPlayerInvincible(PlayerId(), godModeEnabled)
    
    -- Visual indicator by setting alpha
    local alpha = godModeEnabled and 150 or 255
    SetEntityAlpha(PlayerPedId(), alpha, false)

    -- Create a thread to keep the player invincible while godModeEnabled is true
    if godModeEnabled then
        Citizen.CreateThread(function()
            while godModeEnabled do
                Wait(0)
                SetPlayerInvincible(PlayerId(), true)
            end
            -- When godModeEnabled is turned off, disable invincibility
            SetPlayerInvincible(PlayerId(), false)
        end)
    end
end)

-- Function to draw "Administrator" text above player
function DrawTextOverPlayer()
    local text = "Administrator"
    local name = GetPlayerName(PlayerId())
    local ped = PlayerPedId()
    local headPos = GetPedBoneCoords(ped, 12844, 0.0, 0.0, 0.0)
    local onScreen, _x, _y = World3dToScreen2d(headPos.x, headPos.y, headPos.z + 0.6)

    if onScreen then
        -- Draw "Administrator" in red
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 0, 0, 215)
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        -- Draw the player's name in white
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)  -- White color for the player's name
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(name)
        EndTextCommandDisplayText(_x, _y + 0.015)  -- Adjust position
    end
end

-- Main loop to continuously draw text when God Mode is enabled
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if godModeEnabled then
            DrawTextOverPlayer()
        end
    end
end)

-- Register the /godmode command to toggle the God Mode
RegisterCommand('godmode', function(source, args, rawCommand)
    godModeEnabled = not godModeEnabled
    TriggerServerEvent('toggleGodMode', godModeEnabled)
end, false)
