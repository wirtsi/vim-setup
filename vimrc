"http://marcgg.com/blog/2016/03/01/vimrc-example/
execute pathogen#infect()
set nocompatible
filetype on
filetype plugin on
syntax on
set encoding=utf-8
scriptencoding utf-8


"fzf integration
set rtp+=/usr/local/opt/fzf

colorscheme Tomorrow-Night-Eighties
"colorscheme Afterglow
"if !has("gui_vimr")
  ""Here goes some VimR specific settings like
  "set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline:h16
"endif


set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

set number
let mapleader=" "
"reload with Leader s
map <leader>s :source ~/.vimrc<CR>
set hidden
set history=100
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set nosmartindent
set autoindent
set copyindent    " copy the previous indentation on autoindenting
set autowrite
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>
set showmatch
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set incsearch     " show search matches as you type
"show end of line
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
set showmatch
set matchtime=3
autocmd BufWritePre * :%s/\s\+$//e
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

"fix terminal cursor keys? <- http://apple.stackexchange.com/questions/3369/why-dont-my-arrow-keys-work-in-vim-under-iterm
nnoremap <silent> <ESC>^[A <Nop>
nnoremap <silent> <ESC>^[B <Nop>
nnoremap <silent> <ESC>^[D <Nop>
nnoremap <silent> <ESC>^[C <Nop>

map <D-A-RIGHT> <C-w>l
map <D-A-LEFT> <C-w>h
map <D-A-DOWN> <C-w><C-w>
map <D-A-UP> <C-w>W

"vim-move -> https://github.com/matze/vim-move
let g:move_key_modifier = 'C'


"Open vimgrep and put the cursor in the right position:
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

"When you search with vimgrep, display your results in cope by doing: <leader>gc
"To go to the next search result do: <leader>n
"To go to the previous search results do: <leader>p
"Vimscript mappings:
map <leader>gc :botright cope<cr>
map <leader>gn :cn<cr>
map <leader>gp :cp<cr>

"lightline -> https://github.com/itchyny/lightline.vim
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }


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
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
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

"nerdtree -> https://github.com/scrooloose/nerdtree
map <Leader>n :NERDTreeToggle<CR>
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
"show current file in nerdtree
nmap <leader>j :NERDTreeFind<CR>
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp','/target']
"disable some stuff in nerdtree window
autocmd FileType nerdtree noremap <buffer> <C-Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <C-S-Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <leader>b <nop>
autocmd FileType nerdtree noremap <buffer> <leader>t <nop>
autocmd FileType nerdtree noremap <buffer> <leader>r <nop>
"supertap -> https://github.com/ervandew/supertab

"fugitive -> https://github.com/tpope/vim-fugitive

"gitgutter -> https://github.com/airblade/vim-gitgutter
let g:gitgutter_sign_column_always=1

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
nnoremap <Leader><Leader> :e#<CR>
" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bg :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

"buftabline -> https://github.com/ap/vim-buftabline
" this renders the buffers on the tabline
" remap arrow keys
map <leader><Left> :bprev<CR>
map <leader><Right> :bnext<CR>

"iterm doesn allow this
if has("gui_macvim")
  map <C-Tab> :bnext<cr>
  map <C-S-Tab> :bprevious<cr>
endif

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

"Command-T
"nnoremap <leader>r :CommandTMRU<CR>
"set wildignore+=*.log,*.sql,*.cache,target

"zfz.vim -> https://github.com/junegunn/fzf.vim
nnoremap <leader>t :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :History<cr>


"rainbox_parenthesis -> https://github.com/kien/rainbow_parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

"dash -> https://github.com/rizzatti/dash.vim
nmap <silent> <leader>d <Plug>DashSearch

"Auto align = or :
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>

"vim-dispatch -> https://github.com/tpope/vim-dispatch
"vim-dispatch doesn't like fish
set shell=/bin/bash
