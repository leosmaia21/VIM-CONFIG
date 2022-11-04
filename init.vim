" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
"Search files
Plug 'preservim/NERDTree'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"themes
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline-themes'
 
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

"LSP and all the godies
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'romgrk/barbar.nvim'
Plug 'sbdchd/neoformat'
" Plug 'jiangmiao/auto-pairs'

"Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

"Embedded terminal
Plug 'voldikss/vim-floaterm'

"Comment
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'

"Git
Plug 'tpope/vim-fugitive'
" Plug 'kdheepak/lazygit.nvim'  "Para isto funcionar é preciso instalar o
"Lazygit no PC 

"Others
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'
Plug '907th/vim-auto-save'
Plug 'pseewald/vim-anyfold'

" Plug 'kshenoy/vim-signature'

" Python
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
" Plug 'numirias/semshi'

call plug#end()

let g:coc_default_semantic_highlight_groups = 1


filetype plugin indent on
syntax on
set rnu
set number
set cursorline
set tabstop=4
set shiftwidth=4
"set expandtab
set cursorcolumn
set nowrap
set noswapfile
set incsearch
set scrolloff=8
set signcolumn=yes
set smartindent
set ignorecase
set hidden
set mouse=a

let mapleader = " "

" set viewdir=$HOME/.vim_view//
" set foldmethod=syntax
" set foldnestmax=10
" set foldlevel=99
" set nofoldenable
" set foldclose=all
" set foldopen=all

" fold mas com o plugin
filetype plugin indent on " required
syntax on                 " required
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
set foldlevel=0  " close all folds
set foldlevel=99 " Open all folds


augroup remember
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

"Float terminal configs
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F6>'
let g:floaterm_width = 0.9
let g:floaterm_height = 1.0
let g:bufferline_show_bufnr = 0

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

nnoremap <silent> <leader>m :delmark!<CR>

" nnoremap <silent> <C-z> :lua require("harpoon.ui").toggle_quick_menu()<Enter>
" nnoremap <silent> <C-a> :lua require("harpoon.mark").add_file()<Enter>

noremap <Tab> >>
noremap <S-Tab> << 
noremap <C-w> <C-w>w

noremap <C-l> :bnext<CR>
noremap <C-h> :bprev<CR>
nnoremap <leader><Tab> <C-6> 

let g:auto_save = 0  " enable AutoSave on Vim startup
" let g:lsc_auto_map = v:true
"nnoremap <esc> :noh<return><esc>
" if has('termguicolors')
" 	set termguicolors
" endif
let g:gruvbox_bold = 0 
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox
" colorscheme codedark  
let g:airline_theme = 'gruvbox'
"set clipboard=unnamedplus

"Open explorer, is like nerdtree but betther
nmap <space>e <Cmd>CocCommand explorer<CR>

" refresh do coc explorer sempre que é gravado um ficheiro para atualizar os
" erros nos outros ficheiros
autocmd BufWritePost * call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])
" autocmd User CocDiagnosticChange,CocGitStatusChange
"     \ call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])

" Refresh nerdtree whenever is open
nnoremap <C-n> :call NERDTreeToggleAndRefresh()<CR>
function NERDTreeToggleAndRefresh()
:NERDTreeToggle
if g:NERDTree.IsOpen()
:NERDTreeRefreshRoot
endif
endfunction

" Configuracao para aparecer a linha em insert mode e o bloco em normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
set ttimeout
set ttimeoutlen=1
set ttyfast


set encoding=utf-8

nnoremap <leader>t :below new output:///flutter-dev <CR>
let g:dart_format_on_save = 1

"telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" A partir daqui agradecam ao COC porque é tudo copiado de lá, da configuração
" padrao 


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
						  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
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

let g:coc_global_extensions = [
			\'coc-json', 
			\'coc-clangd', 
			\'coc-explorer', 
			\'coc-json', 
			\'coc-pyright',
			\'coc-pairs',
			\'coc-vimlsp',
			\'coc-flutter'
			\]

let g:coc_user_config ={
	\'diagnostic.virtualText': v:true,
	\'diagnostic.virtualTextCurrentLineOnly': v:false,
	\'coc.preferences.colorSupport': v:true,
	\'semanticTokens.enable': v:true,
	\'coc.preferences.semanticTokensHighlights':v:true,
	\'explorer.git.enable':v:true, 
	\'explorer.buffer.root.template': '[icon & 1] OPEN EDITORS',
	\'explorer.file.root.template': '[icon & 1] PROJECT ([root])',
	\'explorer.file.child.template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5]',
	\'explorer.file.showHiddenFiles': v:true,
	\'explorer.file.reveal.auto': v:false,
	\'explorer.icon.enableNerdfont': v:true,
	\'explorer.previewAction.onHover': v:false,
	\'explorer.position': 'left',
	\'coc.preferences.extensionUpdateCheck': 'daily',
	\'flutter.provider.enableSnippet' : v:true,
	\'flutter.enabled' : v:true,
	\}
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
	" \'python.pythonPath':'/home/leonardo/Desktop/path.sh'
