return {
  cmd = { "uiua", "lsp" },
  filetypes = { "uiua" },
  root_markers = { "main.ua", ".fmt.ua", ".git" },
  settings = {
    uiua = {
      inlayHints = {
        values = true,
        bindingSignatureHints = true,
        inlineSignatureHints = true,
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
}
