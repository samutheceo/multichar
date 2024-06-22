--Locals: 🚀
local pg = {}
local cam, camFaccia, relog, maxPG = nil, nil, false, false, 1
local selezionato = nil





--Threads: 🕐
CreateThread(function()
    RequestModel('mp_m_freemode_01')
    RequestModel('mp_f_freemode_01')
    while true do
        Wait(0)
        if NetworkIsPlayerActive(PlayerId()) then
            DoScreenFadeOut(0)
            ShutdownLoadingScreen()
            ShutdownLoadingScreenNui()
            TriggerEvent('esx:loadingScreenOff')
            TriggerEvent("samu_login:startLogin")
            break
        end
    end
end)





--Commands: 🥵
RegisterCommand('fixlogin', function(source, args)
    TriggerEvent('samu_login:startLogin')
end)

RegisterCommand('identity', function()
    SendNUIMessage({ action = 'Identity', data = { button_text = 'Crea Personaggio'} })
    SetNuiFocus(true, true)
end)

RegisterCommand('identity:hide', function()
    SendNUIMessage({ action = 'IdentityHide' })
    SetNuiFocus(0, 0)
end)

RegisterCommand('multichar', function()
    SendNUIMessage({
        
        action = 'Multichar',
        data = {
            users = {
                {
                    name = 'samu',
                    surname =  'Tatical',
                    age = '17/08/2000,
                    sex = 'M'
                    thumbnail  =  'https://media.discordapp.net/attachments/1063113222531596398/1250960895194955886/samu.gif?ex=667174df&is=6670235f&hm=ab7c55407827e0888deec30ebcc9bf6965924d68aae71d939af0a2c3f6277bb0&=',
                    job1 = 'Pescatore',
                    job2 = 'Coglione'
                    bank = 30000,
                    cash = 3000
                },
            }
        }
    })
    SetNuiFocus(true, true)
end)

RegisterCommand('multichar:hide', function()
    SendNUIMessage({ action = 'MulticharHide' })
    SetNuiFocus(0, 0)
end)

RegisterCommand('relog',function(source,args)
    if relog then
        relog = false
        Samu_ResetPed()
        DoScreenFadeOut(400)
        TriggerServerEvent("samu_login:quitESX")
        Citizen.CreateThread(function()
            relog = false
            Wait(2 * 1000)
            relog = true
        end)
    end
end)





--Callbacks: 🎢
RegisterNUICallback('creaPersonaggio', function(data, cb)
    if not data[1] or string.len(data[1]) < 3 then
        ESX.ShowNotification("Nome non inserito correttamente")
    elseif not data[2] or string.len(data[2]) < 3 then
        ESX.ShowNotification("Cognome non inserito correttamente")
    elseif not data[3] then
        ESX.ShowNotification("Data di nascita non valida")
    elseif not data[5] then 
        ESX.ShowNotification("Altezza non valida")
    else
        local char = {
            name = data[1],
            surname = data[2],
            age = data[3],
            sex = data[4],
            height = data[5],
            thumbnail = data[6],
            pg = data[7]
        }
        SendNUIMessage({ action = 'IdentityHide' })
        Samu_ResetPed()
        TriggerServerEvent("samu_login:creaIdentity", char)
        TriggerEvent("skinchanger:loadDefaultModel", char.sex)
        local ped = PlayerPedId()
        SetEntityVisible(ped, true)
        FreezeEntityPosition(ped, false)
        SetEntityCoords(ped, -256.02,-295.04,20.62)
        SetEntityHeading(ped, 203.8)
        TriggerEvent("esx_skin:openSaveableMenu",function()
            TriggerServerEvent("samu_login:lobby", false)
            relog = true
        end)
    end
end)

RegisterNUICallback('selezionaPG', function(index)
    SetEntityAlpha(pg[index], 255, false)
    selezionato = pg[index]

    if index == 2 then
        ESX.ShowNotification('Questo slot è bloccato. Acquistalo per sbloccarlo.')
    end
end)

RegisterNUICallback("gioca", function(data, cb)
    selezionando = false
    SetNuiFocus(false,false)
    DoScreenFadeOut(800)
    TriggerServerEvent("samu_login:logga", data.pg)
    ESX.TriggerServerCallback('samu_login:getPos', function(info)
        TriggerEvent('skinchanger:loadSkin', json.decode(info.skin), function()
            local ped = PlayerPedId()
            local pos = json.decode(info.position)
            SetEntityVisible(ped, true)
            Utis_ResetPed()
            RenderScriptCams(false,true,250,1,0)
            SetCamActive(cam2,false)
            SetCamActive(cam,false)
            DestroyCam(cam,false)
            DestroyCam(cam2,false)
            SetEntityCoords(ped, pos.x,pos.y,pos.z)
            SetEntityHeading(ped, pos.heading)
            ClearPedTasksImmediately(ped)
            FreezeEntityPosition(ped, false)
            Wait(900)
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned')
            TriggerEvent('esx:restoreLoadout')
            relog = true
            DoScreenFadeIn(800)
        end)
    end, data.pg)
end)





