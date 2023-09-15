return {
  "simrat39/rust-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  opts = {
    on_initialized = function()
      vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
    end,
  },
  config = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "K", "<CMD>RustHoverActions<CR>", { buffer = bufnr, desc = "Hover Documentation" })
          -- Code action groups
          vim.keymap.set("n", "<leader>ca", "<CMD>RustCodeAction<CR>", { buffer = bufnr, desc = "Code [A]ction" })
          -- Run tests
          vim.keymap.set("n", "<leader>ct", "<CMD>RustRunnables<CR>", { buffer = bufnr, desc = "[T]est" })
        end,
      },
    })
  end,
}
