filetype plugin indent on
syntax on
set noswapfile     " no swap files
set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noshowmatch    " no matching chars

set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab
set expandtab               " on tab press insert spaces
set list                    " Display spaces and tabs and oddities (like non-breaking white-space)
set showcmd                 " Show (partial) command available in status line
set hidden                  " Hide buffers when they are abandoned

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" use true colors palette on 24 bits (16 million colors)
set termguicolors

set number
set relativenumber

set cursorline
" gutter limit
set colorcolumn=121

" remove highlighted text when enter is pressed
nnoremap <silent> <CR> :nohlsearch<cr><esc>

call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-syntastic/syntastic'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/vim-easy-align'
    Plug 'mhinz/vim-startify'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    " colors packs, find more on http://vimcolors.com/
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-solarized8'
    Plug 'andbar-ru/vim-unicon'
    Plug 'mhartington/oceanic-next'
    Plug 'trusktr/seti.vim'
    Plug 'drewtempelmeyer/palenight.vim'

    "fonts
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'bryanmylee/vim-colorscheme-icons'

call plug#end()

let mapleader=","

" Colorschemes
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" statusline
let g:currentmode={
            \ 'n'  : 'NORMAL ',
            \ 'no' : 'N·Operator Pending ',
            \ 'v'  : 'V ',
            \ 'V'  : 'V·Line ',
            \ 'x22' : 'V·Block ',
            \ 's'  : 'Select ',
            \ 'S'  : 'S·Line ',
            \ 'x19' : 'S·Block ',
            \ 'i'  : 'INSERT ',
            \ 'R'  : 'R ',
            \ 'Rv' : 'V·Replace ',
            \ 'c'  : 'Command ',
            \ 'cv' : 'Vim Ex ',
            \ 'ce' : 'Ex ',
            \ 'r'  : 'Prompt ',
            \ 'rm' : 'More ',
            \ 'r?' : 'Confirm ',
            \ '!'  : 'Shell ',
            \ 't'  : 'Terminal '
            \}

set laststatus=2
set statusline=
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%8*\ BufferNr:\ [%n]                          " buffernr
set statusline+=\ %f
set statusline+=%#warningmsg#
set statusline+=\ %=%y
set statusline+=%#StatusLine#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} "fileencoding e.g utf-8
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ %L
" mode information is displayed in the statusline we dont need it anymore
set noshowmode

" Let <Tab> also do completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" telescope setup
nnoremap <leader>f :Telescope find_files<cr>
nnoremap <leader>g :Telescope find_files<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').tags()<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').current_buffer_tags()<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>r :Telescope live_grep<cr>
" end telescope setup

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader><leader> :buffer #<cr>

let g:php_cs_fixer_rules = "@PSR12"
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
autocmd FileType php set iskeyword+=$

" Syntastic configuration for PHP
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=psr12'
let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'

let g:startify_files_number = 7
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'} ]
let g:startify_commands = [
            \ {'n': ['Open NERDTree', 'NERDTreeToggle']},
            \ {'h': ['Help Startify', 'h startify']},
            \ ]



" language servers setup for neovim nvim-lspconfig
lua << EOF
require'lspconfig'.intelephense.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.intelephense.setup{on_attach=require'completion'.on_attach}
require('telescope').load_extension('fzf')
EOF

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap grn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vll :call LspLocationList()<CR>
