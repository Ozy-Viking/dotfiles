return {
    {
        "catppuccin",
        optional = true,
        opts = {
            integrations = { blink_cmp = true },
        },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            fuzzy = {
                implementation = "prefer_rust",
            },
            sources = {
                providers = {
                    codecompanion = {
                        name = "CodeCompanion",
                        module = "codecompanion.providers.completion.blink",
                        enabled = true,
                    },
                },
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
            },
        },
    },
    {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "1.*",
    },
}
