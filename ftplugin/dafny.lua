local function dafny(subcommand)
  vim.cmd.write()
  local file = vim.api.nvim_buf_get_name(0)

  vim.system({ "dafny", subcommand, file }, { text = true }, function(out)
    vim.schedule(function()
      local text = out.stdout .. out.stderr
      local lines = vim.split(vim.trim(text), "\n")

      local buf = vim.fn.bufnr("dafny://output")
      if buf == -1 then
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(buf, "dafny://output")
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

vim.api.nvim_buf_create_user_command(0, "DafnyVerify", function()
  dafny("verify")
end, { desc = "Verify Dafny file" })
vim.api.nvim_buf_create_user_command(0, "DafnyRun", function()
  dafny("run")
end, { desc = "Run Dafny file" })

vim.keymap.set("n", "<leader>v", "<cmd>DafnyVerify<cr>", { buffer = true, desc = "Verify Dafny file" })
vim.keymap.set("n", "<leader>r", "<cmd>DafnyRun<cr>", { buffer = true, desc = "Run Dafny file" })
