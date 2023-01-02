-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

print("Frase do dia: nao aguentabas nao binhas!")

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {'neoclide/coc.nvim', branch = 'release'}
	use 'morhetz/gruvbox'
	use 'sainnhe/gruvbox-material'
	use 'bluz71/vim-nightfly-colors'
	use 'navarasu/onedark.nvim'
	use 'ThePrimeagen/harpoon'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'tpope/vim-commentary'
	use {'sakhnik/nvim-gdb', run = './install.sh'}
	use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use 'theHamsta/nvim-dap-virtual-text'
	use 'mfussenegger/nvim-dap-python'
	use 'romgrk/barbar.nvim'
	use 'vim-airline/vim-airline'
	-- use 'psliwka/vim-smoothie'
	use 'karb94/neoscroll.nvim'
	use {'nvim-treesitter/nvim-treesitter',
	run = function()
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		ts_update() end
	}
	use {'nvim-tree/nvim-tree.lua', requires = {
		'nvim-tree/nvim-web-devicons'},tag = 'nightly'}
	use {'akinsho/toggleterm.nvim', tag = '*'}
	use "windwp/nvim-autopairs"
		
	-- use 'preservim/tagbar'
	use '42Paris/42header'
	if is_bootstrap then
		require('packer').sync()
	end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end


vim.cmd[[ let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pyright'] ]]
vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

vim.g.mapleader = " "
-- vim.cmd[[ filetype plugin indent on ]]
vim.o.termguicolors = true
vim.g.gruvbox_bold = 0 
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = 'hard'
vim.o.background = 'dark'
vim.cmd.colorscheme('nightfly')
-- require('onedark').setuptt
--     style = 'darker'
-- }
-- require('onedark').load()
-- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

vim.o.rnu = true
vim.o.number = true
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
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.nofoldenable = true
vim.o.foldlevel = 99

require('coc_config')
require('keymap')
require('debugger')


require("nvim-autopairs").setup({map_cr = false})
require('neoscroll').setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim", "lua", "c", "python" },
  auto_install = true,
  highlight = {enable = true}
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

local save = vim.api.nvim_create_augroup("SavePositionWhenLeaving", {clear = true})
vim.api.nvim_create_autocmd({ "BufWrite" }, {
    pattern = { "*" },
	command= "mkview",
	group = save
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
	command= "silent! loadview",
	group = save
})

require("toggleterm").setup{
  open_mapping = '<C-t>',
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_mode = false,
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
	if name == nil then return false end
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
	elseif opts.fargs[1] == "-mb" then
		vim.cmd("!make")
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
end, {nargs = "*", count = true})
