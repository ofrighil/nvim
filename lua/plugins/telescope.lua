return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    pickers = { find_files = { theme = "ivy" } },
    extensions = { fzf = {} },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)

    vim.keymap.set("n", "<leader>en", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end)
  end,
}
