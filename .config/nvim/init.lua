if vim.loader then
  vim.loader.enable()
end

require('config.options')
require('config.lazy')
require('config.lsp')
