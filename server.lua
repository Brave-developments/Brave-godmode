QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('toggleGodMode')
AddEventHandler('toggleGodMode', function(godModeStatus)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if QBCore.Functions.HasPermission(src, "admin") then
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        TriggerClientEvent('setGodMode', src, godModeStatus, playerName)
    else
        -- Notify the player they don't have permission
        TriggerClientEvent('QBCore:Notify', src, "You do not have permission to use this command.", 'error')
    end
end)

