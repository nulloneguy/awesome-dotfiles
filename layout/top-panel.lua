local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")
local clickable_container = require("widget.clickable-container")
local task_list = require("widget.task-list")
local clock = require("widget.clock")
local updater = require("widget.package-updater")
local screen_recorder = require("widget.screen-recorder")
local mpd = require("widget.mpd")
local end_session = require("widget.end-session")
local global_search = require("widget.global-search")

local top_panel = function(s)
	local panel = wibox({
		ontop = true,
		screen = s,
		type = "dock",
		height = dpi(28),
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.background,
		fg = beautiful.fg_normal,
	})

	panel:struts({
		top = dpi(28),
	})

	panel:connect_signal("mouse::enter", function()
		local w = mouse.current_wibox
		if w then
			w.cursor = "left_ptr"
		end
	end)

	local add_button = require("widget.open-default-app")(s)
	s.systray = wibox.widget({
		{
			base_size = dpi(20),
			horizontal = true,
			screen = "primary",
			widget = wibox.widget.systray,
		},
		visible = false,
		top = dpi(14),
		widget = wibox.container.margin,
	})
	s.tray_toggler = require("widget.tray-toggle")

	s.battery = require("widget.battery")()
	s.screen_rec = screen_recorder()
	s.mpd = mpd()
	s.end_session = end_session()
	s.network = require("widget.network")()
	s.global_search = global_search()
	s.bluetooth = require("widget.bluetooth")()

	panel:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			task_list(s),
			add_button,
		},
		clock(s),
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(4),

			s.systray,
			s.tray_toggler,
			s.screen_rec,
			s.network,
			s.global_search,
			s.bluetooth,
			s.battery,
			s.mpd,
			s.end_session,
		},
	})

	return panel
end

return top_panel
