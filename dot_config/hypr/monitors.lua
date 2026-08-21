-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

hl.monitor({ output = "desc:Samsung Electric Company U28H75x HTPK300227", mode = "3840x2160@60", position = "-2560x0", scale = 1.5 * omarchy_monitor_scale })
hl.monitor({ output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS AD27QD 19160B000714", mode = "2560x1440@144", position = "0x0", scale = omarchy_monitor_scale })
hl.monitor({ output = "desc:Chimei Innolux Corporation 0x1540", mode = "2560x1440@165", scale = omarchy_monitor_scale })
