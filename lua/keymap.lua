local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
vim.keymap.set('n', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

vim.keymap.set('n', '<C-w>', '<C-w>w')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader><Tab>', '<C-6>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', "<S-Tab>", "<gv")
vim.keymap.set('v', "<Tab>", ">gv")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move to previous/next
vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)

vim.keymap.set('n', '<leader>i', ":call setline('.', getline('.') . '	#type: ignore')<CR>")

vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

local width = vim.api.nvim_get_option("columns")
width = tostring(math.max(math.ceil(width * 1 / 3), 30))
width = "ToggleTerm direction=vertical size=" .. width
local opts = {noremap = true}
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>w]])
vim.api.nvim_create_user_command('Termv', width,{})
vim.api.nvim_create_user_command('Termh', 'ToggleTerm direction=horizontal',{})
vim.api.nvim_create_user_command('Termf', 'ToggleTerm direction=float',{})


vim.cmd[[
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction
autocmd TermOpen * startinsert

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }
]]
