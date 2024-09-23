local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('toggleGodMode')
AddEventHandler('toggleGodMode', function(godModeStatus)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        TriggerClientEvent('QBCore:Notify', src, "Player data not found.", 'error')
        return
    end

    if QBCore.Functions.HasPermission(src, "admin") then
        -- Fetch the player's name
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

     
        TriggerClientEvent('setGodMode', -1, src, godModeStatus, playerName)  
        print(("[GodMode] %s (%s) toggled God Mode: %s"):format(playerName, src, tostring(godModeStatus)))
    else
       
        TriggerClientEvent('QBCore:Notify', src, "You do not have permission to use this command.", 'error')
    end
end)
