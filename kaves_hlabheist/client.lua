ESX = nil 

PlayerData = {}

local area = {x = 3532.6,  y = 3674.44,  z = 21.0}
local elevatorCoord = {x = 3541.6,  y = 3674.12,  z = 21.0, h = 249.61}
local elevatorCoord2 = {x = 3541.6,  y = 3674.12,  z = 28.20, h = 249.61}
local hackCoord = {x = 3522.44,  y = 3704.88,  z = 21.0, h = 167.43}
local hackDoor = {x = 3525.24,  y = 3702.56,  z = 21.0, h = 170.0, ha ="v_ilev_bl_doorpool" }
local takeNucleer = {x = 3560.54, y = 3668.7, z = 28.12, h = 168.84}
local biotechCoord = {x = 3560.50, y = 3667.88, z = 28.12, h = 168.53}
local secPanelCoord = {x = 3522.09, y = 3704.82, z = 21.10, h = 171.11}
local door = GetClosestObjectOfType(hackDoor.x, hackDoor.y, hackDoor.z, hackDoor.h, hackDoor.ha, false, false, false)
local lock = false
local start = false --
local look = false
local check = false
local control = false
local elevatorOn = false --
local off = false
local elevatorstart = false
local stop = false
local steps = 0
local receipt = false
local taked = false
local text = false
local sObject = true
local toggle = 0
local stopped = false
local startevent = false
local go = false



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterCommand('test', function()
Nucleer()
Chem()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent("kaves_hlab:again_a")
AddEventHandler("kaves_hlab:again_a", function()
lock = false
start = false --
look = false
check = false
control = false
elevatorOn = false --
off = false
elevatorstart = false
stop = false
steps = 0
receipt = false
taked = false
text = false
sObject = true
toggle = 0
stopped = false
startevent = false
go = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = PlayerPedId()
        local playerCoord = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playerCoord, hackCoord.x, hackCoord.y, hackCoord.z, true)
        local dstElevator = GetDistanceBetweenCoords(playerCoord, elevatorCoord.x, elevatorCoord.y, elevatorCoord.z, true)
        local dstElevator2 = GetDistanceBetweenCoords(playerCoord, elevatorCoord2.x, elevatorCoord2.y, elevatorCoord2.z, true)
        local dstNucleer = GetDistanceBetweenCoords(playerCoord, takeNucleer.x, takeNucleer.y, takeNucleer.z, true)
        local distance = GetDistanceBetweenCoords(playerCoords, area.x, area.y, area.z, true)
        if dst <= 3 and not start then
            DrawText3D(hackCoord.x,hackCoord.y,hackCoord.z+0.40, "~g~[E]~w~ Hack Islemini Baslat ~w~", 0.45)
        end
        if dst <= 3 and start and not look then
            DrawText3D(hackCoord.x,hackCoord.y,hackCoord.z+0.40, "~w~ Kısa zaman önce soygun baslatıldı ", 0.45)
        end
        if dstElevator <= 3 and not elevatorOn and not off and not elevatorstart and start then
            DrawText3D(elevatorCoord.x, elevatorCoord.y, elevatorCoord.z+0.40, "~g~[E]~w~ Kartı Okut ~w~", 0.45)
        end
        if dstElevator <= 3 and elevatorOn and start then
           DrawText3D(elevatorCoord.x, elevatorCoord.y, elevatorCoord.z+0.40, "~g~[E]~w~ Asansörü Kullan ~w~", 0.45)
        end
        if dstElevator2 <= 3 and elevatorOn and start then
            DrawText3D(elevatorCoord2.x, elevatorCoord2.y, elevatorCoord2.z+0.40, "~g~[E]~w~ Asansörü Kullan ~w~", 0.45)
        end
        if dstNucleer <= 3 and elevatorOn and start and not receipt then
            DrawText3D(takeNucleer.x, takeNucleer.y, takeNucleer.z+0.40, "~g~[E]~w~ Ölümcül Virusu Ele Geçir ~w~", 0.45)
        end
        if dstNucleer <= 3 and elevatorOn and start and receipt and not taked and text then
            DrawText3D(takeNucleer.x, takeNucleer.y, takeNucleer.z+0.40, "~g~[E]~w~ Tüpü Al ~w~", 0.45)
        end
        if dstNucleer <= 3 and elevatorOn and start and receipt and taked and text then
            DrawText3D(takeNucleer.x, takeNucleer.y, takeNucleer.z+0.40, "~w~ Tüp Bos Görünüyor ~w~", 0.45)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local sleep = 1500
        local player = PlayerPedId()
        local playerCoord = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playerCoord, hackCoord.x, hackCoord.y, hackCoord.z, true)
        if dst <= 10 and not stop then
            secPanel()
            stop = true
        end
        if dst <= 20 and not lock then
            FreezeEntityPosition(door, true)
            SetEntityHeading(door, 170.0)
        end
        if dst <= 10 then
            sleep = 0
        end
        if ESX.PlayerData.job.name ~= "police" and not start then
            if ESX.PlayerData.job.name ~= "sheriff" and not start then
        if dst <= 3 and not start then
            if IsControlJustPressed(0, 38) then
                ESX.TriggerServerCallback("kaves_hlab:startevent", function(police)
                    if police == true then
                        startevent = true
                    elseif police ~= true then
                        exports["mythic_notify"]:SendAlert("error", "Yeterli Polis Yok")
                    end
                end, 1)
                if startevent then
                ESX.TriggerServerCallback("kaves_hlab:checkItem", function(output)
                    if output then
                        TriggerServerEvent("kaves_hlab:fixstart")
                        TriggerServerEvent("kaves_hlab:removeItem", "laptop_h", 1)
                        SetEntityHeading(player, secPanelCoord.h)

                        check = true
                        Hack()
                    elseif not output then
                        exports['mythic_notify']:SendAlert("error", "Hacker Laptopun Yok")
                    end
                end, "laptop_h", 1)
            end
            end
            end
        end
        end
        Citizen.Wait(sleep)
    end
