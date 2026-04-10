vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.keymap.set("n", "<leader>[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "<leader>]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
  end,
})
