local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})

vim.keymap.set('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
vim.keymap.set('n', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

vim.keymap.set('n', '<C-w>', '<C-w>w')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader><Tab>', '<C-6>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', "<S-Tab>", "<gv")
vim.keymap.set('v', "<Tab>", ">gv")

-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move to previous/next
vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)

vim.keymap.set('n', '<leader>i', ":call setline('.', getline('.') . '	#type: ignore')<CR>")

vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

vim.keymap.set('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set('n', '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set('n', '<F11>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set('n', '<F12>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set('n', '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.keymap.set('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.keymap.set('n', '<Leader>rr', "<Cmd>lua require'dap'.repl.open()<CR>", opts)
vim.keymap.set('n', '<Leader>dl', "<Cmd>lua require'dap'.run_last()<CR>", opts)

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
