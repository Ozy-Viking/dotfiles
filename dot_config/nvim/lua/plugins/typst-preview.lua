local path_len = function(path)
    return select(2, string.gsub(path, "/", "")) + 1
end

return {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    keys = {
        { "<leader>tP", "<cmd>TypstPreview<cr>", desc = "[T]ypst [P]review" }
    },
    opts = {
        dependencies_bin = { ['tinymist'] = 'tinymist' },
        -- get_main_file = function(path_of_buffer)
        --     local main_dir = vim.fn.getenv('TYPST_ROOT')
        --
        --     if main_dir == vim.NIL then
        --         local config = require("typst-preview.config")
        --         main_dir = config.opts.get_root(path_of_buffer)
        --     end
        --
        --     local found = vim.fs.find({ 'main.typ' }, { path = main_dir, upward = true, limit = 3 })
        --     if #found > 0 then
        --         local path_length = 100000
        --         local ret_path = ""
        --         for _, path in ipairs(found) do
        --             if path_len(path) < path_length then
        --                 ret_path = path
        --             end
        --         end
        --         return ret_path
        --     end
        --     return path_of_buffer
        -- end
    } -- lazy.nvim will implicitly calls `setup {}`
}
