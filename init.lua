local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

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
	use 'voldikss/vim-floaterm'
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

	use {
		's1n7ax/nvim-terminal',
		config = function()
			vim.o.hidden = true
			require('nvim-terminal').setup()
		end,
	}

	use '42Paris/42header'
	if packer_bootstrap then
		require('packer').sync()
	end
end)

vim.cmd[[ let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pairs'] ]]

vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

vim.o.termguicolors = true
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

require('coc_config')
require('keymap')

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim", "lua", "c", "rust" },
  auto_install = true,
  highlight = {
	  enable = true,
	  additional_vim_regex_highlighting = true

  },
}
require("nvim-tree").setup{
   diagnostics = {enable=true, show_on_dirs=true}
}

local gNvim = vim.api.nvim_create_augroup("CloseNvimTree", {clear = true})
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end,
  group = gNvim
})

local gClose = vim.api.nvim_create_augroup("SavePositionWhenLeaving", {clear = true})
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
	group = gClose,
})
