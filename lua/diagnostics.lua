vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
