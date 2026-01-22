vim.lsp.set_log_level("WARN")

local servers = {
  lua_ls = "lua-language-server",
  nil_ls = "nil",
  ocamllsp = "ocamllsp",
  ty = "ty",
  rust_analyzer = "rust-analyzer"
}

for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.enable(name)
  end
end


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.diagnostic.config({virtual_lines = {current_line = true}, }) -- { virtual_text = false, virtual_lines = { current_line = true }, })

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
