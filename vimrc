call plug#begin('~/.vim/plugged')
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'https://github.com/itchyny/lightline.vim'
  Plug 'rizzatti/dash.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-rhubarb'
  Plug 'machakann/vim-swap'
  Plug 'scrooloose/nerdcommenter'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'luochen1990/rainbow'
  Plug 'godlygeek/tabular'
  Plug 'ap/vim-buftabline'
  Plug 'airblade/vim-gitgutter'
  Plug 'matze/vim-move'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'sheerun/vim-polyglot'
  Plug 'jeetsukumaran/vim-buffergator'
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
    "use cmd+alt+<cursor> to move between windows, only in vimr
    map <D-A-RIGHT> <C-w>l
    map <D-A-LEFT> <C-w>h
    map <D-A-DOWN> <C-w><C-w>
    map <D-A-UP> <C-w>W

    "Alt-right|left in vimr for buffer switches
    map <A-Right> :bnext<cr>
    map <A-Left> :bprevious<cr>
endif

"Terminal Mode mapping
if exists(':tnoremap')
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen,BufEnter,BufLeave setlocal statusline=%{b:term_title}
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
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

hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black


"https://github.com/spolu/dwm.vim
let g:dwm_map_keys = 0
let g:dwm_master_pane_width=80
set mouse=a

"move counter- and clockwise through windows
nmap <silent> <F2> <C-W>W
nmap <silent> <F3> <C-W>w
tmap <silent> <F3> <C-\><C-n><C-W>w
tmap <silent> <F2> <C-\><C-n><C-W>W
tmap <silent> <C-w><left> <C-\><C-n><C-w><left>
tmap <silent> <C-w><right> <C-\><C-n><C-w><right>
tmap <silent> <C-w><up> <C-\><C-n><C-w><up>
tmap <silent> <C-w><down> <C-\><C-n><C-w><down>

"zoom current window
nmap <silent> <F4> :call DWM_AutoEnter()<CR>
tmap <silent> <F4> <C-\><C-n>:call DWM_Focus()<CR>

"shrink and grow master
nmap <silent> <F5> :call DWM_ShrinkMaster()<CR>
tmap <silent> <F5> <C-\><C-n>:call DWM_ShrinkMaster()<CR>

nmap <silent> <F6> :call DWM_GrowMaster()<CR>
tmap <silent> <F6> <C-\><C-n>:call DWM_GrowMaster()<CR>

nmap <silent> <F7> :exec DWM_Close()<CR>
tmap <silent> <F7> <C-\><C-n>:exec DWM_Close()<CR>

nmap <silent> <F8> :call DWM_New()<CR>:terminal<CR>
tmap <silent> <F8> <C-\><C-n>:call DWM_New()<CR>:terminal<CR>

nmap <silent> <F9> :call DWM_New()<CR>
tmap <silent> <F9> <C-\><C-n>:call DWM_New()<CR>


"vim-move -> https://github.com/matze/vim-move
let g:move_key_modifier = 'C'



"lightline -> https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filetype', 'filename' ] ],
      \   'right': [ ['linter'] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'DevIconFileFormat',
      \   'filetype': 'DevIconFileType',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'linter' : 'LightlineLinterStatus'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! DevIconFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! DevIconFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? fnamemodify(expand("%"), ":~:.") : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? "\ue0a0".branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineLinterStatus()
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


"nerdtree -> https://github.com/scrooloose/nerdtree
map <Leader>n :NERDTreeToggle<CR>
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=0
let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1
"show current file in nerdtree
nmap <leader>j :NERDTreeFind<CR>
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp','/target']
"disable some stuff in nerdtree window
autocmd FileType nerdtree noremap <buffer> <C-Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <C-S-Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <leader>b <nop>
autocmd FileType nerdtree noremap <buffer> <leader>t <nop>
autocmd FileType nerdtree noremap <buffer> <leader>r <nop>
autocmd FileType nerdtree noremap <buffer> <leader><Left> <nop>
autocmd FileType nerdtree noremap <buffer> <leader><Right> <nop>

"deoplete -> https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
let b:deoplete_ignore_sources = ['buffer', 'neco-syntax']

"fugitive -> https://github.com/tpope/vim-fugitive

"gitgutter -> https://github.com/airblade/vim-gitgutter
"let g:gitgutter_sign_column_always=1
set fillchars+=vert:│

"multi-cursor -> https://github.com/terryma/vim-multiple-cursors/

"http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
"buffergator -> https://github.com/jeetsukumaran/vim-buffergator
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" toggle between last buffers
"nnoremap <Leader><Leader> :e#<CR>
" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bg :BuffergatorOpen<cr>

" Copy shortcuts from window to buffer
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

"buftabline -> https://github.com/ap/vim-buftabline
" this renders the buffers on the tabline
" remap arrow keys
map <leader><Left> :bprev<CR>
map <leader><Right> :bnext<CR>


nmap <D-1> <Plug>BufTabLine.Go(1)
nmap <D-2> <Plug>BufTabLine.Go(2)
nmap <D-3> <Plug>BufTabLine.Go(3)
nmap <D-4> <Plug>BufTabLine.Go(4)
nmap <D-5> <Plug>BufTabLine.Go(5)
nmap <D-6> <Plug>BufTabLine.Go(6)
nmap <D-7> <Plug>BufTabLine.Go(7)
nmap <D-8> <Plug>BufTabLine.Go(8)
nmap <D-9> <Plug>BufTabLine.Go(9)
nmap <D-0> <Plug>BufTabLine.Go(10)

"fzf.vim -> https://github.com/junegunn/fzf.vim
nnoremap <leader>t :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :History<cr>
autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
"Open the silver search in fzf-vim
map <leader>g :Ag!<space>
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
  \ call fzf#vim#ag(<q-args>,
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
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:<CR>
vmap <Leader>t: :Tabularize /:<CR>

"vim-dispatch -> https://github.com/tpope/vim-dispatch
"vim-dispatch doesn't like fish
"set shell=/bin/bash

"ale -> https://github.com/w0rp/ale
" Write this in your vimrc file
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

"https://github.com/autozimu/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
\ 'python' : ['/usr/local/bin/pyls']
\}
let g:LanguageClient_autoStart = 0
"autocmd FileType php LanguageClientStart
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
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

