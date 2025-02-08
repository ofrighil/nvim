vim.opt.number = true
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- experiment with these
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.scrollloff = 8

vim.opt.termguicolors = true

vim.opt.updatetime = 50
vim.opt.timeoutlen = 500
