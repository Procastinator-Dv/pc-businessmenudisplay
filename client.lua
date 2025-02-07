print("^1pc-businessmenudisplay by Procastinator V.1.0^7")

local isMenuVisible = false  -- Boolean para rastrear se o menu está visível
local spawnedProps = {}  -- Tabela para armazenar props criados

-- Função para spawnar o ped para cada negócio
Citizen.CreateThread(function()
    for businessName, business in pairs(Config.Businesses) do
        if business.usePed then
            -- Carregar e spawnar o ped
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

            -- Configurar interação com `ox_target`
            exports['ox_target']:addLocalEntity(ped, {
                {
                    name = 'showBusinessMenu',
                    onSelect = function()
                        TriggerEvent('showBusinessMenu', { business = businessName })
                    end,
                    icon = 'fas fa-file',
                    label = 'Mostrar Menu',
                }
            })
        else
            -- Carregar e spawnar o prop
            local propModel = business.propModel
            local coords = business.propCoords

            RequestModel(propModel)
            while not HasModelLoaded(propModel) do
                Wait(500)
            end

            local prop = CreateObject(propModel, coords.x, coords.y, coords.z, false, false, false)
            SetEntityRotation(prop, 0.0, 0.0, 0.0, 2, true)
            FreezeEntityPosition(prop, true)

            -- Adicionar prop à tabela spawnedProps para limpeza
            table.insert(spawnedProps, prop)

            -- Configurar interação com `ox_target`
            exports['ox_target']:addLocalEntity(prop, {
                {
                    name = 'showBusinessMenu',
                    onSelect = function()
                        TriggerEvent('showBusinessMenu', { business = businessName })
                    end,
                    icon = 'fas fa-file',
                    label = 'Mostrar Menu',
                }
            })
        end
    end
end)

-- Função para deletar todos os props spawnados
function deleteSpawnedProps()
    for _, prop in ipairs(spawnedProps) do
        if DoesEntityExist(prop) then
            DeleteEntity(prop)
        end
    end
    spawnedProps = {}  -- Limpar a tabela após deletar os props
end

-- Evento para lidar com a parada/reinício do recurso
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        deleteSpawnedProps()  -- Deletar props spawnados quando o recurso parar
    end
end)

-- Evento para mostrar o menu para o negócio selecionado
RegisterNetEvent('showBusinessMenu', function(data)
    if not isMenuVisible then
        isMenuVisible = true
        local business = Config.Businesses[data.business]
        
        -- Enviar o caminho do arquivo PNG para o NUI
        SendNUIMessage({
            type = "showMenu",
            menuImage = business.menuImage  -- Enviar o PNG para o menu
        })
    end
end)

-- Ouvir a tecla Escape para fechar o menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isMenuVisible and IsControlJustPressed(0, 177) then  -- Botão Escape
            isMenuVisible = false
            SendNUIMessage({ type = "closeMenu" })  -- Fechar o menu
        end
    end
end)