--Events: 🥳
RegisterNetEvent('samu_login:syncMaxPG', function(pgm)
    maxPG = pgm
end)

RegisterNetEvent('samu_login:startLogin',function()
    while not HasModelLoaded('mp_m_freemode_01') and not HasModelLoaded('mp_f_freemode_01') do
        RequestModel('mp_m_freemode_01')
        RequestModel('mp_f_freemode_01')
        ESX.ShowHelpNotification('Caricando i PGs...')
        Wait(0)
    end
    DoScreenFadeIn(0)
    relog = false
    local ped = cache.ped
    local index = 0
    renderizzaCam(1)
    DisplayRadar(false)
    Wait(400)
    FreezeEntityPosition(ped, true)
    ESX.TriggerServerCallback('samu_login:getSkinPGS',function(data)
        selezionando = true
        for k,v in pairs(SamuLogin.PedPos) do
            index = index + 1
            if json.decode(data[index]) ~= nil then
                while not HasModelLoaded(json.decode(data[index]).model) do
                    RequestModel(json.decode(data[index]).model)
                    Wait(0)
                end
                pg[index] = CreatePed(0, json.decode(data[index]).model, SamuLogin.PedPos[index].x,SamuLogin.PedPos[index].y,SamuLogin.PedPos[index].z - 1.0,SamuLogin.PedPos[index].w, false, true)
            else
                pg[index] = CreatePed(0, 'mp_m_freemode_01', SamuLogin.PedPos[index].x,SamuLogin.PedPos[index].y,SamuLogin.PedPos[index].z - 1.0,SamuLogin.PedPos[index].w, false, true)
            end
            print(index, maxPG)
            exports['fivem-appearance']:setPedAppearance(pg[index], json.decode(data[index]))
            ClearPedTasksImmediately(pg[index])
            FreezeEntityPosition(pg[index], true)
            SetEntityAlpha(pg[index], 100, false)
        end
        local e = Samu_SelezionaEntitaLogin()
        local idPg = Samu_GetPG(e)
        ESX.TriggerServerCallback('samu_login:checkPg',function(data, info)
            if data then                
                for i=1, #info, 1 do 
                    firstname = info[i].firstname
                    lastname = info[i].lastname
                    dateofbirth = info[i].dateofbirth
                    sex = info[i].sex or 'M'
                    job1 = info[i].job1
                    job2 = info[i].job2
                    bank = info[i].bank
                    cash = info[i].cash
                    pgg = info[i].pg
                end
                renderizzaCam(2, e)
                SetNuiFocus(true,true)
                SendNUIMessage({azione = 'mostraInfo',name = name, sex = sex, surname = surname, age = age, job1 = job1, job2 = job2, bank = bank, cash = cash, pg = pgg})
            else
                renderizzaCam(2, e)
                SetNuiFocus(true,true)
                SendNUIMessage({azione = 'noPG', pg = idPg})
            end
        end,idPg)
    end)
end)

RegisterNetEvent('samu_relog', function()
    Samu_ResetPed()
    DoScreenFadeOut(400)
    TriggerServerEvent("samu_login:quitESX")
end)

AddEventHandler("onClientResourceStop", function(r)
    Samu_ResetPed()
end)





--Functions: ⭐ 
Samu_GetPG = function(entita)
    for i=4, 1, -1 do
        if GetEntityCoords(entita) ~= vec3(0.0,0.0,0.0) then
            local dist = #(GetEntityCoords(entita) - vec3(SamuLogin.PedPos[i].x,SamuLogin.PedPos[i].y,SamuLogin.PedPos[i].z))
            if dist < 0.5 then
                return i
            end
        else
            return i
        end
    end
end

Samu_ResetPed = function()
    DeletePed(pg[1])
    DeletePed(pg[2]) 
    pg = {}
end

renderizzaCam = function(i, entita)
    if i == 1 then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamParams(cam, 4.0 , 1.8541314601898 ,0.5, 0.0, 0, 75.0, 77.0, 0, 1, 3, 1)
        RenderScriptCams(true,false,0,true,true)
        SetEntityVisible(cache.ped, false)
        SetEntityCoords(cache.ped, 4.0 , 1.8541314601898 ,0.5)
    else
        local cc = GetOffsetFromEntityInWorldCoords(entita,0,0.75,0)
        DestroyCam(cam,false)
        DestroyCam(cam2,false)
        --
        cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
        SetCamActive(cam2,true)
        RenderScriptCams(true,false,0,true,true)    
        SetCamCoord(cam2,cc.x,cc.y,cc.z+0.65)
        SetCamRot(cam2,0.0,0.0,GetEntityHeading(entita)+180)
    end
end