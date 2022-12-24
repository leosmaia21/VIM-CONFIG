local ensure_packer = function()  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

print("Frase do dia: nao aguentabas nao binhas!")

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'
	use {'neoclide/coc.nvim', branch = 'release'}
	use 'morhetz/gruvbox'
	use 'sainnhe/gruvbox-material'
	use 'rose-pine/neovim'

	use 'ThePrimeagen/harpoon'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'tpope/vim-commentary'
	use {'sakhnik/nvim-gdb', run = './install.sh'}
	-- use 'voldikss/vim-floaterm'
	-- use 'honza/vim-snippets'
	-- use 'SirVer/ultisnips'
	use 'romgrk/barbar.nvim'
	use 'nvim-tree/nvim-web-devicons'
	use 'vim-airline/vim-airline'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	use 'voldikss/vim-floaterm'

	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end}

	use '42Paris/42header'
	if packer_bootstrap then
		require('packer').sync()
	end
end)

vim.cmd[[ let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pairs'] ]]

vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

vim.o.termguicolors = true
vim.o.syntax = "ON"
-- vim.o.filetype = "ON"
vim.g.gruvbox_bold = 0 
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd.colorscheme("gruvbox")

vim.g.mapleader = " "

vim.o.rnu = true
vim.o.number = true
-- vim.o.cursorline = true
-- vim.o.cursorcolumn = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.ignorecase = true
vim.o.hidden = true
vim.o.undofile = true

require('coc_config')
require('keymap')

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim", "lua", "c", "python" },
  auto_install = true,
  highlight = {
	  enable = true,
	  additional_vim_regex_highlighting = true
  },
}
require("nvim-tree").setup{
   diagnostics = {enable=true, show_on_dirs=true},
   view = { relativenumber = true}
}

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
  end
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
	group = vim.api.nvim_create_augroup("SavePositionWhenLeaving", {clear = true})
})

require("toggleterm").setup{
  open_mapping = '<C-t>',
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'horizontal',
  close_on_exit = true,
}

-- Automatically source and re-compile packer whenever you save this init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = vim.api.nvim_create_augroup('Packer', { clear = true }),
  pattern = vim.fn.expand '$MYVIMRC',
})


function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

vim.api.nvim_create_user_command("Showgdb",
function(opts)
	if opts.args == "" then
		vim.cmd("!rm -f debug_gdb")
		vim.cmd("!gcc -g *.c -o debug_gdb")
		if file_exists("debug_gdb") then
			vim.cmd("GdbStart gdb -q ./debug_gdb")
			vim.cmd("GdbCreateWatch info locals")
		end
	elseif opts.fargs[1] == "-b" then
		if file_exists(opts.fargs[2]) then
			vim.cmd("GdbStart gdb -q " .. opts.fargs[2])
			vim.cmd("GdbCreateWatch info locals")
		else
			print("O ficheiro não existe!")
		end
	else
		vim.cmd("!rm -f debug_gdb")
		vim.cmd("!gcc -g -o debug_gdb " .. opts.args)
		if file_exists("debug_gdb") then
			vim.cmd("GdbStart gdb -q ./debug_gdb")
			vim.cmd("GdbCreateWatch info locals")
		end
	end
end,
{nargs = "*", count = true})
