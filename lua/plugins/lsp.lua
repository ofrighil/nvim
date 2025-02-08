return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "saghen/blink.cmp" },
    { "j-hui/fidget.nvim", opts = {} },
    {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
  },
  config = function()
    local lsp = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    lsp.lua_ls.setup({ capabilities = capabilities })
    lsp.nil_ls.setup({ capabilities = capabilities })
    lsp.pyright.setup({ capabilities = capabilities })
  end,
}
