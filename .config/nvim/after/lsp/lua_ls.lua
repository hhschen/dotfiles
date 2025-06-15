---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostic = {
        globals = { "vim" },
      },
      doc = { privateName = "^_" },
      runtime = { version = "LuaJIT" },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
      },
    },
  },
  root_markers = {
    '.git',
    '.luarc.json',
    '.luarc.jsonc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
  },
}
