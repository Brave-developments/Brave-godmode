QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('toggleGodMode')
AddEventHandler('toggleGodMode', function(godModeStatus)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if QBCore.Functions.HasPermission(src, "admin") then
        -- Fetch the player's name
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

        -- Trigger the client event to toggle god mode and send the player's name
        TriggerClientEvent('setGodMode', src, godModeStatus, playerName)
    else
        -- Notify the player if they don't have the required permission
        TriggerClientEvent('QBCore:Notify', src, "You do not have permission to use this command.", 'error')
    end
end)
