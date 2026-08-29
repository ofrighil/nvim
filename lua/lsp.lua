vim.lsp.log.set_level(vim.log.levels.OFF)

local servers = {
  hls = "haskell-language-server",
  lua_ls = "lua-language-server",
  nil_ls = "nil",
  ocamllsp = "ocamllsp",
  ts_ls = "typescript-language-server",
  ty = "ty",
  rust_analyzer = "rust-analyzer",
}

for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.enable(name)
  end
end

local group = vim.api.nvim_create_augroup("user-lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    ---@cast client -nil

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = args.buf })

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf })

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = args.buf })
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = args.buf })
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = args.buf })

    if client:supports_method("inlayHintProvider") then
      vim.keymap.set("n", "gih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { buffer = args.buf })
    end
  end,
})
