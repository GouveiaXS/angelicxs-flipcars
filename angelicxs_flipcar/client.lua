ESX = nil
QBcore = nil

RegisterNetEvent('angelicxs-flipcar:Notify', function(message, type)
	if Config.UseCustomNotify then
        TriggerEvent('angelicxs-flipcar:CustomNotify',message, type)
	elseif Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBCore then
		QBCore.Functions.Notify(message, type)
	end
end)

CreateThread(function()
    if Config.UseESX then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
        end
        while not ESX.IsPlayerLoaded() do
            Wait(100)
        end
    elseif Config.UseQBCore then
        QBCore = exports['qb-core']:GetCoreObject()
    end

    if Config.UseChatCommand then
        RegisterCommand(Config.ChatCommand, function()
            TriggerEvent('angelicxs-flipcar:flipcar')
        end)
    end
end)

RegisterNetEvent('angelicxs-flipcar:flipcar')
AddEventHandler('angelicxs-flipcar:flipcar', function()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    local VehicleData = GetVehiclePedIsIn(ped, true)
    local dist = #(pedcoords - GetEntityCoords(VehicleData))
    local inside = IsPedInAnyVehicle(ped, true)
    if dist <= 3 and not inside then
        RequestAnimDict('missfinale_c2ig_11')
        TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
        Wait(Config.TimetoFlip*1000)
        local carCoords = GetEntityCoords(VehicleData)
        SetEntityCoords(VehicleData, carCoords.x, carCoords.y, (carCoords.z+0.1), false, false, false, true)
        SetVehicleOnGroundProperly(VehicleData)
        TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['flipped'], Config.LangType['success'])
        ClearPedTasks(ped)
    elseif inside then
        TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['in_vehicle'], Config.LangType['error'])
    else
        TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['far_away'], Config.LangType['error'])
    end
end)

CreateThread(function()
    if Config.UseThirdEye then
            exports[Config.ThirdEyeName]:Vehicle({
                options = {
                    {
                        event = "angelicxs-flipcar:flipcar",
                        icon = "fas fa-arrow-up",
                        label = "Flip Vehicle",
                        distance = 2
                    },
                },
            })
    end
end)
