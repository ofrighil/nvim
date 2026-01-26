return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    defaults = { wrap_results = true },
    pickers = {
      find_files = { theme = "ivy" },
      builtin = { theme = "dropdown" },
    },
    extensions = { fzf = {} },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")

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
  end,
}
