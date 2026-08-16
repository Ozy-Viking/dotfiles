-- Personal keybinding overrides (migrated from bindings.conf, 2026-08-16).
-- Defaults load first in hyprland.lua; only differences/conflicts live here.

-- Applications
o.bind("SUPER + SHIFT + T", "New herdr session", "uwsm-app -- xdg-terminal-exec herdr")
o.bind("SUPER + ALT + T", "Terminal", "uwsm app -- ghostty")
hl.unbind("SUPER + ALT + RETURN") -- default: Tmux
o.bind("SUPER + ALT + RETURN", "Herdr", { omarchy = "terminal-herdr" })
hl.unbind("SUPER + SHIFT + M") -- default: Music (Spotify)
o.bind("SUPER + SHIFT + M", "Music", { webapp = "https://music.youtube.com/", focus = "^YouTube Music$" })
hl.unbind("SUPER + SHIFT + X") -- default: X webapp
o.bind("SUPER + SHIFT + X", "Activity", { tui = "btop", focus = true })
o.bind("SUPER + SHIFT + I", "ChatGPT", { webapp = "https://chatgpt.com" })

-- Screenshot editor replaces the default Google Maps (preinstalled) binding.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot editor", "bash -lc 'file=\"$(omarchy-capture-screenshot smart save)\" && [[ -n $file ]] && satty --filename \"$file\" --output-filename \"$file\"'")

-- Launcher / menus
o.bind("SUPER + A", "Launch apps", "omarchy-menu toggle apps")
hl.unbind("SUPER + ESCAPE") -- default: System menu
o.bind("SUPER + ESCAPE", "Omarchy menu", "omarchy-menu toggle root")
o.bind("SUPER + SHIFT + ESCAPE", "System menu", "omarchy-menu toggle system")
hl.unbind("SUPER + C") -- default: Universal copy
o.bind("SUPER + C", "Calculator", "omacalc")

-- Mouse move/resize on button 277 (as before), alongside default SUPER+LMB/RMB.
o.bind("mouse:277", "Move window", hl.dsp.window.drag(), { mouse = true })
o.bind("SHIFT + mouse:277", "Resize window", hl.dsp.window.resize(), { mouse = true })

-- Mic (input) volume on SHIFT + media keys.
hl.unbind("SHIFT + XF86AudioMute") -- default: Switch audio output
o.bind("SHIFT + XF86AudioMute", "Mic mute toggle", "omarchy-audio-input-mute", { locked = true })
o.bind("SHIFT + XF86AudioRaiseVolume", "Mic volume up", "$HOME/.config/hypr/scripts/audio-input-volume raise", { locked = true, repeating = true })
o.bind("SHIFT + XF86AudioLowerVolume", "Mic volume down", "$HOME/.config/hypr/scripts/audio-input-volume lower", { locked = true, repeating = true })

-- HJKL focus / swap
hl.unbind("SUPER + H")
hl.unbind("SUPER + J") -- default: toggle window split
hl.unbind("SUPER + K") -- default: keybindings menu
hl.unbind("SUPER + L") -- default: toggle workspace layout
o.bind("SUPER + H", "Focus window left", "$HOME/.config/hypr/scripts/focus-direction l")
o.bind("SUPER + J", "Focus window down", "$HOME/.config/hypr/scripts/focus-direction d")
o.bind("SUPER + K", "Focus window up", "$HOME/.config/hypr/scripts/focus-direction u")
o.bind("SUPER + L", "Focus window right", "$HOME/.config/hypr/scripts/focus-direction r")
hl.unbind("SUPER + ALT + K") -- default: tmux keybindings menu
o.bind("SUPER + ALT + H", "Swap window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + ALT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + ALT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + ALT + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Show key bindings", "omarchy-menu-keybindings")
o.bind("SUPER + SHIFT + L", "Cycle workspace layout", "$HOME/.config/hypr/scripts/cycle-workspace-layout")
