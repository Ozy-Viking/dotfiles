return {
    "nat-418/boole.nvim",
    config = function()
        require("boole").setup({
            mappings = {
                increment = "<C-a>",
                decrement = "<C-x>",
            },
            -- User defined loops
            additions = {
            },
            allow_caps_additions = {
                { "enable",  "disable" },
                { "enabled", "disabled" },
                { "left",    "up",      "right", "down" },
                { "north",   "east",    "south", "west" }
            },
        })
    end,
}
