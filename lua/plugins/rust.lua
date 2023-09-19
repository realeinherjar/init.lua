return {
  {
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
          end,
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      {
        "rouge8/neotest-rust",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter",
          "antoinemadec/FixCursorHold.nvim",
        },
      },
    },
    config = function()
      require("neotest").setup({
        status = { virtual_text = true },
        output = { open_on_run = true },
        adapters = {
          require("neotest-rust"),
        },
      })
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
    },
  },
}
