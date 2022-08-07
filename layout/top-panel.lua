local wibox = require "wibox"
local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local icons = require "theme.icons"
local clickable_container = require "widget.clickable-container"
local task_list = require "widget.task-list"

local top_panel = function(s)
   local panel = wibox {
      ontop = false,
      screen = s,
      type = "dock",
      height = dpi(28),
      width = s.geometry.width,
      x = s.geometry.x,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background,
      fg = beautiful.fg_normal,
   }

   s.systray = wibox.widget {
      {
         base_size = dpi(18),
         horizontal = true,
         screen = "primary",
         widget = wibox.widget.systray,
      },
      visible = false,
      widget = wibox.container.margin,
   }

   s.tray_toggler = require "widget.tray-toggle"

   panel:struts {
      top = dpi(28),
   }

   panel:connect_signal("mouse::enter", function()
      local w = mouse.current_wibox
      if w then
         w.cursor = "left_ptr"
      end
   end)

   local clock = require "widget.clock"(s)
   s.screen_rec = require "widget.screen-recorder"()
   s.network = require "widget.network"()
   s.mpd = require "widget.mpd"()
   s.bluetooth = require "widget.bluetooth"()
   s.end_session = require "widget.end-session"()
   s.battery = require "widget.battery"()
   --s.global_search = require("widget.global-search")()

   panel:setup {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
         layout = wibox.layout.fixed.horizontal,
         task_list(s),
      },
      clock,
      {
         layout = wibox.layout.fixed.horizontal,
         spacing = dpi(5),
         s.systray,
         s.tray_toggler,
         s.screen_rec,
         s.bluetooth,
         s.network,
         --s.global_search,
         s.battery,
         s.mpd,
         s.end_session,
      },
   }

   return panel
end

return top_panel
