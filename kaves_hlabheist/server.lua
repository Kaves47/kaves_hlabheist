ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local humainelabsAlarm = false
local toggle = 0
local mincops = 0 -- POLİS SAYISINI BURADAN AYARLAYINIZ
local cevap = false

RegisterNetEvent("kaves_hlab:fixdoor")
AddEventHandler("kaves_hlab:fixdoor", function()
    TriggerClientEvent("kaves_hlab:fixdoor_c", -1)
end)

RegisterNetEvent("kaves_hlab:fixstart")
AddEventHandler("kaves_hlab:fixstart", function()
TriggerClientEvent("kaves_hlab:fixstart_a", -1)
end)

RegisterNetEvent("kaves_hlab:fixstart_b")
AddEventHandler("kaves_hlab:fixstart_b", function()
TriggerClientEvent("kaves_hlab:fixstart_c", -1)
end)

RegisterNetEvent("kaves_hlab:fixstart_d")
AddEventHandler("kaves_hlab:fixstart_d", function()
TriggerClientEvent("kaves_hlab:fixstart_e", -1)
end)

RegisterNetEvent("kaves_hlab:sObject")
AddEventHandler("kaves_hlab:sObject", function()
TriggerClientEvent("kaves_hlab:sObject_a", -1)
end)

RegisterNetEvent("kaves_hlab:fixtext")
AddEventHandler("kaves_hlab:fixtext", function()
TriggerClientEvent("kaves_hlab:fixtext_a", -1)
end)


RegisterNetEvent("kaves_hlab:stop")
AddEventHandler("kaves_hlab:stop", function(cevap)
    cevap = true
TriggerClientEvent("kaves_hlab:stop_a", -1, cevap)
end)

ESX.RegisterUsableItem('oxygen_mask', function(source)
	TriggerClientEvent('kaves_hlab:mask', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('oxygen_mask', 1)
end)

RegisterNetEvent("kaves_hlab:taked")
AddEventHandler("kaves_hlab:taked", function()
TriggerClientEvent("kaves_hlab:taked_a", -1)
end)

RegisterNetEvent("kaves_hlab:elevatoron")
AddEventHandler("kaves_hlab:elevatoron", function()
TriggerClientEvent("kaves_hlab:elevatoron_a", -1)
end)

RegisterNetEvent("kaves_hlab:timer")
AddEventHandler("kaves_hlab:timer", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    Citizen.Wait(2*60000)
    TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kapılar Kapanıyor!'})
    TriggerClientEvent("kaves_hlab:stop_a", -1)
end)

RegisterNetEvent("kaves_hlab:stopped")
AddEventHandler("kaves_hlab:stopped", function()
TriggerClientEvent("kaves_hlab:stopped_a", -1)
end)

RegisterNetEvent("kaves_hlab:again")
AddEventHandler("kaves_hlab:again", function()
Citizen.Wait(30*60000)
TriggerClientEvent("kaves_hlab:again_a", -1)
end)

RegisterServerEvent("kaves_hlab:giveItem")
AddEventHandler("kaves_hlab:giveItem", function(itemname, count)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(itemname, count) then
            xPlayer.addInventoryItem(itemname, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Envanterinde boş yer yok!' })           
    end
end)

ESX.RegisterServerCallback("kaves_hlab:checkItem", function(source, cb, itemname, count)
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemname)["count"]
    if item >= count then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("kaves_hlab:startevent", function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local copcount = 0
    for i = 1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer then
            if xPlayer.job.name == "police" or xPlayer.job.name == "sheriff" then
              copcount = copcount + 1  
            end
        end
    end
    if copcount >= mincops then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("kaves_hlab:removeItem")
AddEventHandler("kaves_hlab:removeItem", function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemname, count)
end)


RegisterServerEvent("kaves_hlab:alarm")
AddEventHandler('kaves_hlab:alarm', function()
    toggle = toggle + 1
    TriggerClientEvent("kaves_hlab:policealert", -1, toggle)
    if humainelabsAlarm == false then
        humainelabsAlarm = true
        TriggerEvent("kaves_hlab:startalarm", -1)
    else humainelabsAlarm = false
        TriggerEvent("kaves_hlab:stopalarm",-1)
    end
end)


RegisterServerEvent("kaves_hlab:startalarm")
AddEventHandler('kaves_hlab:startalarm', function()
TriggerClientEvent("kaves_hlab:startalarmCL", -1)
end)

RegisterServerEvent("kaves_hlab:stopalarm")
AddEventHandler('kaves_hlab:stopalarm', function()
TriggerClientEvent("kaves_hlab:stopalarmCL", -1)
end)