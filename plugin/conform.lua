vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
  notify_on_error = true,
  formatters_by_ft = {
    javascript = { "prettier" },
    lua = { "stylua" },
    nix = { "nixfmt" },
    ocaml = { "ocamlformat" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    rust = { "rustfmt" },
  },
})

vim.keymap.set("n", "<leader>fc", function()
  conform.format({ async = true })
end)
