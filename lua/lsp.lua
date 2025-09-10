vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ty")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition)

    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

    if client:supports_method("inlayHintProvider") then
      vim.keymap.set("n", "gih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
    end
  end,
})
