--return {
--  "rebelot/kanagawa.nvim",
--  config = function()
--    require("kanagawa").setup({
--      compile = false,
--      undercurl = true,
--      commentStyle = { italic = false, },
--      functionStyle = {},
--      keywordStyle = { italic = false },
--      statementStyle = { bold = true, },
--      typeStyle = {},
--      transparent = true,
--      dimInactive = false,
--      terminalColors = true,
--      theme = "wave",
--      background = {
--        dark = "wave",
--        light = "lotus",
--      },
--    })
--
--    vim.cmd("colorscheme kanagawa")
--  end
--}
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme tokyonight-moon")
  end
}
