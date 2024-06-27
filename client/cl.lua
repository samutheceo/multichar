--==================================================================================
--======               ESX_IDENTITY BY SAMU @"samu                            ======
--======            CREDIT TO @Ark for this esx_identity base                 ======
--==================================================================================

--===============================================
--==               🥳  VARIABLES  🥳          ==
--===============================================
local guiEnabled = false
local myIdentity = {}

--===============================================
--==                🥳  VARIABLES  🥳         ==
--===============================================
function EnableGui(enable)
    SetNuiFocus(enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "Identity",
        button_text = SamuLogin.Identity.create_button_label,
        enable = enable
    })
end


--===============================================
--==         ⭐  Show Registration  ⭐        ==
--===============================================
RegisterNetEvent("esx_identity:showRegisterIdentity")
AddEventHandler("esx_identity:showRegisterIdentity", function()
  EnableGui(true)
end)

--===============================================
--==            ❌  Close GUI   ❌            ==
--===============================================
RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

--===============================================
--==          ♟️ Register Callback  ♟️        ==
--===============================================
RegisterNUICallback('register', function(data, cb)
  myIdentity = data
  TriggerServerEvent('esx_identity:setIdentity', data)
  EnableGui(false)
  Wait (500)
  TriggerEvent('esx_skin:openSaveableMenu')
end)

--===============================================
--==                🕐 THREADING  🕐          ==
--===============================================
Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled)
            DisableControlAction(0, 2, guiEnabled)

            DisableControlAction(0, 142, guiEnabled)

            DisableControlAction(0, 106, guiEnabled) 
        end
        Citizen.Wait(0)
    end
end)
