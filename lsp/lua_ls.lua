return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      workspace = {
        library = { "/run/current-system/sw/share/hypr/stubs" },
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
