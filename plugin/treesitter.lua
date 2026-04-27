vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({ "ocaml", "python", "rust" })
