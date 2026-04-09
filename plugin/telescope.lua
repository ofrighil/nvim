vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })

require("telescope").setup({
  defaults = { wrap_results = true },
  pickers = {
    find_files = { theme = "ivy" },
    builtin = { theme = "dropdown" },
  },
  extensions = { fzf = {} },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>ft", builtin.builtin)
vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>fw", function()
  builtin.grep_string({ search = vim.fn.expand("<cword>") })
end)
vim.keymap.set("n", "<leader>fW", function()
  builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
end)

vim.keymap.set("n", "<leader>fh", builtin.help_tags)

vim.keymap.set("n", "<leader>en", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    vim.wo.wrap = true
    if args.data.filetype ~= "help" then
      vim.wo.number = true
    end
  end,
})
