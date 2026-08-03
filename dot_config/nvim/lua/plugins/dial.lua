return {
    "monaqa/dial.nvim",
    recommended = true,
    desc = "Increment and decrement numbers, dates, and more",
    -- stylua: ignore
    keys = {
        { "<C-a>",  function() return require("dial.map").inc_normal() end,    expr = true, desc = "Increment", mode = { "n" } },
        { "<C-a>",  function() return require("dial.map").inc_visual() end,    expr = true, desc = "Increment", mode = { "v" } },
        { "<C-x>",  function() return require("dial.map").dec_normal() end,    expr = true, desc = "Decrement", mode = { "n" } },
        { "<C-x>",  function() return require("dial.map").dec_visual() end,    expr = true, desc = "Decrement", mode = { "v" } },
        { "g<C-a>", function() return require("dial.map").inc_gnormal() end,   expr = true, desc = "Increment", mode = { "n" } },
        { "g<C-a>", function() return require("dial.map").inc_gvisual() end,   expr = true, desc = "Increment", mode = { "x" } },
        { "g<C-x>", function() return require("dial.map").dec_gnormal() end,   expr = true, desc = "Decrement", mode = { "n" } },
        { "g<C-x>", function() return require("dial.map").dec_gvisual() end,   expr = true, desc = "Decrement", mode = { "x" } },
    },
    opts = function()
        local augend = require("dial.augend")

        local logical_alias = augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
        })

        local enable_disable = {
            augend.constant.new({
                elements = { "enable", "disable" },
                word = true,
                cyclic = true,
            }),
            augend.constant.new({
                elements = { "Enable", "Disable" },
                word = true,
                cyclic = true,
            }),
            augend.constant.new({
                elements = { "enabled", "disabled" },
                word = true,
                cyclic = true,
            }),
            augend.constant.new({
                elements = { "Enabled", "Disabled" },
                word = true,
                cyclic = true,
            }),
        }

        local ordinal_numbers = augend.constant.new({
            -- elements through which we cycle. When we increment, we go down
            -- On decrement we go up
            elements = {
                "first",
                "second",
                "third",
                "fourth",
                "fifth",
                "sixth",
                "seventh",
                "eighth",
                "ninth",
                "tenth",
            },
            -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
            word = false,
            -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
            -- Otherwise nothing will happen when there are no further values
            cyclic = true,
        })

        local months = augend.constant.new({
            elements = {
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December",
            },
            word = true,
            cyclic = true,
        })

        local fav_date = augend.date.new({
            pattern = "%-d %b %y",
            default_kind = "day",
            only_valid = true,
            word = false,
        })

        return {
            dials_by_ft = {
                css = "css",
                vue = "vue",
                javascript = "typescript",
                typescript = "typescript",
                typescriptreact = "typescript",
                javascriptreact = "typescript",
                json = "json",
                lua = "lua",
                markdown = "markdown",
                sass = "css",
                scss = "css",
                python = "python",
            },
            groups = {
                default = {
                    augend.integer.alias.binary,
                    augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
                    augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
                    augend.date.alias["%d/%m/%Y"],
                    ordinal_numbers,
                    augend.constant.alias.en_weekday_full,
                    augend.constant.alias.en_weekday,
                    augend.semver.alias.semver,
                    months,
                    augend.constant.alias.bool, -- boolean value (true <-> false)
                    augend.constant.alias.Bool, -- boolean value (True <-> False)
                    logical_alias,
                    enable_disable[1],
                    enable_disable[2],
                    enable_disable[3],
                    enable_disable[4],
                    fav_date,
                },
                vue = {
                    augend.constant.new({ elements = { "let", "const" } }),
                    augend.hexcolor.new({ case = "lower" }),
                    augend.hexcolor.new({ case = "upper" }),
                },
                typescript = {
                    augend.constant.new({ elements = { "let", "const" } }),
                },
                css = {
                    augend.hexcolor.new({
                        case = "lower",
                    }),
                    augend.hexcolor.new({
                        case = "upper",
                    }),
                },
                markdown = {
                    augend.constant.new({
                        elements = { "[ ]", "[x]" },
                        word = false,
                        cyclic = true,
                    }),
                    augend.misc.alias.markdown_header,
                },
                json = {
                    augend.semver.alias.semver, -- versioning (v1.1.2)
                },
                lua = {
                    augend.constant.new({
                        elements = { "and", "or" },
                        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    }),
                },
                python = {
                    augend.constant.new({
                        elements = { "and", "or" },
                    }),
                },
                rust = {
                    augend.constant.new({
                        elements = { "pub", "pub(crate)", "pub(super)", "pub(self)" },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { "pub fn", "pub(crate) fn", "pub(super) fn", "pub(self) fn", "fn" },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { "pub mod", "pub(crate) mod", "pub(super) mod", "pub(self) mod", "mod" },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { "pub enum", "pub(crate) enum", "pub(super) enum", "pub(self) enum", "enum" },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = {
                            "pub struct",
                            "pub(crate) struct",
                            "pub(super) struct",
                            "pub(self) struct",
                            "struct",
                        },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { "pub use", "pub(crate) use", "pub(super) use", "pub(self) use", "use" },
                        word = true,
                        cyclic = true,
                    }),
                },
            },
        }
    end,
    config = function(_, opts)
        -- copy defaults to each group
        for name, group in pairs(opts.groups) do
            if name ~= "default" then
                vim.list_extend(group, opts.groups.default)
            end
        end
        require("dial.config").augends:register_group(opts.groups)
        vim.g.dials_by_ft = opts.dials_by_ft
    end,
}
