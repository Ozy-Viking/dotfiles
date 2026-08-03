return {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
        formatters_by_ft = {
            typst = { "typstyle", lsp_format = "prefer" },
        },
    }
}
