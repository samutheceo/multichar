fx_version "cerulean"

author '"samu'
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

ui_page 'web/build/index.html'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

files {
  'web/build/index.html',
  'web/build/**/*'
}

shared_script '@es_extended/imports.lua'

dependency('es_extended')