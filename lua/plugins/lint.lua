return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local markdownlint = require("lint").linters.markdownlint
    markdownlint.cmd = "markdownlint-cli2"
    lint.linters_by_ft = {
      python = { "ruff" }, -- requires ruff to be installed
      lua = { "luacheck" }, -- requires luacheck to be installed
      sh = { "shellcheck" }, -- requires shellcheck to be installed
      nix = { "nix" }, -- requires nix to be installed
      markdown = { "markdownlint" }, -- requires markdownlint to be installed
      javascript = { "eslint" }, -- requires eslint to be installed
      javascriptreact = { "eslint" }, -- requires eslint to be installe
      typescript = { "eslint" }, -- requires eslint to be installed
      typescriptreact = { "eslint" }, -- requires eslint to be installed
    }
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
