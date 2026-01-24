-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	desc = "Auto select virtualenv Nvim open",
-- 	pattern = "*",
-- 	callback = function()
-- 		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
-- 		if venv ~= "" then
-- 			require("venv-selector").retrieve_from_cache()
-- 		end
-- 	end,
-- 	once = true,
-- })

vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "xdg-open", pdf_path })
    end
end, {})
