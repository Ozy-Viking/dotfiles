-- return {
--     "nosduco/remote-sshfs.nvim",
--     dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
--     opts = {
--         -- Refer to the configuration section below
--         -- or leave empty for defaults
--         -- mounts = {
--         --     base_dir = vim.fn.expand("$HOME") .. "/.local/state/sshfs/", -- base directory for mount points
--         --     unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
--         -- },
--     },
-- }

return {
    "uhs-robert/sshfs.nvim",
    opts = {
        -- Refer to the configuration section below
        -- or leave empty for defaults
        global_paths = {
            -- Optionally define default mount paths for ALL hosts
            -- These appear as options when connecting to any host
            "~/.config",
            -- "/var/www",
            -- "/srv",
            -- "/opt",
            -- "/var/log",
            -- "/etc",
            -- "/tmp",
            -- "/usr/local",
            -- "/data",
            -- "/var/lib",
            "/home",
        },
        mounts = {
            base_dir = vim.fn.expand("$HOME") .. "/.sshfs", -- where remote mounts are created
        },
        host_paths = {
            -- Optionally define default mount paths for specific hosts
            -- These are shown in addition to global_paths
            -- Single path (string):
            -- ["my-server"] = "/var/www/html"
            --
            -- Multiple paths (array):
            ["nas"] = { "/mnt/SSDs" },
        },
        on_mount = {
            auto_change_to_dir = true, -- auto-change current directory to mount point
            auto_run = "live_find", -- "find" (default), "grep", "live_find", "live_grep", "terminal", "none", or a custom function(ctx)
        },
        ui = {
            local_picker = {
                preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "mini", "telescope", "oil", "neo-tree", "nvim-tree", "yazi", "lf", "nnn", "ranger", "netrw"
                fallback_to_netrw = false, -- fallback to netrw if no picker is available
                netrw_command = "Explore", -- netrw command: "Explore", "Lexplore", "Sexplore", "Vexplore", "Texplore"
            },
            remote_picker = {
                preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "telescope", "mini"
            },
        },
    },
}
