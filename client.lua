local godModeEnabled = false

RegisterNetEvent('setGodMode')
AddEventHandler('setGodMode', function(enable)
    godModeEnabled = enable
    SetPlayerInvincible(PlayerId(), godModeEnabled)
    local alpha = godModeEnabled and 150 or 255
    SetEntityAlpha(PlayerPedId(), alpha, false)
end)

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

        -- Draw the player's name in white, centered below "Administrator"
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)  -- White color for the player's name
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(name)
        EndTextCommandDisplayText(_x, _y + 0.015)  -- Adjust spacing as needed
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if godModeEnabled then
            DrawTextOverPlayer()
        end
    end
end)
RegisterCommand('godmode', function(source, args, rawCommand)
    godModeEnabled = not godModeEnabled
    TriggerServerEvent('toggleGodMode', godModeEnabled)
end, false) -- Restricted to admins
