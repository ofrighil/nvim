vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require("fidget").setup({
  progress = { display = { done_ttl = 3 }},
  notification = { window = { winblend = 0 }}
})
