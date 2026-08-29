vim.api.nvim_create_user_command("AutoRain", function()
  vim.pack.add({ "https://github.com/Eandrju/cellular-automaton.nvim" })
  vim.cmd("CellularAutomaton make_it_rain")
end, { desc = "Make it rain" })

vim.api.nvim_create_user_command("AutoGame", function()
  vim.pack.add({ "https://github.com/Eandrju/cellular-automaton.nvim" })
  vim.cmd("CellularAutomaton game_of_life")
end, { desc = "Game of Life" })
