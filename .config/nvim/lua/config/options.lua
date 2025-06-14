-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Appearance
vim.opt.background = "dark"
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.statuscolumn = '%s%=%{&relativenumber ? (v:virtnum == 0 ? (v:relnum > 0 ? v:relnum : v:lnum) : " ") : ""} '
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.wrap = false

-- Title
vim.opt.title = true
vim.opt.titlestring = "%t" -- this will define tmux or terminal window title.
vim.opt.titleold = '%{fnamemodify(getcwd(), ":t")}'
vim.opt.titlelen = 70

-- Indent
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 2

--Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true  -- Don't ignore case with capitals
vim.opt.showmatch = true

-- Backup
vim.opt.backup = false
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.confirm = true  -- prompt to save before destructive actions
vim.opt.swapfile = false
vim.opt.undofile = true -- Save undo history
vim.opt.writebackup = false

-- Other
vim.g.netrw_banner = 0                -- do not display info on the top of window
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.formatoptions:append({ "r" }) -- add asterisks in block comments
-- vim.opt.shell = "zsh"
vim.opt.path:append({ "**" })         -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.whichwrap:append("<>hl")      -- h, l goto next/previous line when cursor is begin/end of line
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.tbl_map(function(p)
  vim.g["loaded_" .. p] = vim.endswith(p, "provider") and 0 or 1
end, {
  "ruby_provider",
  "perl_provider",
  "node_provider"
})
vim.opt.mouse = ""
