return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local status_install, ts_install = pcall(require, "nvim-treesitter.install")
      local status_parsers, ts_parsers = pcall(require, "nvim-treesitter.parsers")

      if not (status_install and status_parsers) then
        return
      end

      local ensure_installed = {
        "bash", "css", "html", "javascript", "json", "jsonc",
        "lua", "markdown", "markdown_inline", "rust", "python", "vim", "vimdoc",
      }

      local installed = {}
      if ts_parsers.get_installed_parsers then
        installed = ts_parsers.get_installed_parsers()
      end

      local to_install = {}
      for _, lang in ipairs(ensure_installed) do
        if not vim.tbl_contains(installed, lang) then
          table.insert(to_install, lang)
        end
      end

      if #to_install > 0 then
        vim.schedule(function()
          ts_install.update({ with_sync = false })(to_install)
        end)
      end

      local ignore_filetype = { "checkhealth", "lazy", "mason", "TelescopePrompt", "NvimTree" }
      local group = vim.api.nvim_create_augroup("UserTreesitterSetup", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(ev)
          if vim.tbl_contains(ignore_filetype, ev.match) then return end

          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
          if ts_parsers.has_parser(lang) then
            pcall(vim.treesitter.start, ev.buf, lang)
          end
        end,
      })
    end,
  },
}
