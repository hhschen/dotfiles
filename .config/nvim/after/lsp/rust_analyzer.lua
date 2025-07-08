local function reload_workspace(bufnr)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr, name = 'rust_analyzer' }) do
    vim.notify('Reloading Cargo Workspace')
    client.request('rust-analyzer/reloadWorkspace', nil, function(err)
      if err then
        vim.notify('Error reloading workspace: ' .. tostring(err), vim.log.levels.ERROR)
        return
      end
      vim.notify('Cargo workspace reloaded')
    end, bufnr)
  end
end

---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  capabilities = {
    experimental = { serverStatusNotification = true },
  },
  filetypes = { "rust", "toml.Cargo" },
  root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
  -- See more: https://rust-analyzer.github.io/book/configuration.html
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
        features = "all",
        allTargets = true,
      },
      diagnostics = {
        styleLints = { enable = true }
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
  before_init = function(init_params, config)
    -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
    if config.settings and config.settings['rust-analyzer'] then
      init_params.initializationOptions = config.settings['rust-analyzer']
    end
  end,
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoReload', function()
      reload_workspace(bufnr)
    end, { desc = 'Reload current cargo workspace' })
  end,
}
