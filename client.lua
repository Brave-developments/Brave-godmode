local godModePlayers = {}


RegisterNetEvent('setGodMode')
AddEventHandler('setGodMode', function(playerId, enable, playerName)
    godModePlayers[playerId] = enable
    
    
    if playerId == PlayerId() then
        SetPlayerInvincible(playerId, enable)
        
        -- Visual indicator for the local player (admin)
        local alpha = enable and 150 or 255
        SetEntityAlpha(PlayerPedId(), alpha, false)
    end
end)


function DrawTextOverPlayer(playerId, playerName)
    local ped = GetPlayerPed(GetPlayerFromServerId(playerId))
    if ped == -1 then return end 

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
        AddTextComponentString("Administrator")
        EndTextCommandDisplayText(_x, _y)

        -- Draw the player's name in white, centered below "Administrator"
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(playerName)
        EndTextCommandDisplayText(_x, _y + 0.015)  
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        
        for playerId, enabled in pairs(godModePlayers) do
            if enabled then
                local playerName = GetPlayerName(GetPlayerFromServerId(playerId))
                DrawTextOverPlayer(playerId, playerName)
            end
        end
    end
end)


RegisterCommand('godmode', function(source, args, rawCommand)
    godModeEnabled = not godModeEnabled
    TriggerServerEvent('toggleGodMode', godModeEnabled)
end, false)
