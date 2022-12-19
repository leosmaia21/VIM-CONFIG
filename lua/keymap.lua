local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.g.floaterm_keymap_toggle = '<F6>'
vim.g.floaterm_width  = 0.9
vim.g.floaterm_height = 0.9

vim.keymap.set('n', '<C-w>', '<C-w>w')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader><Tab>', '<C-6>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', "<", "<gv")
vim.keymap.set('v', ">", ">gv")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move to previous/next
vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)


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
function! ShowGDB(compile = "y",...)
	if a:compile == "y"
		execute "!gcc -g *.c"
		execute "GdbStart gdb -q ./a.out"
		:GdbCreateWatch info locals
	endif
	if a:compile == "d"
		let l:dir_counter = 1
		let l:dirs = ""
		while l:dir_counter <= a:0
			let l:dirs .= a:{l:dir_counter} . " "
			let l:dir_counter += 1
		endwhile
		execute "!gcc -g " l:dirs
		execute "GdbStart gdb -q ./a.out"
		execute "GdbCreateWatch info locals"
	endif
endfunction
command! -nargs=* ShowGdb :call     ShowGDB(<f-args>)
]]
