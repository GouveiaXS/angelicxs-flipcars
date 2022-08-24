Config = {}


Config.UseESX = true						-- Use ESX Framework
Config.UseQBCore = false					-- Use QBCore Framework (Ignored if Config.UseESX = true)

Config.UseCustomNotify = false				-- Use a custom notification script, must complete event below.

-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-flipcar:CustomNotify')
AddEventHandler('angelicxs-flipcar:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
end)

Config.TimetoFlip = 3 						-- How long, in seconds, to flip the car.

Config.Jobs = {								-- List of permitted jobs; leave empty table for to allow all.
	["police"] = 0,
	["mechanic"] = 0,
}
Config.AndOr = false				            --  Logic to determine item requirement
                                            -- If false car can be flipped with either meeting the job or item requirement (if needed/wanted you can ignore Config.RequiredItem with this setting)
                                            -- If true car can only be flipped by having both job and item requirement
Config.RequiredItem = 'itemnamehere'		-- Replace 'itemnamehere' with item to be used for flipping vehicles, it is NOT removed on use, it only needs to be in the inventory (can be ignored if Config.AndOr = or and no item is wanted). 


-- Visual Preference
Config.UseThirdEye = false 					-- Enables using a third eye (depending on version will need to update export to target all vehicles)
Config.ThirdEyeName = 'q-target' 			-- Name of third eye aplication
Config.UseChatCommand = true                -- Enables using chat command to flip vehicle. Must be true if Config.UseThirdEye=false.
Config.ChatCommand = 'flipcar'              -- When Config.UseChatCommand = true, is the phrase used to flip vehicle.

-- Language Configuration
Config.LangType = {
	['error'] = 'error',
	['success'] = 'success',
	['info'] = 'inform'
}

Config.Lang = {
	['flipped'] = 'You have flipped the vehicle!',
    ['in_vehicle'] = 'You can not flip the vehicle from inside!',
    ['far_away'] = 'You are not close enough flip the vehicle!',
    ['not_allowed'] = 'You don\'t have the training or tools to flip a vehicle!',
}
