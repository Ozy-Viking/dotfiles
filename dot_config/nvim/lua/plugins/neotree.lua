return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        use_libuv_file_watcher = true,
        filesystem = {
            filtered_items = {
                -- when true, they will just be displayed differently than normal items
                visible = true,
                -- whether children of filtered parents should inherit their parent's highlight group
                children_inherit_highlights = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_ignored = false, -- hide files that are ignored by other gitignore-like files
                -- other gitignore-like files, in descending order of precedence.
                ignore_files = {
                    ".neotreeignore",
                    ".ignore",
                    -- ".rgignore"
                },
                hide_hidden = false, -- only works on Windows for hidden files/directories
                hide_by_name = {
                    ".DS_Store",
                    "thumbs.db",
                    --"node_modules",
                },
                hide_by_pattern = {
                    --"*.meta",
                    --"*/src/*/tsconfig.json",
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    --".gitignored",
                },
                always_show_by_pattern = { -- uses glob style patterns
                    --".env*",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    --".DS_Store",
                    --"thumbs.db",
                },
                never_show_by_pattern = { -- uses glob style patterns
                    --".null-ls_*",
                },
            },
        }
    }

}
