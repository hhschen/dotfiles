return {
  { -- File browser (oil.nvim like)
    "echasnovski/mini.files",
    lazy = false,
    priorty = 100,
    keys = {
      { "<leader>_", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "Open file explorer" },
      { "<leader>-", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "Open current file parent directory" },
    },
    opts = {
      mappings = { -- Override some keymaps
        go_in = "<CR>",
        go_in_plus = "l",
        go_out = "-",
        go_out_plus = "h",
      },
      windows = {
        width_focus = 40,
        width_nofocus = 20,
      }
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end
  },
  { -- Snacks picker
    "folke/snacks.nvim",
    opts = {
      picker = {
        enabled = true,
        matcher = {
          frecency = true,      -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
      },
    },
    keys = {
      -- Find
      { "<leader><space>", function() Snacks.picker.smart() end,              desc = "Smart Find Files" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,            desc = "Buffers" },
      { "<leader>fd",      function() Snacks.picker.diagnostics_buffer() end, desc = "Current Buffer Diagnostics" },
      { "<leader>fD",      function() Snacks.picker.diagnostics() end,        desc = "CWD Diagnostics" },
      { "<leader>ff",      function() Snacks.picker.files() end,              desc = "Find Files" },
      { "<leader>fh",      function() Snacks.picker.help() end,               desc = "Help Pages" },
      { "<leader>fk",      function() Snacks.picker.keymaps() end,            desc = "Keymaps" },
      { "<leader>fl",      function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
      { "<leader>fr",      function() Snacks.picker.recent() end,             desc = "Recent" },
      { "<leader>fw",      function() Snacks.picker.grep_word() end,          desc = "Visual selection or word",  mode = { "n", "x" } },
      { "<leader>f/",      function() Snacks.picker.grep() end,               desc = "Grep" },
      { "<leader>f?",      function() Snacks.picker.grep_buffers() end,       desc = "Grep Open Buffers" },
      { "<leader>f:",      function() Snacks.picker.command_history() end,    desc = "Command History" },
      { "<leader>f.",      function() Snacks.picker.resume() end,             desc = "Resume" },
      { '<leader>f"',      function() Snacks.picker.registers() end,          desc = "Registers" },

      -- Git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,       desc = "Git Branches" },
      { "<leader>gl",      function() Snacks.picker.git_log() end,            desc = "Git Log" },
      { "<leader>gs",      function() Snacks.picker.git_stash() end,          desc = "Git Stash" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,           desc = "Git Diff (Hunks)" },
      { "<leader>gf",      function() Snacks.picker.git_files() end,          desc = "Git File" },
    }
  }
}
