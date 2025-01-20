print("^1pc-businessmenucards by Procastinator V.1.0^7")

local isMenuVisible = false  -- Boolean to track if the menu is visible
local spawnedProps = {}  -- Table to store created props

-- Function to spawn the ped for each business
Citizen.CreateThread(function()
    for businessName, business in pairs(Config.Businesses) do
        if business.usePed then
            -- Load and spawn the ped
            local pedModel = business.pedModel
            local coords = business.coords

            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do
                Wait(500)
            end

            local ped = CreatePed(4, pedModel, coords.x, coords.y, coords.z, -140.0, false, true)
            SetEntityInvincible(ped, true)
            SetEntityVisible(ped, true, false)
            FreezeEntityPosition(ped, true)

            -- Set up interaction with `qb-target`
            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        type = "client",
                        event = "showBusinessMenu",
                        icon = "fas fa-file",
                        label = "Show Menu",
                        business = businessName,
                    },
                },
                distance = 3.0
            })
        else
            -- Load and spawn the prop
            local propModel = business.propModel
            local coords = business.propCoords

            RequestModel(propModel)
            while not HasModelLoaded(propModel) do
                Wait(500)
            end

            local prop = CreateObject(propModel, coords.x, coords.y, coords.z, false, false, false)
            SetEntityRotation(prop, 0.0, 0.0, 0.0, 2, true)
            FreezeEntityPosition(prop, true)

            -- Add prop to the spawnedProps table for cleanup
            table.insert(spawnedProps, prop)

            -- Set up interaction with `qb-target`
            exports['qb-target']:AddTargetEntity(prop, {
                options = {
                    {
                        type = "client",
                        event = "showBusinessMenu",
                        icon = "fas fa-file",
                        label = "Show Menu",
                        business = businessName,
                    },
                },
                distance = 3.0
            })
        end
    end
end)

-- Function to delete all spawned props
function deleteSpawnedProps()
    for _, prop in ipairs(spawnedProps) do
        if DoesEntityExist(prop) then
            DeleteEntity(prop)
        end
    end
    spawnedProps = {}  -- Clear the table after deleting props
end

-- Event to handle resource stop/restart
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        deleteSpawnedProps()  -- Delete spawned props when the resource stops
    end
end)

-- Event to show the menu for the selected business
RegisterNetEvent('showBusinessMenu', function(data)
    if not isMenuVisible then
        isMenuVisible = true
        local business = Config.Businesses[data.business]
        
        -- Send the PNG file path to the NUI
        SendNUIMessage({
            type = "showMenu",
            menuImage = business.menuImage  -- Send the PNG file for the menu
        })
    end
end)

-- Listen for Escape key to close the menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isMenuVisible and IsControlJustPressed(0, 177) then  -- Escape button
            isMenuVisible = false
            SendNUIMessage({ type = "closeMenu" })  -- Close the menu
        end
    end
end)

