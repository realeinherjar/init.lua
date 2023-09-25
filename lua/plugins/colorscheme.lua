return {
  {
    "ellisonleao/gruvbox.nvim", -- Set colorscheme to Gruvbox Theme
    lazy = false,               -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,            -- make sure to load this before all
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
      vim.o.termguicolors = true
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "nvim-lualine/lualine.nvim", -- Fancier statusline
    event = "VeryLazy",
    dependencies = { "ellisonleao/gruvbox.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "gruvbox",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
}
