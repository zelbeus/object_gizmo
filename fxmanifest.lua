rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
fx_version 'cerulean'
game 'rdr3'
lua54 'yes'

ui_page 'web/dist/index.html'

client_scripts {
	"client/*.lua"
}

files {
	'web/dist/index.html',
	'web/dist/**/*',
}