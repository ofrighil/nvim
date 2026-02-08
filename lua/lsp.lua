vim.lsp.set_log_level(vim.log.levels.OFF)

local servers = {
  lua_ls = "lua-language-server",
  nil_ls = "nil",
  ocamllsp = "ocamllsp",
  ty = "ty",
  rust_analyzer = "rust-analyzer",
}

for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.enable(name)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "●" },
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      signs = true,
      underline = true,
      update_in_insert = false,
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
      end,
    })

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    ---@cast client -nil

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gi", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition)

    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

    vim.keymap.set("n", "<leader>[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end)
    vim.keymap.set("n", "<leader>]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)

    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

    if client:supports_method("inlayHintProvider") then
      vim.keymap.set("n", "gih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
    end
  end,
})
