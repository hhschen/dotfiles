return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = "TSUpdate",
    config = function()

      local ensure_installed = {
        "bash", "css", "html", "javascript", "json",
        "lua", "markdown", "markdown_inline", "rust", "python", "vim", "vimdoc",
      }
      require("nvim-treesitter").install(ensure_installed)

      local ignore_filetype = { "checkhealth", "lazy", "mason", "TelescopePrompt", "NvimTree", "notify" }
      local group = vim.api.nvim_create_augroup("UserTreesitterSetup", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(ev)
          if vim.tbl_contains(ignore_filetype, ev.match) then return end

          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match

          local ok, _ = pcall(vim.treesitter.start, ev.buf, lang)
          if ok then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldlevel = 99

            pcall(function()
              vim.bo[ev.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
            end)
          end
        end,
      })
    end,
  },
}
