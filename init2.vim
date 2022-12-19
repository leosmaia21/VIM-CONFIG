" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
"Search files
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'
"themes
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline-themes'
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
"LSP and all the godies
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'romgrk/barbar.nvim'
"Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
"Embedded terminal
Plug 'voldikss/vim-floaterm'
"Comment
Plug 'tpope/vim-commentary'
"Git
Plug 'tpope/vim-fugitive'
"Others
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'
" Plug '907th/vim-auto-save'
Plug 'pseewald/vim-anyfold'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'machakann/vim-highlightedyank'
"Moving
Plug 'unblevable/quick-scope'
"42
Plug '42Paris/42header'
" Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'
call plug#end()

let g:user42 = 'ledos-sa'
let g:mail42 = 'ledos-sa@student.42.fr'

filetype plugin indent on
syntax enable
set rnu
set number
set cursorline
set noexpandtab
set tabstop=4
set shiftwidth=4
set cursorcolumn
set nowrap
set noswapfile
set incsearch
set scrolloff=8
set signcolumn=yes
set smartindent
set smarttab
set ignorecase
set hidden
set mouse=
set mousemodel=extend
set selectmode+=mouse

let mapleader = " "

" fold mas com o plugin
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
set foldlevel=0  " close all folds
set foldlevel=99 " Open all folds

"Quickscope conf
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5ffffff' gui=underline ctermfg=81 cterm=underline
augroup END

"To remember the cursor position 
augroup remember
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

let g:floaterm_keymap_toggle = '<F6>'
let g:floaterm_width  = 0.9
let g:floaterm_height = 1.0

nnoremap <silent> <leader>q :lua require("harpoon.ui").toggle_quick_menu()<Enter>
nnoremap <silent> <leader>i :lua require("harpoon.mark").add_file()<Enter>

noremap <Tab> >>
noremap <S-Tab> << 
noremap <C-w> <C-w>w

nnoremap <silent>    <A-h> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-l> <Cmd>BufferNext<CR>
nnoremap <silent>    <A-q> <Cmd>BufferClose<CR>
nnoremap <leader><Tab> <C-6> 

let g:gruvbox_bold = 0 
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox
let g:airline_theme = 'gruvbox'

nmap <space>e <Cmd>CocCommand explorer <CR>
autocmd BufEnter * if(winnr("$") == 1 && &filetype=='coc-explorer') | q | endif

" refresh do coc explorer sempre que é gravado um ficheiro para atualizar os
" erros nos outros ficheiros
autocmd BufWritePost * call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])

" Configuracao para aparecer a linha em insert mode e o bloco em normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
set ttyfast
set encoding=utf-8

"telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set updatetime=100
set signcolumn=yes

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
if CocAction('hasProvider', 'hover')
call CocActionAsync('doHover')
else
call feedkeys('K', 'in')
endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nmap <leader>a  <Plug>(coc-codeaction-selected)
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-explorer', 'coc-pairs', 'coc-flutter']
let g:coc_user_config ={
	\'colors.enable': v:true,
	\'diagnostic.virtualText': v:true,
	\'diagnostic.virtualTextCurrentLineOnly': v:false,
	\'explorer.git.enable': v:true, 
	\'semanticTokens.enable': v:true,
	\'explorer.icon.enableNerdfont': v:true,
	\'explorer.previewAction.onHover': v:false,
	\'explorer.position': 'left',
	\'coc.preferences.extensionUpdateCheck': 'daily',
	\'explorer.buffer.root.template': '[icon & 1] OPEN EDITORS',
	\'explorer.file.root.template': '[icon & 1] PROJECT ([root])',
	\'explorer.file.child.template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5]',
	\'explorer.file.showHiddenFiles': v:true,
	\'explorer.file.reveal.auto': v:false,
	\'explorer.width': 30,
	\'explorer.keyMappings.global':{
			\ "<cr>":["wait", "expandable?", ["expanded?", "collapse", "expand"], "open"],
			\ "<BS>":["wait", "collapse"]
	  \ },
	\}
" Enable norminette-vim (and gcc)
" let g:syntastic_c_checkers = ['norminette']
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_c_norminette_exec = 'norminette'
" let g:c_syntax_for_h = 1
" let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']
" let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'
" let g:syntastic_check_on_open = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_wq = 0

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

function! Save_all_exit()
	execute "wa"
	execute "qa"
endfunction
nnoremap <leader>z :call     Save_all_exit()

" lua <<EOF
" EOF

" require'nvim-treesitter.configs'.setup{
" 			highlight= {
" 			enable =  true,
" 			disable = {"lua"},
"     		additional_vim_regex_highlighting = true,
" 	}
" }
