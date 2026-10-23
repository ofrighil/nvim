vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local pick = require("mini.pick")
pick.setup({})
require("mini.extra").setup({})

local builtin = pick.builtin

vim.keymap.set("n", "<leader>ff", builtin.files)
vim.keymap.set("n", "<leader>fg", builtin.grep_live)
vim.keymap.set("n", "<leader>f/", function()
  MiniExtra.pickers.buf_lines({ scope = "current" })
end)

vim.keymap.set("n", "<leader>ft", function()
  local names = vim.tbl_keys(pick.registry)
  table.sort(names)
  pick.start({
    source = {
      name = "Pickers",
      items = names,
      choose = function(name)
        vim.schedule(pick.registry[name])
      end,
    },
  })
end)

vim.keymap.set("n", "<leader>fw", function()
  builtin.grep({ pattern = vim.fn.expand("<cword>"), method = "plain" })
end)
vim.keymap.set("n", "<leader>fW", function()
  builtin.grep({ pattern = vim.fn.expand("<cWORD>"), method = "plain" })
end)

vim.keymap.set("n", "<leader>fh", builtin.help)

vim.keymap.set("n", "<leader>en", function()
  builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
end)
