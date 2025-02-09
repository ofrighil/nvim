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

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

        if client.server_capabilities.inlayHintProvider then
          vim.keymap.set("n", "gih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end)
        end
      end,
    })
  end,
}
