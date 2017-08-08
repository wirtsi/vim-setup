call plug#begin('~/.vim/plugged')
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'rizzatti/dash.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-rhubarb'
  Plug 'machakann/vim-swap'
  Plug 'scrooloose/nerdcommenter'
  Plug 'luochen1990/rainbow'
  Plug 'godlygeek/tabular'
  Plug 'airblade/vim-gitgutter'
  Plug 'matze/vim-move'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'sheerun/vim-polyglot'
  Plug 'simnalamburt/vim-mundo'
  Plug 'w0rp/ale'
  Plug 'octref/RootIgnore'
  Plug 'tpope/vim-dispatch'
  if has('nvim')
    " Adds neovim support to vim-dispatch
    Plug 'radenling/vim-dispatch-neovim'
  endif
  Plug 'Shougo/echodoc.vim'
  Plug 'roxma/LanguageServer-php-neovim'
  Plug 'easymotion/vim-easymotion'
  Plug 'chriskempson/base16-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-surround'
  Plug 'spolu/dwm.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

set encoding=utf-8
scriptencoding utf-8
set noshowmode

"fzf integration
set rtp+=/usr/local/opt/fzf

colorscheme base16-tomorrow-night

"Here goes some neovim specific settings like
if has("nvim")
  set termguicolors
endif

if !has("gui_vimr")
    "vimr doesn't like this
    set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline\ Nerd\ Font\ Complete:h15
else
    "Alt-right|left in vimr for buffer switches
    nmap <A-Left>  <Plug>AirlineSelectPrevTab
    nmap <A-Right> <Plug>AirlineSelectNextTab
endif

"Terminal Mode mapping. We dont want buffers insiide terminal windows
if exists(':tnoremap')
    autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
    autocmd TermOpen,BufEnter,BufLeave setlocal statusline=%{b:term_title}
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
    autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
    "fix standard windows commands in terminal mode
    tmap <silent> <C-w><left> <C-\><C-n><C-w><left>
    tmap <silent> <C-w><right> <C-\><C-n><C-w><right>
    tmap <silent> <C-w><up> <C-\><C-n><C-w><up>
    tmap <silent> <C-w><down> <C-\><C-n><C-w><down>
    tmap <silent> <C-w>q <C-\><C-n><C-w>q
    "dwm mappings for f-keys
    tmap <silent> <F2> <C-\><C-n><C-w>W
    tmap <silent> <F3> <C-\><C-n><C-w>w
    tmap <silent> <F4> <C-\><C-n>:call DWM_Focus()<CR>
    tmap <silent> <F5> <C-\><C-n>:call DWM_ShrinkMaster()<CR>
    tmap <silent> <F6> <C-\><C-n>:call DWM_GrowMaster()<CR>
    tmap <silent> <F7> <C-\><C-n>:exec DWM_Close()<CR>
    tmap <silent> <F8> <C-\><C-n>:call DWM_New() <bar> terminal<CR>
    tmap <silent> <F9> <C-\><C-n>:call DWM_New()<CR>
endif

"clipboard sharing with osx
set clipboard=unnamed

set number
set relativenumber
syntax on
"don't let vim override the settings here
"filetype plugin indent off
let mapleader=" "
"reload with Leader rl
map <leader>rl :source ~/.vimrc<CR>
set hidden
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set noswapfile
set nowritebackup
set lazyredraw
set nu
set autowrite
set smartcase
"set nosmartindent
"set autoindent
"set copyindent    " copy the previous indentation on autoindenting
"set autowrite
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
"disable highlighting with esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

"don't show tilde for empty lines
hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black


"https://github.com/spolu/dwm.vim
let g:dwm_map_keys = 0
set mouse=a

"move counter- and clockwise through windows
nmap <silent> <F2> <C-w>W
nmap <silent> <F3> <C-w>w

"zoom current window
nmap <silent> <F4> :call DWM_Focus()<CR>

"shrink and grow master
nmap <silent> <F5> :call DWM_ShrinkMaster()<CR>
nmap <silent> <F6> :call DWM_GrowMaster()<CR>
nmap <silent> <F7> :exec DWM_Close()<CR>
nmap <silent> <F8> :call DWM_New() <bar> terminal<CR>
nmap <silent> <F9> :call DWM_New()<CR>


"vim-move -> https://github.com/matze/vim-move
let g:move_key_modifier = 'C'

"airline -> https://github.com/vim-airline/vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#excludes = ["term://*"]
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='base16_twilight'

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

"Allow creating new buffers with leader T and closing with leader bq
nmap <leader>T :enew<cr>
"needs some massaging so vim doesnt focus a terminal after closing the buffer
nmap <leader>bq :bp <bar>bd #<BAR>execute "normal \<Plug>AirlineSelectTab1"<cr>

"nerdtree -> https://github.com/scrooloose/nerdtree
map <Leader>n :NERDTreeToggle<CR>
"show current file in nerdtree
nmap <leader>l :NERDTreeFind<CR>
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=0
let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp','/target']
let g:NERDTreeQuitOnOpen = 1
"disable some stuff in nerdtree window
autocmd FileType nerdtree noremap <buffer> <leader>b <nop>
autocmd FileType nerdtree noremap <buffer> <leader>t <nop>
autocmd FileType nerdtree noremap <buffer> <leader>r <nop>

"deoplete -> https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
let b:deoplete_ignore_sources = ['buffer', 'neco-syntax']

"fugitive -> https://github.com/tpope/vim-fugitive

"gitgutter -> https://github.com/airblade/vim-gitgutter
"let g:gitgutter_sign_column_always=1
set fillchars+=vert:│

"multi-cursor -> https://github.com/terryma/vim-multiple-cursors/
"Ctrl-N

"fzf.vim -> https://github.com/junegunn/fzf.vim
nnoremap <leader>t :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :History<cr>

"Open the silver search in fzf-vim
map <leader>f :Ag!<space>
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
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = {
\   'python' : 'tensorflow'
\}


"Auto align = or :
nmap <Leader>= :Tabularize /=<CR>
vmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /:<CR>
vmap <Leader>: :Tabularize /:<CR>

"vim-dispatch -> https://github.com/tpope/vim-dispatch
"vim-dispatch doesn't like fish
"set shell=/bin/bash

"ale -> https://github.com/w0rp/ale
" Write this in your vimrc file
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

"https://github.com/autozimu/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
\ 'python' : ['/usr/local/bin/pyls'],
\ 'php' : ['php', '~/php/language-server/vendor/bin/php-language-server.php']
\}
let g:LanguageClient_autoStart = 0
autocmd FileType php LanguageClientStart
autocmd FileType python LanguageClientStart
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> rn :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> ff :call LanguageClient_textDocument_formatting()<CR>

"https://github.com/editorconfig/editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"https://github.com/easymotion/vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"Forward search
" `f{char}{label}`
nmap f <Plug>(easymotion-f)

"Backward search
" `b{char}{label}`
nmap b <Plug>(easymotion-b)

"Search one char
" `s{char}{label}`
nmap s <Plug>(easymotion-s)

"Search two chars
" `<Leader>s{char}{char}{label}`
nmap <Leader>s <Plug>(easymotion-s2)

"Search word forward
nmap w <Plug>(easymotion-w)

"Search word backward
nmap b <Plug>(easymotion-b)

" JK motions: Line motions. Keep defaults because easymotion doesn't support
" line jumps
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

"https://github.com/simnalamburt/vim-mundo/
nnoremap <leader>u :MundoToggle<CR>

"https://github.com/machakann/vim-swap
"gs, g<, g>

"https://github.com/tpope/vim-surround
"cs<old><new>" or ds<char>
