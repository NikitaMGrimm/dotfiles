local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- vim.api.nvim_exec([[
--   augroup chezmoi_apply
--     autocmd!
--     autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
--   augroup END
-- ]], true)

autocmd("BufWritePost", {
  pattern = "~/.local/share/chezmoi/*",
  command = "chezmoi apply --source-path \"%\""
})
