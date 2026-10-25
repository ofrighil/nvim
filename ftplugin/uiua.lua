local function run()
  vim.cmd.write()
  local file = vim.api.nvim_buf_get_name(0)

  vim.system({ "uiua", "run", "--no-format", file }, { text = true }, function(out)
    vim.schedule(function()
      local text = out.stdout .. out.stderr
      local lines = vim.split(vim.trim(text), "\n")

      local buf = vim.fn.bufnr("uiua://output")
      if buf == -1 then
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(buf, "uiua://output")
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      if vim.fn.bufwinid(buf) == -1 then
        local win = vim.api.nvim_get_current_win()
        vim.cmd("botright 12split")
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_set_current_win(win)
      end
    end)
  end)
end

local links = {
  stack_function = "@punctuation.delimiter",
  noadic_function = "@constant.builtin",
  monadic_function = "@function",
  dyadic_function = "@function.builtin",
  triadic_function = "@function.method",
  tetradic_function = "@function.macro",
  monadic_modifier = "@keyword",
  dyadic_modifier = "@keyword.operator",
  triadic_modifier = "@keyword.function",
  uiua_number = "@number",
  uiua_string = "@string",
  uiua_constant = "@constant",
  uiua_module = "@module",
}
for token, group in pairs(links) do
  vim.api.nvim_set_hl(0, "@lsp.type." .. token .. ".uiua", { link = group })
end

vim.keymap.set("n", "<leader>r", run, { buffer = true, desc = "Run Uiua file" })
