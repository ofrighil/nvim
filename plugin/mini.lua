vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local mini_icons = require("mini.icons")
mini_icons.setup({})
mini_icons.mock_nvim_web_devicons()

local mini_misc = require("mini.misc")
mini_misc.setup({})
mini_misc.setup_restore_cursor()
mini_misc.setup_auto_root()

require("mini.statusline").setup({ use_icons = true })

require("mini.snippets").setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
})

require("mini.completion").setup({
  lsp_completion = {
    source_func = "omnifunc",
    auto_setup = false,
  },
})

local group = vim.api.nvim_create_augroup("user-mini-completion", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end
  end,
})

require("mini.ai").setup({
  custom_textobjects = {
    F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
  },
})
