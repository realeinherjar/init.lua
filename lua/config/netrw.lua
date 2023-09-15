-------------------------------------------------------------------------------
--  Netrw Customizations
-------------------------------------------------------------------------------

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.api.nvim_create_autocmd("filetype", {
  pattern = "netrw",
  desc = "Better mappings for netrw",
  callback = function()
    -- edit new file
    vim.keymap.set("n", "n", "%", { remap = true, buffer = true })
    -- rename file
    vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
  end,
})
