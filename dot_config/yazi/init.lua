require("zoxide"):setup({
	update_db = true,
})
require("yafg"):setup({
	editor = "nvim", -- Editor command (default: "hx")
	args = { "--noplugin" }, -- Additional editor arguments (default: {})
	file_arg_format = "+{row} {file}", -- File argument format (default: "{file}:{row}:{col}")
})

if os.getenv("NVIM") then
	require("toggle-pane"):entry("min-preview")
end
-- ~/.config/yazi/init.lua
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
-- require("rich-preview").setup({
--     arguments = { "-j",
--         "--center",
--         "--line-numbers",
--         "--force-terminal",
--         "--panel=rounded",
--         "--guides",
--         "--max-width" }
-- })

require("sshfs"):setup({
	-- Mount directory
	mount_dir = os.getenv("HOME") .. "/.sshfs",

	-- Password authentication attempts before giving up
	password_attempts = 3,

	-- Default mount point: Go to home, root, or always ask where to go
	default_mount_point = "auto", -- home | root | auto

	-- Default user selection: Use SSH config user or prompt for choice
	default_user = "auto", -- auto | prompt

	-- SSHFS mount options (array of strings)
	-- These options are passed directly to the sshfs command
	sshfs_options = {
		"reconnect", -- Auto-reconnect on connection loss
		"ConnectTimeout=5", -- Connection timeout in seconds
		"compression=yes", -- Enable compression
		"ServerAliveInterval=15", -- Keep-alive interval (15s × 3 = 45s timeout)
		"ServerAliveCountMax=3", -- Keep-alive message count
		-- "dir_cache=yes",               -- Enable directory caching (default: yes)
		-- "dcache_timeout=300",          -- Cache timeout in seconds
		-- "dcache_max_size=10000",       -- Max cache size
		-- "allow_other",                 -- Allow other users to access mount
		-- "uid=1000,gid=1000",           -- Set file ownership
		-- "follow_symlinks",             -- Follow symbolic links
	},

	-- Picker UI settings
	ui = {
		-- Maximum number of items to show in the menu picker.
		-- If the list exceeds this number, a different picker (like fzf) is used.
		menu_max = 15, -- Recommended: 10–20. Max: 36.

		-- Picker strategy:
		-- "auto": uses menu if items <= menu_max, otherwise fzf (if available) or a filterable list
		-- "fzf": always use fzf if available, otherwise fallback to a filterable list
		picker = "auto", -- "auto" | "fzf"
	},
})