end)


function Hack()
    look = true
    TriggerEvent("kaves_hlab:disablecontrol", true)
    local animDict = "anim@heists@ornate_bank@hack"
    if check then
    SetFollowPedCamViewMode(4)
    end
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s") 
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Citizen.Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local cardLoc = vector3(3522.52,3704.96,21.99)

    SetEntityHeading(ped, hackCoord.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", hackCoord.x, hackCoord.y, hackCoord.z-0.40, hackCoord.x, hackCoord.y, hackCoord.z-0.45, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", hackCoord.x, hackCoord.y, hackCoord.z-0.40, hackCoord.x, hackCoord.y, hackCoord.z-0.45, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", hackCoord.x, hackCoord.y, hackCoord.z-0.45, hackCoord.x, hackCoord.y, hackCoord.z-0.45, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), cardLoc, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    Citizen.Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Citizen.Wait(2000)
    exports["mythic_notify"]:SendAlert("success", "Hack işlemi başladı 15 saniye sonra sunucuya bağlanacaksın.")
    Citizen.Wait(15000)
    TriggerEvent("utk_fingerprint:Start", 1, 1, 1, function(outcome, reason)
        if outcome == true then
            look = false
            TriggerEvent("kaves_hlab:disablecontrol", false)
            TriggerServerEvent("kaves_hlab:alarm")
            Citizen.Wait(1500)
            NetworkStartSynchronisedScene(netScene3)
            Citizen.Wait(4600)
            check = false
            NetworkStopSynchronisedScene(netScene3)
            exports["mythic_notify"]:SendAlert("success", "Hack işlemi başarıyla tamamlandı kapı açılıyor.")
            DeleteObject(bag)
            DeleteObject(laptop)
            DeleteObject(card)
           if not check then
            SetFollowPedCamViewMode(1)
           end
            FreezeEntityPosition(ped, false)
            SetPedComponentVariation(ped, 5, 45, 0, 0)
            TriggerServerEvent("kaves_hlab:fixdoor")
            Citizen.Wait(100)
            exports["mythic_notify"]:SendAlert("success", "Kapıların kapanmadan 2 dakika süren var.")
            TriggerServerEvent("kaves_hlab:timer")
        elseif outcome == false then
            exports['mythic_notify']:SendAlert("error", "Hack işlemi başarısız! Uzaklaş buradan!")
            TriggerServerEvent("kaves_hlab:stop", true)
            look = false
            TriggerEvent("kaves_hlab:disablecontrol", false)
            TriggerServerEvent("kaves_hlab:again")
            Citizen.Wait(1500)
            NetworkStartSynchronisedScene(netScene3)
            Citizen.Wait(4600)
            check = false
            NetworkStopSynchronisedScene(netScene3)
            DeleteObject(bag)
            DeleteObject(laptop)
            DeleteObject(card)
            if not check then
                SetFollowPedCamViewMode(1)
               end
            FreezeEntityPosition(ped, false)
            SetPedComponentVariation(ped, 5, 45, 0, 0)
        end
    end)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local sleep = 1500
        local player = PlayerPedId()
        local playerCoord = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playerCoord, elevatorCoord.x, elevatorCoord.y, elevatorCoord.z, true)
        local dstElevator2 = GetDistanceBetweenCoords(playerCoord, elevatorCoord2.x, elevatorCoord2.y, elevatorCoord2.z, true)
        if dst <= 10 then
            sleep = 0
        end
        if dst <= 1 and not elevatorOn and not elevatorstart and start then
            if IsControlJustPressed(0, 38) then
                ESX.TriggerServerCallback("kaves_hlab:checkItem", function(output)
                    if output then
                        TriggerServerEvent("kaves_hlab:fixstart_b")
                        TriggerServerEvent("kaves_hlab:removeItem", "id_card", 1)
                        SetEntityHeading(player, elevatorCoord.h)
                        Elevator()
                    elseif not output then
                        exports['mythic_notify']:SendAlert("error", "Personel Kartın Yok")
                    end
                end, "id_card", 1)
            end
        end
        if dst <= 1 and elevatorOn then
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(100)
                Citizen.Wait(1000)
                DoScreenFadeIn(250)
                ESX.Game.Teleport(player,vector3(3540.55,3674.86,28.12))
                SetEntityHeading(player, 166.3)
            end
        end
        if dstElevator2 <= 1 and elevatorOn then
            if IsControlJustPressed(0, 38) then
            DoScreenFadeOut(100)
            Citizen.Wait(1000)
            DoScreenFadeIn(250)
            ESX.Game.Teleport(player,vector3(3540.48,3675.12,20.99))
            SetEntityHeading(player, 166.3)
            end
        end
        Citizen.Wait(sleep)
    end
