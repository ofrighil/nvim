vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
  "telescope",
  winopts = { preview = { wrap = true } },
  fzf_opts = { ["--wrap"] = true },
})

vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fg", fzf.live_grep)
vim.keymap.set("n", "<leader>ft", fzf.builtin)
vim.keymap.set("n", "<leader>f/", fzf.blines)
vim.keymap.set("n", "<leader>fw", fzf.grep_cword)
vim.keymap.set("n", "<leader>fW", fzf.grep_cWORD)
vim.keymap.set("n", "<leader>fh", fzf.helptags)
vim.keymap.set("n", "<leader>fb", fzf.buffers)
vim.keymap.set("n", "<leader>f.", fzf.resume)

vim.keymap.set("n", "<leader>en", function()
  fzf.files({ cwd = vim.fn.stdpath("config") })
end)

vim.keymap.set("n", "<leader>lr", fzf.lsp_references)
vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols)
vim.keymap.set("n", "<leader>lS", fzf.lsp_live_workspace_symbols)
vim.keymap.set("n", "<leader>ld", fzf.diagnostics_document)
vim.keymap.set("n", "<leader>lD", fzf.diagnostics_workspace)

vim.keymap.set("n", "<leader>gs", fzf.git_status)
vim.keymap.set("n", "<leader>gc", fzf.git_commits)
vim.keymap.set("n", "<leader>gC", fzf.git_bcommits)
vim.keymap.set("n", "<leader>gb", fzf.git_branches)
