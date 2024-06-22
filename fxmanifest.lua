fx_version "cerulean"

author '"samu'
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

ui_page 'web/build/index.html'

client_script {
  'client/*'
}
server_script {
  '@oxmysql/lib/MySQL.lua',
  'server/*'
}

files {
  'web/build/index.html',
  'web/build/**/*'
}
