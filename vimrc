" set this for plugins here
let mapleader=" "

call plug#begin('~/.config/nvim/plugged')

  " v0.5 https://crispgm.com/page/neovim-is-overpowering.html
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'ahmedkhalf/lsp-rooter.nvim'


  " telescope dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'

  " Error handling
  Plug 'folke/trouble.nvim'

  " Tree Folder View
  Plug 'kyazdani42/nvim-tree.lua'


  " prettier
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

  " UX
  Plug 'rizzatti/dash.vim'
  Plug 'shaunsingh/nord.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'kdheepak/lazygit.nvim'

  Plug 'tpope/vim-dispatch'
  if has('nvim')
    " Adds neovim support to vim-dispatch
    Plug 'radenling/vim-dispatch-neovim'
  endif
  Plug 'prasantapal/rainbow_csv'

  " buffer & statusline
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'hoob3rt/lualine.nvim'

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
let g:compe.documentation = v:true
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
  buf_set_keymap('n', 'gE', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "yamlls", "pyright", "tsserver", "phpactor"}
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

lua << EOF
  require("trouble").setup {
  }
EOF


" eslint
lua << EOF
  local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true
  }

  local util = require "lspconfig".util

  require "lspconfig".efm.setup {
    --cmd = {"efm-langserver",},
    init_options = {documentFormatting = false},
    filetypes = {"javascript", "typescript", "typescriptreact"},
    root_dir = function(fname)
      return util.root_pattern("tsconfig.json")(fname) or
      util.root_pattern(".eslintrc.js", ".git")(fname);
    end,
    settings = {
      rootMarkers = {".eslintrc.js", ".git/"},
      languages = {
        typescript = {eslint}
      }
    }
  }
EOF


lua << EOF
  require("lsp-rooter").setup {}
EOF

lua << EOF
  require("bufferline").setup{
    options = {
        show_buffer_icons = true,
        diagnostics = "nvim_lsp",
        mappings = true,
        numbers = "ordinal"
    }
  }
EOF
lua << EOF
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
local colors = {
  bg = '#374353',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#8FBCBB',
  orange = '#D08770',
  violet = '#A3BE8C',
  magenta = '#B48EAD',
  blue = '#51afef',
  red = '#ec5f67'
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = "nord"
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {'filetype', colored = true}


ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red
    }
    vim.api.nvim_command(
        'hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" ..
            colors.bg)
    return ''
  end,
  color = "LualineMode",
  left_padding = 0
}

ins_left {
  -- filesize component
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then return '' end
      local sufixes = {'b', 'k', 'm', 'g'}
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format('%.1f%s', size, sufixes[i])
    end
    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then return '' end
    return format_file_size(file)
  end,
  condition = conditions.buffer_not_empty
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  color = {fg = colors.magenta, gui = 'bold'}
}

ins_left {'location'}

ins_left {'progress', color = {fg = colors.fg, gui = 'bold'}}

ins_left {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = {error = ' ', warn = ' ', info = ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {function() return '%=' end}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = {fg = '#ffffff', gui = 'bold'}
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's upper case either ;)
  condition = conditions.hide_in_width,
  color = {fg = colors.green, gui = 'bold'}
}

ins_right {
  'fileformat',
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = {fg = colors.green, gui = 'bold'}
}

ins_right {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = {fg = colors.violet, gui = 'bold'}
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = {added = ' ', modified = '柳 ', removed = ' '},
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

-- Now don't forget to initialize lualine
lualine.setup(config)
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

" autoformat with prettier
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Close location after selection
autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>

set termguicolors

colorscheme nord

"clipboard sharing with osx
set clipboard=unnamed

set number
set relativenumber
syntax on
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
nnoremap <silent><leader><left> :BufferLineCyclePrev<CR>
nnoremap <silent><leader><right> :BufferLineCycleNext<CR>

" Close a buffer
nmap <leader>bq :bp <bar>bd! #<cr>


" nvim-tree
let g:nvim_tree_ignore = [ '.git', '.cache' ] "empty by default
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_width = 40
let g:nvim_tree_auto_close = 1
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_update_cwd = 0
map <Leader>n :NvimTreeToggle<cr>
nmap <leader>l :NvimTreeFindFile<CR>


"https://github.com/nvim-telescope/telescope.nvim#pickers
nnoremap <leader>F <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope git_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>r <cmd>Telescope oldfiles<cr>
nnoremap <leader>t <cmd>Telescope help_tags<cr>

"Open the ripgrep in telescope
map <leader>s <cmd>Telescope live_grep<cr>
map <leader>S <cmd>Telescope grep_string<cr>

"cycle through menu items with tab/shift+tab
inoremap <expr> <s-TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <TAB> pumvisible() ? "\<c-p>" : "\<TAB>"
inoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<down>"
inoremap <expr> <up> pumvisible() ? "\<c-p>" : "\<up>"
cnoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<down>"
cnoremap <expr> <up> pumvisible() ? "\<c-p>" : "\<up>"

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

" Show trouble error list
map <leader>e <cmd>TroubleToggle<cr>

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

" At the end, some plugin overwrites these
hi LspDiagnosticsDefaultError guifg=#E32636
hi LspDiagnosticsDefaultWarning guifg=#FFBF00
