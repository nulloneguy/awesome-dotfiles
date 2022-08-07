local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

return {
	-- The default applications that we will use in keybindings and widgets
	default = {
		-- Default terminal emulator
		terminal = "st",
		-- Default web browser
		web_browser = "firefox",
		-- Default text editor
		text_editor = "neovide",
		-- Default file manager
		file_manager = "dolphin",
		-- Default media player
		multimedia = "mpv",
		-- Default game, can be a launcher like steam
		game = "steam",
		-- Default graphics editor
		graphics = "gimp",
		-- Default sandbox
		sandbox = "virt-manager",
		-- Default IDE
		development = "neovide",
		-- Default network manager
		network_manager = "st -e nmtui",
		-- Default bluetooth manager
		bluetooth_manager = "blueman-manager",
		-- Default power manager
		power_manager = "upowerd",
		-- Default GUI package manager
		package_manager = "pamac-manager",
		-- Default locker
		lock = "slock",
		-- Default quake terminal
		quake = "st -n QuakeTerminal",
		-- Default rofi global menu
		rofi_global = "rofi -dpi "
			.. screen.primary.dpi
			.. ' -show "Global Search" -modi "Global Search":'
			.. config_dir
			.. "/configuration/rofi/global/rofi-spotlight.sh"
			.. " -theme "
			.. config_dir
			.. "/configuration/rofi/global/rofi.rasi",
		-- Default app menu
		rofi_appmenu = "rofi -dpi "
			.. screen.primary.dpi
			.. " -show drun -theme "
			.. config_dir
			.. "/configuration/rofi/appmenu/rofi.rasi",

		-- You can add more default applications here
	},

	-- List of apps to start once on start-up
	run_on_start_up = {
		-- keyboard layout
		"setxkbmap -layout us,ru -option 'grp:alt_shift_toggle,grp_led:scroll'",
		-- keyboard speed
		"xset r rate 170 65",
		-- Compositor
		"picom -b --experimental-backends --config ~/.config/awesome/configuration/picom.conf",
		-- Load X colors
		"xrdb $HOME/.Xresources",
		-- Polkit and keyring
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
			.. " eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)",
		-- Music server
		"mpd",
		-- Lockscreen timer
		-- [[
		-- xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		-- "awesome-client 'awesome.emit_signal(\"module::lockscreen_show\")'" ""
		-- ]],
	},

	-- List of binaries/shell scripts that will execute for a certain task
	utils = {
		-- Fullscreen screenshot
		full_screenshot = utils_dir .. "snap full",
		-- Area screenshot
		area_screenshot = utils_dir .. "snap area",
		-- Update profile picture
		update_profile = utils_dir .. "profile-image",
	},
}
