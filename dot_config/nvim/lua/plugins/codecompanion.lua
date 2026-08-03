return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
        interactions = {
            chat = {
                adapter = {
                    name = "opencode",
                    model = "openrouter/openai/gpt-5.4-mini",
                },
                opts = {
                    completion_provider = "blink",
                },
            },

            cli = {
                agent = "claude_code",
                agents = {
                    claude_code = {
                        cmd = "claude",
                        args = {},
                        description = "Claude Code CLI",
                        provider = "terminal",
                    },
                },
            },
        },
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
