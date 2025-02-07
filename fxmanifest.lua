fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Procastinator'
version ' 1.0'

shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',  -- Add this line to ensure the config file is loaded
    'client.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/images/*',  -- Include your menu image(s)
    
}