end)

function Elevator()
    local player = PlayerPedId()
    TaskStartScenarioInPlace(player, "PROP_HUMAN_ATM", 0, false)
    off = true
	Citizen.Wait(2500)
    ClearPedTasks(player)
    Citizen.Wait(6000)
    TriggerServerEvent("kaves_hlab:elevatoron")
    Nucleer()
    Chem()
end

function Nucleer()
    local hash = RequestModel("prop_biotech_store")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(100) end
   local objeNuc = CreateObject(hash, biotechCoord.x, biotechCoord.y, biotechCoord.z-1.0,true,false,false)
    SetEntityHeading(objeNuc, biotechCoord.h)
    FreezeEntityPosition(objeNuc, true)
end


function secPanel()
    local hash = RequestModel("hei_prop_hei_securitypanel")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(100) end
    local panel = CreateObject(hash, secPanelCoord.x, secPanelCoord.y, secPanelCoord.z,true,false,false)
    SetEntityHeading(panel, secPanelCoord.h)
    FreezeEntityPosition(panel, true)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local sleep = 1500
        local player = PlayerPedId()
        local playerCoord = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playerCoord, takeNucleer.x, takeNucleer.y, takeNucleer.z, true)
        if dst <= 10 then
            sleep = 0
        end
        if ESX.PlayerData.job.name ~= "police" or ESX.PlayerData.job.name ~= "sheriff" then
            if dst <= 1 and not receipt and start then
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("kaves_hlab:fixstart_d")
                    animasyon(player, "creatures@rottweiler@tricks@", "petting_franklin")
                    steps = 1
                    Citizen.Wait(3200)
                    TriggerServerEvent("kaves_hlab:fixtext")
                end
            end
            if dst <= 1 and receipt and not taked and start then
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("kaves_hlab:taked")
                    TaskStartScenarioInPlace(player,"PROP_HUMAN_BUM_BIN",0,true)
                    Citizen.Wait(1000)
                    ClearPedTasks(player)
                    TriggerServerEvent("kaves_hlab:alarm")
                    TriggerServerEvent("kaves_hlab:again")
                    TriggerServerEvent("kaves_hlab:giveItem", "vtube", 4)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function Chem()
    local hash = RequestModel("prop_chem_vial_02")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(100) end
    local objeChem = CreateObject(hash, biotechCoord.x, biotechCoord.y, biotechCoord.z-0.10,true,false,false)
    SetEntityHeading(objeChem, biotechCoord.h)
    FreezeEntityPosition(objeChem, true)
    while true do
        Citizen.Wait(500)
        if text and sObject then
            DeleteObject(objeChem)
            local objChemT = CreateObject(hash, biotechCoord.x, biotechCoord.y, biotechCoord.z+0.15,true,false,false)
            FreezeEntityPosition(objChemT, true)
            TriggerServerEvent("kaves_hlab:sObject")
        end
    end
end

RegisterNetEvent("kaves_hlab:elevatoron_a")
AddEventHandler("kaves_hlab:elevatoron_a", function()
    elevatorOn = true
end)

RegisterNetEvent("kaves_hlab:sObject_a")
AddEventHandler("kaves_hlab:sObject_a", function()
    sObject = false
end)


