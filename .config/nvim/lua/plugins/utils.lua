return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      indent = { enabled = true },
      lazygit = { enabled = true },
      scope = { enabled = true },
      notifier = {      -- This will replace notify.nvim
        enabled = true,
        timeout = 2000, -- shorter than default 3000 ms
      },
      quickfile = { enabled = true },
    },
    keys = {
      { "<leader>rf", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>n-", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notification" },
      { "<leader>gL", function() Snacks.lazygit() end,               desc = "Lazygit" },
    }
  },
  { -- Icons
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

}
