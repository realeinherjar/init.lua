-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Lazy redraw for crazy macros
--vim.opt.lazyredraw = true

-- A lot of plugins depends on hidden true
vim.opt.hidden = true

-- set command line height to zero/two lines
-- vim.opt.cmdheight = 2
vim.opt.cmdheight = 0

-- Statusbar
vim.opt.laststatus = 3

-- Winbar on top of the windows
vim.opt.winbar = "%=%m %f"

-- Enable mouse mode
vim.opt.mouse = "a"

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 50

-- No wrap
vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true

-- Better undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = "yes"

-- color column
vim.opt.colorcolumn = "80"

-- Window splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>")

-- File explorer
vim.keymap.set("n", "<C-p>", vim.cmd.Ex)

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Better movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set(
  "n",
  "<leader>R",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "[R]edraw / clear hlsearch / diff update" }
)

-- J/K to move up/down visual lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Easy save
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true, desc = "[S]ave File" })

-- Easy Quit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { silent = true, desc = "[Q]uit" })
vim.keymap.set("n", "<leader>Q", "<CMD>qa!<CR>", { silent = true, desc = "[Q]uit Force All" })

-- Global Yank/Paste
vim.keymap.set(
  { "n", "v" },
  "<leader>y",
  '"*y :let @+=@*<CR>',
  { noremap = true, silent = true, desc = "Global [Y]ank" }
)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Global [P]aste" })

-------------------------------------------------------------------------------
--  Netrw Customizations
-------------------------------------------------------------------------------

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    -- edit new file
    vim.keymap.set("n", "n", "%", { remap = true, buffer = true })
    -- rename file
    vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
  end
})

-------------------------------------------------------------------------------
--  Highlight on Yank
-------------------------------------------------------------------------------
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-------------------------------------------------------------------------------
-- Restore Cursors
-------------------------------------------------------------------------------
-- See `:help restore-cursor`
local restore_group = vim.api.nvim_create_augroup("RestoreGroup", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  command = [[call setpos(".", getpos("'\""))]],
  group = restore_group,
  pattern = "*",
})

