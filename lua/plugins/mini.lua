return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.statusline").setup({ use_icons = true })
    end,
  },
}
