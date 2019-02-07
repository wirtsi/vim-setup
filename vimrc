  call plug#begin('~/.config/nvim/plugged')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh'
  \ }
  Plug 'roxma/nvim-completion-manager'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mxw/vim-jsx'
  Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install; and composer run-script parse-stubs'}
  Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
  Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  " Plug 'derekwyatt/vim-scala'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'w0rp/ale'
  Plug 'rizzatti/dash.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'machakann/vim-swap'
  Plug 'tpope/vim-commentary'
  Plug 'luochen1990/rainbow'
  Plug 'godlygeek/tabular'
  Plug 'airblade/vim-gitgutter'
  Plug 'matze/vim-move'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'simnalamburt/vim-mundo'
  Plug 'tpope/vim-dispatch'
  if has('nvim')
    " Adds neovim support to vim-dispatch
    Plug 'radenling/vim-dispatch-neovim'
  endif
  Plug 'Shougo/echodoc.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'chriskempson/base16-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'pangloss/vim-javascript'
  Plug 'airblade/vim-rooter'
  " Plug 'SirVer/ultisnips'
call plug#end()

set encoding=utf-8
scriptencoding utf-8
set noshowmode
set scrolloff=15
set ruler
set cursorline

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/Users/fkrause/.pyenv/shims/python'

"fix yaml indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"fzf integration
set rtp+=/usr/local/opt/fzf

colorscheme base16-tomorrow-night

"Here goes some neovim specific settings like
if has("nvim")
  set termguicolors
endif

"Terminal Mode mapping. We dont want buffers insiide terminal windows
if exists(':tnoremap')
    autocmd TermOpen,BufEnter,BufLeave term://* setlocal nonumber norelativenumber statusline=%{b:term_title}
    autocmd TermOpen term://* startinsert
    autocmd BufLeave term://* stopinsert
    autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
    tnoremap <Esc> <C-\><C-n>
    "fix standard windows commands in terminal mode
    tmap <silent> <C-w><left> <C-\><C-n><C-w><left>
    tmap <silent> <C-w><right> <C-\><C-n><C-w><right>
    tmap <silent> <C-w><up> <C-\><C-n><C-w><up>
    tmap <silent> <C-w><down> <C-\><C-n><C-w><down>
    tmap <silent> <C-w>q <C-\><C-n><C-w>q
endif

"clipboard sharing with osx
set clipboard=unnamed

set number
set relativenumber
syntax on
let mapleader=" "
"reload with Leader rl
map <leader>rl :source ~/.config/nvim/vimrc<CR>
set hidden
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set noswapfile
set dir=~/.config/nvim/swap
set backupdir=~/.config/nvim/backup
set undodir=~/.config/nvim/undo
set lazyredraw
set nu
set autowrite
set smartcase
set smartindent
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>
set showmatch
set smarttab      " insert tabs on the start of a line according to
                       "shiftwidth, not tabstop
set incsearch     " show search matches as you type
"show end of line
set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
set showmatch
set matchtime=3
autocmd BufWritePre * :%s/\s\+$//e
set hlsearch
set autochdir
set splitbelow
set splitright
set mouse=a

"disable highlighting with esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

"don't show tilde for empty lines
hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black

"vim-move -> https://github.com/matze/vim-move
let g:move_key_modifier = 'C'

"airline -> https://github.com/vim-airline/vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 2
" let g:airline#extensions#tabline#excludes = ["term://*"]
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='base16_tomorrow'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader><left> <Plug>AirlineSelectPrevTab
nmap <leader><right> <Plug>AirlineSelectNextTab

"needs some massaging so vim doesnt focus a terminal after closing the buffer
nmap <leader>bq :bp <bar>bd! #<cr>

"previous buffer with tab
nmap <tab> :bp<cr>
nmap <s-tab> :bn<cr>

"nerdtree -> https://github.com/scrooloose/nerdtree
map <Leader>n :NERDTreeToggle<cr>
"show current file in nerdtree
nmap <leader>l :NERDTreeFind<CR>

