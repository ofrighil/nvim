return {
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    vim.keymap.set("n", "<leader>fc", function()
      conform.format({ async = true })
    end)
  end,
}
