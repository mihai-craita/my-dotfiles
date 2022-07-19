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
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/vim-easy-align'
    Plug 'mhinz/vim-startify'

    Plug 'rafamadriz/friendly-snippets'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

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

" Avoid showing message extra message when using completion
set shortmess+=c

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader><leader> :buffer #<cr>

let g:php_cs_fixer_rules = "@PSR12"
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
autocmd FileType php set iskeyword-=$

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


lua require("extra")

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
