local loadingScreenFinished = false
local ready = false
local guiEnabled = false
local timecycleModifier = "hud_def_blur"

RegisterNetEvent('esx_identity:alreadyRegistered', function()
    while not loadingScreenFinished do Wait(100) end
    TriggerEvent('esx_skin:playerRegistered')
end)

RegisterNetEvent('esx_identity:setPlayerData', function(data)
    SetTimeout(1, function()
         ESX.SetPlayerData("name", ('%s %s'):format(data.firstName, data.lastName))
         ESX.SetPlayerData('firstName', data.firstName)
         ESX.SetPlayerData('lastName', data.lastName)
         ESX.SetPlayerData('dateofbirth', data.dateOfBirth)
         ESX.SetPlayerData('sex', data.sex)
         ESX.SetPlayerData('height', data.height)
         ESX.SetPlayerData('thumbnail', data.thumbnail)
    end)
 end)

AddEventHandler('esx:loadingScreenOff', function()
    loadingScreenFinished = true
end)

RegisterNUICallback('ready', function(data, cb)
    ready = true
    cb(1)
end)

if not Config.UseDeferrals then
    function EnableGui(state)
        SetNuiFocus(state, state)
        guiEnabled = state

        if state then
            SetTimecycleModifier(timecycleModifier)
        else
            ClearTimecycleModifier()
        end

        SendNUIMessage({
            action = "Identity",
            button_text='Crea Personaggio',
            enable = state
        })
    end

    RegisterNetEvent('esx_identity:showRegisterIdentity', function()
        TriggerEvent('esx_skin:resetFirstSpawn')

        if not ESX.PlayerData.dead then EnableGui(true) end
    end)

    RegisterNUICallback('register', function(char, cb)
        --prende char come parametro che sarebbero i dati imessi nel form dall'utente,
        --per estrapolare i dati usiamo char[index], in index mettiamo l'informazione che vogliamo:
        --"samu
        local data = {
            firstname = char[1], --firstname
            lastname = char[2], --lastname
            dateofbirth = char[3], --dateofbirth
            sex = char[4], --sex "m" o "f"
            height = char[5], --height
            thumbnail = char[6], --thumbnail (immagine di profilo)
        }
        --inviamo la tabella data con tute le info
        ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
            if callback then
                ESX.ShowNotification(TranslateCap('thank_you_for_registering'))
                EnableGui(false)

                if not ESX.GetConfig().Multichar then
                    TriggerEvent('esx_skin:playerRegistered')
                end
            end
        end, data) --invia tabella data contenente le info dell'utente
    end)

    CreateThread(function()
        while true do
            local sleep = 1500

            if guiEnabled then
                sleep = 0
                DisableControlAction(0, 1, true) -- LookLeftRight
                DisableControlAction(0, 2, true) -- LookUpDown
                DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
                DisableControlAction(0, 142, true) -- MeleeAttackAlternate
                DisableControlAction(0, 30, true) -- MoveLeftRight
                DisableControlAction(0, 31, true) -- MoveUpDown
                DisableControlAction(0, 21, true) -- disable sprint
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                DisableControlAction(0, 75, true) -- disable exit vehicle
                DisableControlAction(27, 75, true) -- disable exit vehicle
            else
                sleep = 1500
            end

            Wait(sleep)
        end
    end)
end
