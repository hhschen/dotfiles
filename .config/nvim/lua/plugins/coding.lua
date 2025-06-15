return {
  { -- Completeion
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    version = '1.*',
    opts_extend = { "sources.default" },
    opts = {
      enabled = function()
        -- Disabled in filetype
        local filetype = vim.bo[0].filetype
        if filetype == "minifiles" or filetype == "snacks_picker_input" then
          return false
        end
        return true
      end,
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      cmdline = { enabled = false },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      keymap = { -- See :h blink-cmp-config-keymap
        preset = "enter",
        ["<C-h>"] = { 'show', 'show_documentation', 'hide_documentation' },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      -- LSP capabilities
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
    end,
  },
  { -- Autopairs
    "echasnovski/mini.pairs",
    version = false,
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    }
  },
  { -- Surround
    "echasnovski/mini.surround",
    version = false,
    keys = {
      { "sa", desc = "Add Surrounding", mode = { "n", "v" } },
      { "sd", desc = "Delete Surrounding" },
      { "sf", desc = "Find Right Surrounding" },
      { "sF", desc = "Find Left Surrounding" },
      { "sh", desc = "Highlight Surrounding" },
      { "sr", desc = "Replace Surrounding" },
      { "sn", desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = {
      highlight_duration = 300,
    }
  },
}