RegisterNetEvent("kaves_hlab:taked_a")
AddEventHandler("kaves_hlab:taked_a", function()
    taked = true
end)

RegisterNetEvent("kaves_hlab:fixtext_a")
AddEventHandler("kaves_hlab:fixtext_a", function()
    text = true
end)


RegisterNetEvent("kaves_hlab:fixdoor_c")
AddEventHandler("kaves_hlab:fixdoor_c", function()
    lock = true
    Citizen.Wait(250)
    SetEntityHeading(door, hackDoor.h)
    FreezeEntityPosition(door, false)
end)

RegisterNetEvent("kaves_hlab:disablecontrol")
AddEventHandler("kaves_hlab:disablecontrol", function(output)
    control = output
    while control do
        Citizen.Wait(1)
        DisableControlAction(0, 38, true)
        DisableControlAction(0, 0, true)
    end
end)

RegisterNetEvent("kaves_hlab:fixstart_a")
AddEventHandler("kaves_hlab:fixstart_a", function()
start = true
end)

RegisterNetEvent("kaves_hlab:fixstart_c")
AddEventHandler("kaves_hlab:fixstart_c", function()
elevatorstart = true
end)

RegisterNetEvent("kaves_hlab:fixstart_e")
AddEventHandler("kaves_hlab:fixstart_e", function()
    receipt = true
end)

RegisterNetEvent("kaves_hlab:stopped_a")
AddEventHandler("kaves_hlab:stopped_a", function()
    stopped = true
    TriggerServerEvent("kaves_hlab:again")
end)


RegisterNetEvent("kaves_hlab:startalarmCL")
AddEventHandler('kaves_hlab:startalarmCL', function()
while not PrepareAlarm("FIB_05_BIOTECH_LAB_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("FIB_05_BIOTECH_LAB_ALARMS", 1)
end)

RegisterNetEvent("kaves_hlab:stopalarmCL")
AddEventHandler('kaves_hlab:stopalarmCL', function()
StopAlarm("FIB_05_BIOTECH_LAB_ALARMS", -1)
end)

RegisterNetEvent("kaves_hlab:policealert")
AddEventHandler("kaves_hlab:policealert", function(toggle)
    local player = ESX.GetPlayerData()
    if player.job.name == "police" or player.job.name == "sheriff" then
        if toggle == 1 then
            exports["mythic_notify"]:SendAlert("infrom", "Humans Lab Alarmı Çalıştı!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
            if not DoesBlipExist(alarmblip) then
                alarmblip = AddBlipForCoord(hackCoord.x, hackCoord.y, hackCoord.z)
                SetBlipSprite(alarmblip, 161)
	            SetBlipScale(alarmblip, 2.0)
	            SetBlipColour(alarmblip, 1)
	            PulseBlip(alarmblip)
            end
        elseif toggle == 2 then
            if DoesBlipExist(alarmblip) then
                RemoveBlip(alarmblip)
            end
        end
    end
end)

RegisterNetEvent("kaves_hlab:stop_a")
AddEventHandler("kaves_hlab:stop_a", function(cevap)
    cevap = true
    go = cevap
    if go then
    cevap = false 
    start = true
    lock = false
    start = true 
    look = false
    check = true
    control = true 
    elevatorOn = true 
    off = true
    elevatorstart = true
    stop = true
    steps = 0
    receipt = true
    taked = true
    text = true
    sObject = false
    toggle = 0
    stopped = true   
    TriggerServerEvent("kaves_hlab:alarm")
    TriggerServerEvent("kaves_hlab:again")
    end
end)



function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
end

function animasyon(ped, ad, anim) 
	ESX.Streaming.RequestAnimDict(ad, function()
		TaskPlayAnim(ped, ad, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
	end)
end

RegisterNetEvent('kaves_hlab:mask')
AddEventHandler('kaves_hlab:mask', function()
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		ESX.Game.SpawnObject('p_s_scuba_tank_s', {
			 x = coords.x,
			 y = coords.y,
			 z = coords.z - 3
		 }, function(object2)			
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)
			Citizen.Wait(80000)
			exports['mythic_notify']:SendAlert('error', 'Kalan Oksijen Miktarı : %70')
			Citizen.Wait(60000)
			exports['mythic_notify']:SendAlert('error', 'Kalan Oksijen Miktarı : %40')
			Citizen.Wait(80000)
			exports['mythic_notify']:SendAlert('error', 'Kalan Oksijen Miktarı : %10')
			Citizen.Wait(15000)
			exports['mythic_notify']:SendAlert('error', 'Kalan Oksijen Miktarı : %2')
			Citizen.Wait(5000)
			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)
		end)
	end)
end)





