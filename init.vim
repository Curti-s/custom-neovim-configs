call plug#begin()
" Make  sure you use single quotes

  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'https://github.com/tomasr/molokai.git'
  Plug 'sheerun/vim-polyglot'

" Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" Always load the vim-devicons as the very last one.
  Plug 'ryanoasis/vim-devicons'
" initialize plugin system
call plug#end()

" Lines of history to remember
set history=1000 

" Editing
set splitright
set splitbelow

" text width 
set textwidth=180

" Enable syntax processing
syntax enable

" Set colorscheme
colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1

" Use spaces instead of tabs
" tabs are spaces
set expandtab

" number of visual spaces per TAB   
set tabstop=2

" column of whitespace a level of indentation is worth
set shiftwidth=2

" number of whitespaces is a tab when editing
set softtabstop=2

" UI config
" show line numbers
set number 
" show comand at the bottom bar
set showcmd 
" highlight current line
set cursorline 
hi CursorLine term=bold cterm=bold guibg=Grey40
" background line color
set background=dark
" load filetype-specific indent files
filetype indent on 
" Use indent from current line for next line
set autoindent 
" Detect when file changes outside of vim
set autoread 
" Be clever when code cues are recognized
set smartindent 
" wrap lines
set wrap 
" visual autocomplete for command menu
set wildmenu 
" redraw only when we need to
set lazyredraw 
" highlight matching [] {} ()
set showmatch


" Searching
" search as character are being entered
set incsearch " highlight search matches
set hlsearch

" Set leader 
let mapleader="-"

" Folding
" enable folding
set foldenable 
" open most folds by default
set foldlevelstart=10  
" 10 nested fold mac
set foldnestmax=10 
" open/close folds
nnoremap <space> za 
" fold based on indent level
set foldmethod=indent 

" Spell check and line wrap for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" uses zsh instead of bash
function! OpenTerminal()
  split term://zsh
  resize 12
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>


" NERDTree config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" airline powerline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" devicons config
" loading the plugin
let g:webdevicons_enable = 1
" change the default open folder/directory glyph/icon (default is '')
let g:DevIconsDefaultFolderOpenSymbol = 'ƛ'
" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 1


" coc config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ==========================================================


" set python3_host_prog
let g:python3_host_prog = '/home/kirimi/anaconda3/bin/python3'
" FZF config
nnoremap <c-p> :FZF<cr>
let $FZF_DEFAULT_OPTS='--reverse'
