local godModeEnabled = false

RegisterNetEvent('setGodMode')
AddEventHandler('setGodMode', function(enable, playerName)
    godModeEnabled = enable
    SetPlayerInvincible(PlayerId(), godModeEnabled)
    local alpha = godModeEnabled and 150 or 255
    SetEntityAlpha(PlayerPedId(), alpha, false)
end)

function DrawTextOverPlayer(text, name)
    local ped = PlayerPedId()
    local headPos = GetPedBoneCoords(ped, 12844, 0.0, 0.0, 0.0) 
    local onScreen, _x, _y = World3dToScreen2d(headPos.x, headPos.y, headPos.z + 0.6) 
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 0, 0, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        SetTextScale(0.35, 0.35)
        SetTextColour(255, 255, 255, 215)
        AddTextComponentString(name)
        DrawText(_x, _y + 0.025)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if godModeEnabled then
            DrawTextOverPlayer('Administrator', GetPlayerName(PlayerId()))
        end
    end
end)

RegisterCommand('godmode', function(source, args, rawCommand)
    godModeEnabled = not godModeEnabled
    TriggerServerEvent('toggleGodMode', godModeEnabled)
end, false)
