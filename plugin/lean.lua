vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = "*.lean",
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/julian/lean.nvim" })
    require("lean").setup({ mappings = true })
  end,
})
