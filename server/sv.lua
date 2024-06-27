--==================================================================================
--======               ESX_IDENTITY BY SAMU @"samu                            ======
--======            CREDIT TO @Ark for this esx_identity base                 ======
--==================================================================================

--===================================================================
--==                     ⭐   MAIN FUNCTIONS  ⭐                  ==
--===================================================================

--===============================================
--==    🎭 Get The Player's Identification 🎭 ==
--===============================================
function getIdentity(source, callback)
    local _source = source
    local identifier = GetPlayerIdentifiers(_source)[1]
      MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
    {
      ['@identifier'] = identifier
    },
    function(result)
      if result[1]['firstname'] ~= nil then
        local data = {
          identifier  = result[1]['identifier'],
          firstname  = result[1]['firstname'],
          lastname  = result[1]['lastname'],
          dateofbirth  = result[1]['dateofbirth'],
          sex      = result[1]['sex'],
          height    = result[1]['height'],
          thumbnail = result[1]['thumbnail']
        }
  
        callback(data)
      else
        local data = {
          identifier   = '',
          firstname   = '',
          lastname   = '',
          dateofbirth = '',
          sex     = '',
          height     = '',
          thumbnail = 'https://i.imgur.com/HWvFy32.png',
        }
  
        callback(data)
      end
    end)
  end
  
  --===============================================
  --==   ♟️ Get The Player's Identification ♟️  ==
  --===============================================
  function getCharacters(source, callback)
    local _source = source
    local identifier = GetPlayerIdentifiers(_source)[1]
      MySQL.Async.fetchAll("SELECT * FROM `characters` WHERE `identifier` = @identifier",
    {
      ['@identifier'] = identifier
    },
    function(result)
      if result[1] and result[2] and result[3] then
        local data = {
          identifier    = result[1]['identifier'],
          firstname1    = result[1]['firstname'],
          lastname1    = result[1]['lastname'],
          dateofbirth1  = result[1]['dateofbirth'],
          sex1      = result[1]['sex'],
          height1      = result[1]['height'],
          thumbnail1      = result[1]['thumbnail'],
          firstname2    = result[2]['firstname'],
          lastname2    = result[2]['lastname'],
          dateofbirth2  = result[2]['dateofbirth'],
          sex2      = result[2]['sex'],
          height2      = result[2]['height'],
          thumbnail2   = result[2]['thumbnail'],
          firstname3    = result[3]['firstname'],
          lastname3    = result[3]['lastname'],
          dateofbirth3  = result[3]['dateofbirth'],
          sex3      = result[3]['sex'],
          height3      = result[3]['height'],
          thumbnail3      = result[3]['thumbnail']
        }
  
        callback(data)
      elseif result[1] and result[2] and not result[3] then
        local data = {
          identifier    = result[1]['identifier'],
          firstname1    = result[1]['firstname'],
          lastname1    = result[1]['lastname'],
          dateofbirth1  = result[1]['dateofbirth'],
          sex1      = result[1]['sex'],
          height1      = result[1]['height'],
          thumbnail1      = result[1]['thumbnail'],
          firstname2    = result[2]['firstname'],
          lastname2    = result[2]['lastname'],
          dateofbirth2  = result[2]['dateofbirth'],
          sex2      = result[2]['sex'],
          height2      = result[2]['height'],
          thumbnail2      = result[2]['thumbnail'],
          firstname3    = '',
          lastname3    = '',
          dateofbirth3  = '',
          sex3      = '',
          height3      = '',
          thumbnail3      = 'https://i.imgur.com/HWvFy32.png'
        }
  
        callback(data)
      elseif result[1] and not result[2] and not result[3] then
        local data = {
          identifier    = result[1]['identifier'],
          firstname1    = result[1]['firstname'],
          lastname1    = result[1]['lastname'],
          dateofbirth1  = result[1]['dateofbirth'],
          sex1      = result[1]['sex'],
          height1      = result[1]['height'],
          thumbnail1      = result[1]['thumbnail'],
          firstname2    = '',
          lastname2    = '',
          dateofbirth2  = '',
          sex2      = '',
          height2      = '',
          thumbnail2     = 'https://i.imgur.com/HWvFy32.png',
          firstname3    = '',
          lastname3    = '',
          dateofbirth3  = '',
          sex3      = '',
          height3      = '',
          thumbnail3      = 'https://i.imgur.com/HWvFy32.png'
        }
  
        callback(data)
      else
        local data = {
          identifier    = '',
          firstname1    = '',
          lastname1    = '',
          dateofbirth1  = '',
          sex1      = '',
          height1      = '',
          thumbnail1      = 'https://i.imgur.com/HWvFy32.png',
          firstname2    = '',
          lastname2    = '',
          dateofbirth2  = '',
          sex2      = '',
          height2      = '',
          thumbnail2      = 'https://i.imgur.com/HWvFy32.png',
          firstname3    = '',
          lastname3    = '',
          dateofbirth3  = '',
          sex3      = '',
          height3      = '',
          thumbnail3      = 'https://i.imgur.com/HWvFy32.png'
        }
  
        callback(data)
      end
    end)
  end
  
  --===============================================
  --==  🥵  Set The Player's Identification 🥵  ==
  --===============================================
  function setIdentity(identifier, data, callback)
    MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height, `thumbnail` = @thumbnail, WHERE identifier = @identifier",
      {
        ['@identifier']   = identifier,
        ['@firstname']    = data.firstname,
        ['@lastname']     = data.lastname,
        ['@dateofbirth']  = data.dateofbirth,
        ['@sex']        = data.sex,
        ['@height']       = data.height,
        ['@thumbnail']    = data.thumbnail
      },
    function(done)
      if callback then
        callback(true)
      end
    end)
  
    MySQL.Async.execute(
      'INSERT INTO characters (identifier, firstname, lastname, dateofbirth, sex, height, thumbnail) VALUES (@identifier, @firstname, @lastname, @dateofbirth, @sex, @height, @thumbnail)',
      {
        ['@identifier'] = identifier,
        ['@firstname']  = data.firstname,
        ['@lastname']   = data.lastname,
        ['@dateofbirth'] = data.dateofbirth,
        ['@sex']    = data.sex,
        ['@height']   = data.height,
        ['@thumbnail']    = data.thumbnail
      })
  end
  
  --===============================================
  --== 🚶 Update The Player's Identification 🚶 ==
  --===============================================
  function updateIdentity(identifier, data, callback)
    MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height, `thumbnail` = @thumbnail, WHERE identifier = @identifier",
      {
        ['@identifier']   = identifier,
        ['@firstname']    = data.firstname,
        ['@lastname']     = data.lastname,
        ['@dateofbirth']  = data.dateofbirth,
        ['@sex']        = data.sex,
        ['@height']       = data.height,
        ['@thumbnail']    = data.thumbnail
      },
    function(done)
      if callback then
        callback(true)
      end
    end)
  end
  
  --===============================================
  --== ❌ Delete The Player's Identification ❌ ==
  --===============================================
  function deleteIdentity(identifier, data, callback)
    MySQL.Async.execute("DELETE FROM `characters` WHERE identifier = @identifier AND firstname = @firstname AND lastname = @lastname AND dateofbirth = @dateofbirth AND sex = @sex AND height = @height AND thumbnail = @thumbnail",
      {
        ['@identifier']   = identifier,
        ['@firstname']    = data.firstname,
        ['@lastname']     = data.lastname,
        ['@dateofbirth']  = data.dateofbirth,
        ['@sex']        = data.sex,
        ['@height']       = data.height,
        ['@thumbnail']    = data.thumbnail
      },
    function(done)
      if callback then
        callback(true)
      end
    end)
  end
  
  --===============================================
  --==     🚀  Server Event Set Identity 🚀     ==
  --===============================================
  RegisterServerEvent('esx_identity:setIdentity')
  AddEventHandler('esx_identity:setIdentity', function(samu_users_table)
    local data = {
        firstname = samu_users_table[1],
        lastname = samu_users_table[2],
        dateofbirth = samu_users_table[3],
        sex = samu_users_table[4],
        height = samu_users_table[5],
        thumbnail = samu_users_table[6]
    }
    local _source = source
    local identifier = GetPlayerIdentifiers(_source)[1]
      setIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
      if callback == true then
        print('Successfully Set Identity For ' .. identifier)
      else
        print('Failed To Set Identity.')
      end
    end)
  end)
  
  --===============================================
  --==     🍨  Player Loaded Event Handler 🍨   ==
  --===============================================
  AddEventHandler('es:playerLoaded', function(source)
    local _source = source
    getIdentity(_source, function(data)
      if data.firstname == '' then
        TriggerClientEvent('esx_identity:showRegisterIdentity', _source)
      else
        print('Successfully Loaded Identity For ' .. data.firstname .. ' ' .. data.lastname)
      end
    end)
  end)
  
  --===================================================================
  --==                       🎢  MAIN COMMANDS 🎢                   ==
  --===================================================================
  
  --===============================================
  --==      /charlist - Show Your Characters     ==
  --===============================================
  TriggerEvent('es:addGroupCommand', 'idhelp', "user", function(source, args, user)
    local _source = source
    TriggerClientEvent('chatMessage', _source, 'IDHelp', {255, 0, 0}, "ESX_IDENTITY Commands")
    TriggerClientEvent('chatMessage', _source, 'IDHelp', {255, 0, 0}, "/register - Register A New Character")
    TriggerClientEvent('chatMessage', _source, 'IDHelp', {255, 0, 0}, "/charlist - List Your Characters")
    TriggerClientEvent('chatMessage', _source, 'IDHelp', {255, 0, 0}, "/charselect 1,2,3 - Change Your Active Character")
    TriggerClientEvent('chatMessage', _source, 'IDHelp', {255, 0, 0}, "/delchar 1,2,3 - Delete A Character")
  end, function(source, args, user)
  local _source = source
    TriggerClientEvent('chatMessage', _source, "IDHelp", {255, 0, 0}, "Insufficienct permissions!")
  end, {help = "List Your Characters"})
  
  
  --===============================================
  --==      /register - Open Registration        ==
  --===============================================
  TriggerEvent('es:addCommand', 'register', function(source, args, user)
    local _source = source
    getCharacters(_source, function(data)
      if data.firstname3 ~= '' then
        TriggerClientEvent('chatMessage', _source, 'REGISTER', {255, 0, 0}, "You Can Only Have 3 Characters.")
      else
        TriggerClientEvent('esx_identity:showRegisterIdentity', _source, {})
      end
    end)
  end)
  
  --===============================================
  --==      /char - Show Active Character        ==
  --===============================================
  TriggerEvent('es:addGroupCommand', 'char', "user", function(source, args, user)
    local _source = source
    getIdentity(_source, function(data)
      if data.firstname == '' then
        TriggerClientEvent('chatMessage', _source, 'CHAR', {255, 0, 0}, "You Have No Active Character.")
      else
        TriggerClientEvent('chatMessage', _source, 'CHAR', {255, 0, 0}, "Active Character: " .. data.firstname .. " " .. data.lastname)
      end
    end)
  end, function(_source, args, user)
    TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
  end, {help = "List Your Current Active Character"})
  
  --===============================================
  --==      /charlist - Show Your Characters     ==
  --===============================================
  TriggerEvent('es:addGroupCommand', 'charlist', "user", function(source, args, user)
    local _source = source
    getCharacters(_source, function(data)
      if data.firstname1 ~= '' then
        TriggerClientEvent('chatMessage', _source, 'CHARLIST', {255, 0, 0}, "Character 1: " .. data.firstname1 .. " " .. data.lastname1)
        if data.firstname2 ~= '' then
          TriggerClientEvent('chatMessage', _source, 'CHARLIST', {255, 0, 0}, "Character 2: " .. data.firstname2 .. " " .. data.lastname2)
          if data.firstname3 ~= '' then
            TriggerClientEvent('chatMessage', _source, 'CHARLIST', {255, 0, 0}, "Character 3: " .. data.firstname3 .. " " .. data.lastname3)
          end
        end
      else
        TriggerClientEvent('chatMessage', _source, 'CHARLIST', {255, 0, 0}, "You Have No Characters. Please use the /register command.")
      end
    end)
  end, function(_source, args, user)
    TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
  end, {help = "List Your Characters"})
  
  --===============================================
  --== /charselect 1,2,3 Select Your Active Char ==
  --===============================================
  TriggerEvent('es:addCommand', 'charselect', function(source, args, user)
    local _source = source
    table.remove(args, 1)
    local charNumber = tonumber(table.concat(args, " "))
    getCharacters(_source, function(data)
      if charNumber == 1 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname1,
          lastname  = data.lastname1,
          dateofbirth  = data.dateofbirth1,
          sex      = data.sex1,
          height    = data.height1,
          thumbnail = data.thumbnail1
        }
  
        if data.firstname ~= '' then
          updateIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
            if callback == true then
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Updated your active character to " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Failed To Update Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "You don\'t have a character in slot 1!")
        end
      elseif charNumber == 2 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname2,
          lastname  = data.lastname2,
          dateofbirth  = data.dateofbirth2,
          sex      = data.sex2,
          height    = data.height2,
          thumbnail = data.thumbnail2
        }
  
        if data.firstname ~= '' then
          updateIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
  
            if callback == true then
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Updated your active character to " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Failed To Update Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "You don\'t have a character in slot 2!")
        end
      elseif charNumber == 3 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname3,
          lastname  = data.lastname3,
          dateofbirth  = data.dateofbirth3,
          sex      = data.sex3,
          height    = data.height3,
          thumbnail = data.thumbnail3
        }
  
        if data.firstname ~= '' then
          updateIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
            if callback == true then
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Updated your active character to " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Failed To Update Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "You don\'t have a character in slot 3!")
        end
      else
        TriggerClientEvent('chatMessage', _source, "CHARSELECT", {255, 0, 0}, "Failed To Update Identity!")
      end
    end)
  end)
  
  --===============================================
  --== /charselect 1,2,3 Select Your Active Char ==
  --===============================================
  TriggerEvent('es:addCommand', 'delchar', function(source, args, user)
    local _source = source
    table.remove(args, 1)
    local charNumber = tonumber(table.concat(args, " "))
    getCharacters(_source, function(data)
      if charNumber == 1 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname1,
          lastname  = data.lastname1,
          dateofbirth  = data.dateofbirth1,
          sex      = data.sex1,
          height    = data.height1,
          thumbnail = data.thumbnail1
        }
        if data.firstname ~= '' then
          deleteIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
            if callback == true then
            TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 1!")
        end
      elseif charNumber == 2 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname2,
          lastname  = data.lastname2,
          dateofbirth  = data.dateofbirth2,
          sex      = data.sex2,
          height    = data.height2,
          thumbnail = data.thumbnail2
        }
        if data.firstname ~= '' then
          deleteIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
            if callback == true then
              TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 2!")
        end
      elseif charNumber == 3 then
        local data = {
          identifier   = data.identifier,
          firstname  = data.firstname3,
          lastname  = data.lastname3,
          dateofbirth  = data.dateofbirth3,
          sex      = data.sex3,
          height    = data.height3,
          thumbnail = data.thumbnail3
        }
        if data.firstname ~= '' then
          deleteIdentity(GetPlayerIdentifiers(_source)[1], data, function(callback)
            if callback == true then
              TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
            else
              TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
            end
          end)
        else
          TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 3!")
        end
      else
        TriggerClientEvent('chatMessage', _source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
      end
    end)
  end)
  