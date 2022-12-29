
if vim.g.vscode  then
require('keymap')
else
require('config')
require('coc_config')
require('keymap')
end
