local godModePlayers = {}
local godModeNames = {}
local godModeEnabled = false

-- The server sends this only to the admin that toggled it, so apply it to ourselves.
-- (The old code compared a server id against PlayerId(), which almost never match.)
RegisterNetEvent('setGodMode')
AddEventHandler('setGodMode', function(enable)
    godModeEnabled = enable
    SetPlayerInvincible(PlayerId(), enable)

    -- Visual indicator for the local player (admin)
    local alpha = enable and 150 or 255
    SetEntityAlpha(PlayerPedId(), alpha, false)
end)

-- Everyone gets the tag info so the name can be drawn over the admin's head
RegisterNetEvent('setGodModeTag')
AddEventHandler('setGodModeTag', function(playerId, enable, playerName)
    godModePlayers[playerId] = enable
    godModeNames[playerId] = playerName
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
                -- name comes from the server event; GetPlayerName can be nil before the ped streams in
                local playerName = godModeNames[playerId] or GetPlayerName(GetPlayerFromServerId(playerId)) or 'Administrator'
                DrawTextOverPlayer(playerId, playerName)
            end
        end
    end
end)


RegisterCommand('godmode', function(source, args, rawCommand)
    godModeEnabled = not godModeEnabled
    TriggerServerEvent('toggleGodMode', godModeEnabled)
end, false)
