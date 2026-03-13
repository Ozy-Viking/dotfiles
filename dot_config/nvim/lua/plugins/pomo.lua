return {
    {
        "epwalsh/pomo.nvim",
        version = "*", -- Recommended, use latest release instead of latest commit
        lazy = true,
        cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
        dependencies = {
            -- Optional, but highly recommended if you want to use the "Default" timer
            "rcarriga/nvim-notify",
            "nvim-telescope/telescope.nvim",
        },
        keymaps = {},
        opts = {
            -- How often the notifiers are updated.
            update_interval = 250,

            -- Configure the default notifiers to use for each timer.
            -- You can also configure different notifiers for timers given specific names, see
            -- the 'timers' field below.
            notifiers = {
                -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
                {
                    name = "Default",
                    opts = {
                        -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
                        -- continuously displayed. If you only want a pop-up notification when the timer starts
                        -- and finishes, set this to false.
                        sticky = true,

                        -- Configure the display icons:
                        title_icon = "󱎫",
                        text_icon = "󰄉",
                        -- Replace the above with these if you don't have a patched font:
                        -- title_icon = "⏳",
                        -- text_icon = "⏱️",
                    },
                },

                -- The "System" notifier sends a system notification when the timer is finished.
                -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
                { name = "System" },

                -- You can also define custom notifiers by providing an "init" function instead of a name.
                -- See "Defining custom notifiers" below for an example 👇
                -- { init = function(timer) ... end }
            },

            -- Override the notifiers for specific timer names.
            timers = {
                -- For example, use only the "System" notifier when you create a timer called "Break",
                -- e.g. ':TimerStart 2m Break'.
                Break = {
                    { name = "System" },
                },
            },
            -- You can optionally define custom timer sessions.
            sessions = {
                -- Example session configuration for a session called "pomodoro".
                pomodoro = {
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Long Break", duration = "15m" },
                },
            },
        },
        config = function(_, opts)
            local pomo = require("pomo").setup(opts)
            require("telescope").load_extension("pomodori")
            local wk = require("which-key")
            wk.add({
                { "<leader>p", group = "Pomodoro Timer" },

                {
                    mode = { "n", "v" }, -- NORMAL and VISUAL mode
                    {
                        "<leader>ps",
                        "<cmd>TimerSession pomodoro<cr>",
                        desc = "Pomodoro Start",
                    },
                    {
                        "<leader>pS",
                        "<cmd>TimerStop<cr>",
                        desc = "Pomodoro Stop Last",
                    },
                    {
                        "<leader>pH",
                        "<cmd>TimerHide -1<cr>",
                        desc = "Pomodoro Hide All",
                    },
                    {
                        "<leader>pT",
                        "<cmd>TimerShow -1<cr>",
                        desc = "Pomodoro Show All",
                    },
                    {
                        "<leader>pP",
                        "<cmd>TimerPause -1<cr>",
                        desc = "Pomodoro Pause All",
                    },
                    {
                        "<leader>pR",
                        "<cmd>TimerResume -1<cr>",
                        desc = "Pomodoro Resume All",
                    },
                    {
                        "<leader>ph",
                        "<cmd>TimerHide<cr>",
                        desc = "Pomodoro Hide Last",
                    },
                    {
                        "<leader>pt",
                        "<cmd>TimerShow<cr>",
                        desc = "Pomodoro Show Last",
                    },
                    {
                        "<leader>pp",
                        "<cmd>TimerPause<cr>",
                        desc = "Pomodoro Pause Last",
                    },
                    {
                        "<leader>pr",
                        "<cmd>TimerResume<cr>",
                        desc = "Pomodoro Resume Last",
                    },
                    {
                        "<leader>p5",
                        "<cmd>TimerStart 5m 5\\ Minute<cr>",
                        desc = "5 Minute Timer",
                    },
                    {
                        "<leader>pm",
                        function()
                            require("telescope").extensions.pomodori.timers()
                        end,
                        desc = "Manage Pomodori Timers",
                    },
                },
            })
        end,
    },
}