let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=0
let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp','/target', 'node_modules', 'coverage', 'build']
let g:NERDTreeQuitOnOpen = 1
"disable some stuff in nerdtree window
autocmd FileType nerdtree noremap <buffer> <leader>b <nop>
autocmd FileType nerdtree noremap <buffer> <leader>t <nop>
autocmd FileType nerdtree noremap <buffer> <leader>r <nop>

"cycle through menu items with tab/shift+tab
inoremap <expr> <s-TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <TAB> pumvisible() ? "\<c-p>" : "\<TAB>"

"fugitive -> https://github.com/tpope/vim-fugitive

"gitgutter -> https://github.com/airblade/vim-gitgutter
"let g:gitgutter_sign_column_always=1
set fillchars+=vert:│

"multi-cursor -> https://github.com/terryma/vim-multiple-cursors/
"Ctrl-N

"fzf.vim -> https://github.com/junegunn/fzf.vim
"find project root
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <leader>f :ProjectFiles<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :History<cr>
nnoremap <leader>t :Tags<cr>

"Open the ripgrep in fzf-vim
map <leader>s :Rg!<space>
let g:fzf_buffers_jump = 1
" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,'--color-path 400 --color-line-number 400',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:fzf_statusline()
  " Override statusline as you like
  " highlight fzf1 ctermfg=161 ctermbg=251
  " highlight fzf2 ctermfg=23 ctermbg=251
  " highlight fzf3 ctermfg=237 ctermbg=251
  " setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

"rainbox_parenthesis -> https://github.com/luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}

"dash -> https://github.com/rizzatti/dash.vim
nmap <silent> <leader>i <Plug>DashSearch
let g:dash_map = {
\   'python' : 'tensorflow'
\}


"Auto align = or :
nmap <Leader>= :Tabularize /=<CR>
vmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /:<CR>
vmap <Leader>: :Tabularize /:<CR>

"ale -> https://github.com/w0rp/ale
" Write this in your vimrc file
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_php_phpcs_standard = 'PSR2'

"https://github.com/autozimu/LanguageClient-neovim
"yarn global add javascript-typescript-langserver
"https://fortes.com/2017/language-server-neovim/
let g:LanguageClient_serverCommands = {
\ 'python' : ['/usr/local/bin/pyls'],
\ 'javascript' : ['/usr/local/bin/javascript-typescript-stdio'],
\ 'javascript.jsx' : ['/usr/local/bin/javascript-typescript-stdio'],
\ 'typescript' : ['/usr/local/bin/javascript-typescript-stdio'],
\ 'typescriptreact' : ['/usr/local/bin/javascript-typescript-stdio']
\}

" Minimal LSP configuration for JavaScript
if executable('javascript-typescript-stdio')
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
  autocmd FileType javascript.jsx setlocal omnifunc=LanguageClient#complete
  autocmd FileType typescript setlocal omnifunc=LanguageClient#complete
  autocmd FileType typescriptreact setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
  :cq
endif

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> rn :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> ff :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> go :call LanguageClient_textDocument_documentSymbol()<CR>
let g:LanguageClient_diagnosticsEnable  = 0

"https://github.com/editorconfig/editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"https://github.com/easymotion/vim-easymotion
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"https://github.com/simnalamburt/vim-mundo/
nnoremap <leader>u :MundoToggle<CR>

"https://github.com/machakann/vim-swap
"gs, g<, g>

"https://github.com/tpope/vim-surround
"cs<old><new>" or ds<char>

"jsx highlighting
let g:jsx_ext_required = 0

"quickfix window
nmap <leader>e  :cw<CR>
nmap ge :cn<CR>

" Generate ctags on save
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/post-update" ]; and .git/hooks/post-update' &
set tags+=.git/tags

"https://github.com/arnaud-lb/vim-php-namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

autocmd FileType php inoremap <Leader>iu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>iu :call PhpInsertUse()<CR>
autocmd FileType php inoremap <Leader>ic <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>ic :call PhpExpandClass()<CR>

" Vim rooter, shut up
let g:rooter_silent_chdir = 1
