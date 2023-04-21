local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Automatically applies the dotfile change on save to my chezmoi dotfile dir.
autocmd("BufWritePost", {
  pattern = "~/.local/share/chezmoi/*)",
  command = "chezmoi apply --source-path \"%\""
})
