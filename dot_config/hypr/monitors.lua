-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Primary (left): Samsung U28H75x 4K, scaled 1.5x so UI matches the AORUS's 1440p logical size
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "-2560x0", scale = 1.5 * omarchy_monitor_scale })

-- Secondary (right): GIGABYTE AORUS AD27QD 1440p @ 144Hz
hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = omarchy_monitor_scale })
