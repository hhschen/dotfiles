return {
  {
    "craftzdog/solarized-osaka.nvim",
    -- The event is for quick startuptime. If you find the theme blinking at startup unbearable
    -- or encounter any bugs, please consider commenting it out.
    event = "UIEnter",
    -- lazy = false,
    -- priorty = 1000,
    config = function()
      require("solarized-osaka").setup({
        style = "night",
        transparent = true,
        styles = { -- I don't like italic
          comments = { italic = false },
          keywords = { italic = false }
        }
      })
      vim.cmd([[colorscheme solarized-osaka]])
    end
  },
}
