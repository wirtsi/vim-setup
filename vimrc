call plug#begin('~/.config/nvim/plugged')

  " v0.5 https://crispgm.com/page/neovim-is-overpowering.html
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'


  " dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'

  " UX
  Plug 'rizzatti/dash.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }

  Plug 'tpope/vim-dispatch'
  if has('nvim')
    " Adds neovim support to vim-dispatch
    Plug 'radenling/vim-dispatch-neovim'
  endif
  Plug 'prasantapal/rainbow_csv'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-rooter'

  " Langs
  Plug 'editorconfig/editorconfig-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'nvie/vim-flake8'
  Plug 'hashivim/vim-terraform'
  Plug 'jparise/vim-graphql'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jonsmithers/vim-html-template-literals'
  Plug 'leafgarland/typescript-vim'
  Plug 'stephpy/vim-yaml'

  " Utils
  Plug 'machakann/vim-swap'
  Plug 'tpope/vim-commentary'
  Plug 'frazrepo/vim-rainbow'

  Plug 'godlygeek/tabular'
  Plug 'airblade/vim-gitgutter'
  Plug 'matze/vim-move'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'simnalamburt/vim-mundo'
  Plug 'Shougo/echodoc.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'
call plug#end()

" https://github.com/hrsh7th/nvim-compe
" autocomplete setup
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.source = {
\ 'path': v:true,
\ 'buffer': v:true,
\ 'nvim_lsp': v:true,
\ }

" https://github.com/neovim/nvim-lspconfig
"lsp setup
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "yamlls", "tsserver", "pyls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF


lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    set_env = { ['COLORTERM'] = 'truecolor' },
    color_devicons = true,
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

set encoding=utf-8
scriptencoding utf-8
set noshowmode
set scrolloff=15
set ruler
set cursorline
set colorcolumn=80
set signcolumn=yes
set completeopt=menuone,noselect

"fix yaml indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tf setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"fzf integration
" set rtp+=/usr/local/opt/fzf

"Here goes some neovim specific settings like
if has("nvim")
  set termguicolors
endif

colorscheme nord


"Terminal Mode mapping. We dont want buffers insiide terminal windows
"if exists(':tnoremap')
"    autocmd TermOpen,BufEnter,BufLeave term://* setlocal nonumber norelativenumber statusline=%{b:term_title}
"    autocmd TermOpen term://* startinsert
"    autocmd BufLeave term://* stopinsert
"    autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
"    " tnoremap <Esc> <C-\><C-n>
"    "fix standard windows commands in terminal mode
"    tmap <silent> <C-w><left> <C-\><C-n><C-w><left>
"    tmap <silent> <C-w><right> <C-\><C-n><C-w><right>
"    tmap <silent> <C-w><up> <C-\><C-n><C-w><up>
"    tmap <silent> <C-w><down> <C-\><C-n><C-w><down>
"    tmap <silent> <C-w>q <C-\><C-n><C-w>q
"endif

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
" toggle wrap
map <leader>w :set nowrap!<CR>
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

highlight link CompeDocumentation NormalFloat

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
let g:airline_theme='nord'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'


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

" Close a buffer
nmap <leader>bq :bp <bar>bd! #<cr>

"https://github.com/nvim-telescope/telescope.nvim#pickers
map <Leader>n <cmd>Telescope file_browser<cr>
"show current file in nerdtree -- cannot be done in telescope
" nmap <leader>l :NERDTreeFind<CR>
nnoremap <leader>F <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope grep_string<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>r <cmd>Telescope oldfiles<cr>
nnoremap <leader>t <cmd>Telescope help_tags<cr>

"Open the ripgrep in telescope
map <leader>s <cmd>Telescope live_grep<cr>

"cycle through menu items with tab/shift+tab
inoremap <expr> <s-TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <TAB> pumvisible() ? "\<c-p>" : "\<TAB>"

"fugitive -> https://github.com/tpope/vim-fugitive

"gitgutter -> https://github.com/airblade/vim-gitgutter
"let g:gitgutter_sign_column_always=1
set fillchars+=vert:│

"multi-cursor -> https://github.com/terryma/vim-multiple-cursors/
"Ctrl-N
let g:multi_cursor_exit_from_insert_mode = 0


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

"quickfix window
" nmap <leader>e  :cw<CR>
" nmap ge :cn<CR>

" Generate ctags on save
" au BufWritePost *.php silent! !eval '[ -f ".git/hooks/post-update" ]; and .git/hooks/post-update' &
set tags+=.git/tags


" Vim rooter, shut up
let g:rooter_silent_chdir = 1

" terraform stuff
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" lazygit
nnoremap <silent> <leader>lg :LazyGit<CR>
 if has('nvim') && executable('nvr')
  " pip3 install neovim-remote
  let $GIT_EDITOR = "nvr --remote-wait +'set bufhidden=wipe'"
endif
