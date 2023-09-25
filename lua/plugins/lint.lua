return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local markdownlint = require("lint").linters.markdownlint
    markdownlint.cmd = "markdownlint-cli2"
    lint.linters_by_ft = {
      python = { "ruff", "codespell" },            -- requires ruff to be installed
      lua = { "luacheck", "codespell" },           -- requires luacheck to be installed
      sh = { "shellcheck", "codespell" },          -- requires shellcheck to be installed
      markdown = { "markdownlint", "codespell" },  -- requires markdownlint to be installed
    }
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
