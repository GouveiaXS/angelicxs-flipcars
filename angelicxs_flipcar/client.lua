ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('angelicxs:flipcar')
AddEventHandler('angelicxs:flipcar', function()
    local ped = PlayerPedId()
    local VehicleData, dist = ESX.Game.GetClosestVehicle()
    if dist <= 5 then
     --   NetworkRequestControlOfEntity(VehicleData)
        RequestAnimDict('missfinale_c2ig_11')
        TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
        exports['mythic_notify']:SendAlert('success', "Attempting to Flip Car!")
        exports['mythic_progbar']:Progress({
            name = "flip_car",
            duration = 10000,
            label = 'Flipping Car ...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        }, function(cancelled)
            if not cancelled then
                exports['mythic_notify']:SendAlert('success', "Your car has been flipped!") 
                local carCoords = GetEntityCoords(VehicleData)
                SetEntityCoords(VehicleData, carCoords.x, carCoords.y, carCoords.z+0.1, false, false, false, true)
                SetVehicleOnGroundProperly(VehicleData)
                ESX.Game.Teleport(VehicleData, carCoords)
                ClearPedTasks(ped)
            else
                exports['mythic_notify']:SendAlert('error', "Something went wrong!") 
                ClearPedTasks(ped)
            end
        end)
    else
        exports['mythic_notify']:SendAlert('error', "You are not close enough to flip!") 
    end
end)

RegisterCommand('flipcar', function()
    TriggerEvent('angelicxs:flipcar')
end)


-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
 --       local vehicle, dist = ESX.Game.GetClosestVehicle()
 --       if dist <=5 then
            exports.qtarget:Vehicle({
                options = {
                    {
                        event = "angelicxs:flipcar",
                        icon = "fas fa-arrow-up",
                        label = "Flip Vehicle",
                        num = 3,
                        distance = 2
                    },
                },
            })
	end
end)