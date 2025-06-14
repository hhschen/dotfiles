--- General LSP Settings ---
vim.lsp.config('*', {
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true
      }
    }
  }
})

vim.lsp.enable({
  'clangd',
  'lua_ls',
  'rust_analyzer',
})


-- LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, silent = true, desc = "LSP: " .. desc })
    end

    -- Snacks picker
    map("gd", Snacks.picker.lsp_definitions, "Goto Definition")
    map("gD", Snacks.picker.lsp_declarations, "Goto Declaration")
    map("gR", Snacks.picker.lsp_references, "References")
    map("gI", Snacks.picker.lsp_implementations, "Goto Implementation")
    map("gy", Snacks.picker.lsp_type_definitions, "Goto T[y]pe Definition")
    map("<leader>cs", Snacks.picker.lsp_symbols, "Symbols")
    map("<leader>cS", Snacks.picker.lsp_workspace_symbols, "Workspace Symbols")

    -- Override Neovim lsp builtin
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>cf", vim.lsp.buf.format, "Format")
  end,
})

--- Diagnostic ---
local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    current_line = true,
    spacing = 5,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}
vim.diagnostic.config(vim.deepcopy(diagnostics))

if vim.fn.has("nvim-0.10.0") == 0 then
  if type(diagnostics.signs) ~= "boolean" then
    for severity, icon in pairs(diagnostics.signs.text) do
      local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
  end
end
