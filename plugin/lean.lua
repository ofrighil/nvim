vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("user-lean", { clear = true }),
  pattern = "*.lean",
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/julian/lean.nvim" })
    require("lean").setup({ mappings = true })
  end,
})
