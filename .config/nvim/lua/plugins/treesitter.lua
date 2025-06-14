return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    opts = {
      sync_install = true,
      auto_install = false,
      ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "python",
        "vim",
        "vimdoc",
      },
      autopairs = { enable = true },
      indent = { enable = true },
      highlight = { enable = true, },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