-------------------------------------------------------------------------------
-- Bootstrap Package Manager
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy2/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
require("lazy").setup({
  {
    "folke/tokyonight.nvim", -- Set colorscheme to Gruvbox Theme
    lazy = false,            -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,         -- make sure to load this before all
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"
      vim.cmd.colorscheme("tokyonight")
    end,
    keys = {
      { "<leader>l", "<cmd>Lazy<cr>", desc = "[L]azy" },
    }
  },
  {
    "nvim-lualine/lualine.nvim", -- Fancier statusline
    event = "VeryLazy",
    dependencies = { "folke/tokyonight.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim", -- Telescope
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>?",       "<CMD>Telescope oldfiles<CR>", desc = "[?] Find recently opened files" },
      { "<leader><space>", "<CMD>Telescope buffers<CR>",  desc = "[ ] Find existing buffers" },
      {
        "<leader>/",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        desc = "[/] Fuzzily search in current buffer]",
      },

      { "<leader>sf", "<CMD>Telescope find_files<CR>",  desc = "[F]iles" },
      { "<leader>sh", "<CMD>Telescope help_tags<CR>",   desc = "[H]elp" },
      { "<leader>sw", "<CMD>Telescope grep_string<CR>", desc = "Current [W]ord" },
      { "<leader>sg", "<CMD>Telescope live_grep<CR>",   desc = "[G]rep" },
      { "<leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "[D]iagnostics" },
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
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "hrsh7th/nvim-cmp",         -- Autocompletion plugin
      "hrsh7th/cmp-buffer",       -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path",         -- nvim-cmp source for filesystem paths
      "hrsh7th/cmp-nvim-lua",     -- nvim-cmp source for neovim Lua API
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip",         -- Snippets plugin
      "folke/neodev.nvim",        -- Neovim development Lua utils
      "petertriho/cmp-git",       -- nvim-cmp source for git
      -- Copilot
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
      },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        config = true,
      }
    },
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup()
      local lsp = require("lspconfig")
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[D]iagnostics: Goto Previous" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[D]iagnostics: Goto Next" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "[D]iagnostics: Op[e]n Float" })
      vim.keymap.set("n", "<leader>k", vim.diagnostic.setloclist, { desc = "[D]iagnostics: Set" })
      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- Code Actions
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" })
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { desc = "Code [A]ction" }
          )
          -- Definitions
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            { desc = "[G]oto [I]mplementation" }
          )
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
          vim.keymap.set(
            "n",
            "<leader>sD",
            require("telescope.builtin").lsp_document_symbols,
            { desc = "[D]ocument [S]ymbols" }
          )
          vim.keymap.set(
            "n",
            "<leader>ss",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { desc = "[S]ymbols" }
          )
          -- See `:help K` for why this keymap
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
          vim.keymap.set(
            "n",
            "<C-k>",
            vim.lsp.buf.signature_help,
            { desc = "Signature Documentation" }
          )
          -- Lesser used LSP functionality
          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { desc = "[G]oto [D]eclaration" }
          )
          vim.keymap.set(
            "n",
            "<leader>D",
            vim.lsp.buf.type_definition,
            { desc = "Type [D]efinition" }
          )
          vim.keymap.set(
            "n",
            "<leader>cwa",
            vim.lsp.buf.add_workspace_folder,
            { desc = "[A]dd Folder" }
          )
          vim.keymap.set(
            "n",
            "<leader>cwr",
            vim.lsp.buf.remove_workspace_folder,
            { desc = "[R]emove Folder" }
          )
          vim.keymap.set("n", "<leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "[L]ist Folders" })
          -- Format
          vim.keymap.set("n", "<leader>F", function()
              vim.lsp.buf.format({ async = true })
            end,
            { desc = "[F]ormat current buffer with LSP" })
          vim.keymap.set("n", "<leader>f", "<CMD>Format<CR>",
            { desc = "[F]ormat current buffer with Formatter" })
          -- Autoformat on save (LSP)
          -- vim.api.nvim_create_autocmd("BufWritePre", {
          --   callback = function()
          --     vim.lsp.buf.format({ async = false })
          --   end,
          -- })
          -- Autoformat on save (Formatter)
          -- vim.api.nvim_create_autocmd("BufWritePre", {
          --   command = "FormatWrite",
          -- })
        end,
      })
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- nvim-cmp setup
      local cmp = require("cmp")
      -- luasnip setup
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})
      -- tab fix for copilot
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
          end
        end,
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = "copilot",  group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip",  group_index = 2 },
          -- { name = "buffer", group_index = 2 },
          { name = "path",     group_index = 2 },
        },
        sorting = { -- copilot_cmp suggestion
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            -- Below is the default comparator list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer", group_index = 2 },
        })
      })
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", group_index = 2 },
        }
      })
      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      lsp.pyright.setup({ capabilities = capabilities })  -- requires pyright to be installed
      lsp.tsserver.setup({ capabilities = capabilities }) -- requires typescript-language-server to be installed
      lsp.bashls.setup({ capabilities = capabilities })   -- requires bash-language-server to be installed
      lsp.html.setup({ capabilities = capabilities })     -- requires vscode-langservers-extracted to be installed
      lsp.cssls.setup({ capabilities = capabilities })    -- requires vscode-langservers-extracted to be installed
      lsp.jsonls.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
      lsp.eslint.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
      lsp.lua_ls.setup({                                  -- requires lua-language-server to be installed
        capabilities = capabilities,
        settings = {
          Lua = {
            telemetry = { enable = false },
          },
        },
      })
      lsp.rust_analyzer.setup({ -- requires rust-analyzer to be installed
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      })
    end,
  },
  -- LSP Formatters and Linters
  -- null-ls is archived
  {
    "mhartington/formatter.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local formatter = require("formatter")
      formatter.setup({
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua, -- requires stylua to be installed
          },
          rust = {
            require("formatter.filetypes.rust").rustfmt, -- requires rustfmt to be installed
          },
          python = {
            require("formatter.filetypes.python").black, -- requires black to be installed
          },
          sh = {
            require("formatter.filetypes.sh").shfmt, -- requires shfmt to be installed
          },
          fish = {
            require("formatter.filetypes.fish").fishindent, -- requires fish to be installed
          },
          html = {
            require("formatter.filetypes.html").prettierd, -- requires prettierd to be installed
          },
          css = {
            require("formatter.filetypes.css").prettierd, -- requires prettierd to be installed
          },
          markdown = {
            require("formatter.filetypes.markdown").prettierd, -- requires prettierd to be installed
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },            -- requires ruff to be installed
        lua = { "luacheck" },           -- requires luacheck to be installed
        sh = { "shellcheck" },          -- requires shellcheck to be installed
        markdown = { "markdownlint" },  -- requires markdownlint to be installed
        javascript = { "eslint" },      -- requires eslint to be installed
        javascriptreact = { "eslint" }, -- requires eslint to be installe
        typescript = { "eslint" },      -- requires eslint to be installed
        typescriptreact = { "eslint" }, -- requires eslint to be installed
      }
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "cpp",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "tsx",
          "typescript",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-S>",
            node_decremental = "<C-bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  -- Undotree
  {
    "mbbill/undotree",
    evenvt = "VeryLazy",
    config = true,
    keys = { { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "[U]ndo Tree" } },
  },
  -- Git related plugins
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next Hunk" })
          vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous Hunk" })
          -- Actions
          vim.keymap.set({ "n", "v" }, "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>",
            { buffer = bufnr, desc = "[S]tage" })
          vim.keymap.set({ "n", "v" }, "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>",
            { buffer = bufnr, desc = "[R]eset" })
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "[S]tage File" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[U]ndo" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "[R]eset File" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[P]review" })
          vim.keymap.set("n", "<leader>hb", function()
              gs.blame_line({ full = true })
            end,
            { buffer = bufnr, desc = "[B]lame line" })
          vim.keymap.set("n", "<leader>hB", gs.toggle_current_line_blame,
            { buffer = bufnr, desc = "Toggle [B]lame Line" })
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "[D]iff This" })
          vim.keymap.set("n", "<leader>hD", function()
              gs.diffthis("~")
            end,
            { buffer = bufnr, desc = "[D]iff This ~" })
          vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle Deleted" })
          -- Text object
          vim.keymap.set({ "o", "x" }, "ih", "<CMD><C-U>Gitsigns select_hunk<CR>",
            { buffer = bufnr, desc = "GitSigns Select Hunk" })
        end,
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gi", "<CMD>Git<CR>",                 desc = "[Gi]t" },
      -- It allows me to easily set the branch I am pushing and any tracking
      { "<leader>gt", "<CMD>Git push -u origin <CR>", desc = "[G]it Push [T]agging" },
    },
  },
  {
    "tpope/vim-rhubarb", -- Fugitive-companion to interact with github
    event = "VeryLazy",
  },
  -- Miscellaneous
  "tpope/vim-sleuth",       -- Detect tabstop and shiftwidth automatically
  {
    "folke/which-key.nvim", -- popup with possible key bindings of the command you started typing
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>cw"] = { name = "+workspace" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+hunks" },
        ["<leader>s"] = { name = "+search" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" }, -- 'gc' to comment visual regions/lines
  { "windwp/nvim-autopairs", config = true },                     -- Autopair stuff like ({["'
  {
    "kylechui/nvim-surround",                                     -- Surround selections
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = "*",
    config = true,
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
