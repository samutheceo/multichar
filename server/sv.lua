local pgPlayers = {}

ESX.RegisterServerCallback('samu_login:getSkinPGS',function(source, cb)
    local ide = ESX.GetIdentifier(source)
    SetPlayerRoutingBucket(source, source)
    local res = MySQL.query.await('SELECT skin, identifier from users', {})
    pgPlayers[ide] = {}
    for k,v in pairs(res) do
        if string.find(v.identifier, ide) then
            table.insert(pgPlayers[ide], v.skin)
        end
    end
    local PGMax = MySQL.query.await('SELECT * from samu_login WHERE identifier = @ide', {['@ide'] = ESX.GetIdentifier(source)})[1]
    if PGMax ~= nil then
        TriggerClientEvent("samu_login:syncMaxPG", source, tonumber(PGMax.maxPG))
    else
        TriggerClientEvent("samu_login:syncMaxPG", source, 1)
    end
    cb(pgPlayers[ide])
end)

ESX.RegisterServerCallback('samu_login:checkPg',function(source, cb, idp)
    local ide = ESX.GetIdentifier(source)
    local bool = false
    local t = {}
    for k,v in pairs(pgPlayers[ide]) do
        print(k, idp, k == idp)
        if k == idp then
            bool = true
            local info = MySQL.query.await('SELECT * from users WHERE identifier = @ide', {['@ide'] = "char"..idp..":"..ide})[1]
            local poverta = json.decode(info.accounts)
            table.insert(t, {
                name = info.firstname,
                surname = info.lastname, 
                age = info.dateofbirth, 
                sex = info.sex,
                thumbnail = info.thumbnail,
                job1 = info.job, 
                job2 = info.job2, 
                cash = poverta.money,
                bank = poverta.bank,
                pg = idp
            })
        end
    end
    
    cb(bool, t)
end)

RegisterServerEvent('samu_login:creaIdentity', function(data)
    local src = source

    TriggerEvent("esx:onPlayerJoined", src,
    'char'.. data.pg, {
        firstname = data.nome,
        lastname = data.cognome,
        dateofbirth = data.data,
        sex = data.sesso,
        height = data.altezza
    })

    Wait(500)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        xPlayer.showNotification("Benvenuto sulla Tatical Gamemode")
    end
end)

RegisterNetEvent('samu_login:logga', function(pg)
    local src = source
    SetPlayerRoutingBucket(src, 0)
    TriggerEvent("esx:onPlayerJoined", src, 'char'.. pg)
    Wait(500)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        xPlayer.showNotification("Bentornato sulla Tatical Gamemode")
    end
end)

ESX.RegisterServerCallback('samu_login:getPos', function(source, cb, pg)
    local pos = MySQL.query.await('SELECT * from users WHERE identifier = @ide', {['@ide'] = "char"..pg..":"..ESX.GetIdentifier(source)})[1]
    cb(pos)
end)

RegisterServerEvent('samu_login:quitESX', function()
    local src = source
    TriggerEvent('esx:playerLogout', src)
    Wait(100)
    TriggerClientEvent("samu_login:startLogin", src)
end)

RegisterNetEvent('samu_login:lobby', function(bool)
    if bool then
        SetPlayerRoutingBucket(source, source)
    else 
        SetPlayerRoutingBucket(source, 0)
    end
end)
