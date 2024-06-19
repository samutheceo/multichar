RegisterCommand('identity', function()
    SendNUIMessage({ action = 'Identity', data = { button_text = 'Crea Personaggio'} })
    SetNuiFocus(true, true)
end)

RegisterCommand('identity:hide', function()
    SendNUIMessage({ action = 'IdentityHide' })
    SetNuiFocus(0, 0)
end)


--⭐ !!! in users ci dovranno essere i dati dell'utente, i dati inviati ora sono di debug --"samu !!! ⭐
RegisterCommand('multichar', function()
    SendNUIMessage({
        
        action = 'Multichar',
        data = {
            users = {
                {
                    firstname = 'samu',
                    lastname =  'Tatical',
                    dateofbirth = '17 Agosto, 2000',
                    thumbnail  =  'https://media.discordapp.net/attachments/1063113222531596398/1250960895194955886/samu.gif?ex=667174df&is=6670235f&hm=ab7c55407827e0888deec30ebcc9bf6965924d68aae71d939af0a2c3f6277bb0&=',
                    job = 'Disoccupato',
                    accounts = {
                        {
                            "bank" = 100,
                            "money" = 0
                        }
                    }
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


--Callbacks: 🎢

RegisterNUICallback('creaPersonaggio', function(nome, cognome, bday, sesso, altezza, thumbnail)

end)