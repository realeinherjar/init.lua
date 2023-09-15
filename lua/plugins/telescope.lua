return {
  {
    "nvim-telescope/telescope.nvim", -- Telescope
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>?", "<CMD>Telescope oldfiles<CR>", desc = "[?] Find recently opened files" },
      { "<leader><space>", "<CMD>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
      {
        "<leader>/",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        desc = "[/] Fuzzily search in current buffer]",
      },
      { "<leader>sr", "<CMD>Telescope resume<CR>", desc = "[R]esume Previous Seasch" },
      { "<leader>sf", "<CMD>Telescope git_files<CR>", desc = "[F]iles" },
      { "<leader>sF", "<CMD>Telescope find_files<CR>", desc = "[F]iles All" },
      { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "[H]elp" },
      { "<leader>sw", "<CMD>Telescope grep_string<CR>", desc = "Current [W]ord" },
      { "<leader>sg", "<CMD>Telescope live_grep<CR>", desc = "[G]rep" },
      { "<leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "[D]iagnostics" },
      { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "[M]arks" },
      { "<leader>sc", "<CMD>Telescope git_bcommits<CR>", desc = "[C]ommits File" },
      { "<leader>sC", "<CMD>Telescope git_commits<CR>", desc = "[C]ommits" },
      { "<leader>ss", "<CMD>Telescope git_status<CR>", desc = "[S]tatus" },
      { "<leader>sS", "<CMD>Telescope git_stash<CR>", desc = "[S]tash" },
      { "<leader>sT", "<CMD>Telescope git_stash<CR>", desc = "[T]reesitter" },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
