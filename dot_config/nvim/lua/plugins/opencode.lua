return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            optional = true,
            opts = {
                input = {}, -- Enhances `ask()`
                picker = { -- Enhances `select()`
                    actions = {
                        opencode_send = function(...)
                            return require("opencode").snacks_picker_send(...)
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
                terminal = {}, -- Enables the `snacks` provider
            },
        },
        "folke/which-key.nvim",
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
            { "<leader>a", group = "AI" },

            {
                -- Nested mappings are allowed and can be added in any order
                -- Most attributes can be inherited or overridden on any level
                -- There's no limit to the depth of nesting
                mode = { "n", "v" }, -- NORMAL and VISUAL mode
                {
                    "<leader>aa",
                    function()
                        require("opencode").ask("@this: ", { submit = true })
                    end,
                    desc = "Ask opencode…",
                },
                {
                    "<leader>ax",
                    function()
                        require("opencode").select()
                    end,
                    desc = "Execute opencode action",
                },
                {
                    "<leader>a.",
                    function()
                        require("opencode").toggle()
                    end,
                    desc = "Toggle opencode",
                },
                {
                    "<leader>a.",
                    function()
                        require("opencode").toggle()
                    end,
                    desc = "Toggle opencode",
                },
            },
        })
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        -- vim.keymap.set({ "n", "x" }, "<C-a>", function()
        --     require("opencode").ask("@this: ", { submit = true })
        -- end, { desc = "Ask opencode…" })
        -- vim.keymap.set({ "n", "x" }, "<C-x>", function()
        --     require("opencode").select()
        -- end, { desc = "Execute opencode action…" })
        -- vim.keymap.set({ "n", "t" }, "<C-.>", function()
        --     require("opencode").toggle()
        -- end, { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "x" }, "go", function()
            return require("opencode").operator("@this ")
        end, { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n", "goo", function()
            return require("opencode").operator("@this ") .. "_"
        end, { desc = "Add line to opencode", expr = true })

        vim.keymap.set("n", "<S-C-u>", function()
            require("opencode").command("session.half.page.up")
        end, { desc = "Scroll opencode up" })
        vim.keymap.set("n", "<S-C-d>", function()
            require("opencode").command("session.half.page.down")
        end, { desc = "Scroll opencode down" })

        -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
        -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
        -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
}
