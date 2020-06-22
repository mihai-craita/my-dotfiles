set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files
set noshowmatch    " no matching chars

set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab               " on tab press insert spaces
set list                    " Display spaces and tabs and oddities (like non-breaking white-space)
set showcmd                 " Show (partial) command available in status line
set hidden                  " Hide buffers when they are abandoned
filetype plugin on

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set number
set relativenumber

" gutter limit
set colorcolumn=121
" keep the cursor centered vertically
set scrolloff=999
set cursorline

" remove highlighted text when enter is pressed
nnoremap <silent> <CR> :nohlsearch<cr><esc>
" Try to load minpac.
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-vdebug/vdebug'

" colors packs, find more on http://vimcolors.com/
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'andbar-ru/vim-unicon'
Plug 'mhartington/oceanic-next'
Plug 'trusktr/seti.vim'
Plug 'drewtempelmeyer/palenight.vim'

"fonts
Plug 'ryanoasis/vim-devicons'

call plug#end()

let mapleader=","

" Colorschemes
colorscheme gruvbox
set background=dark
let mapleader = ","

"statusline
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
set statusline+=%8*\ Buffer[%n]                                " buffernr
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

nmap <silent> gd <Plug>(coc-definition)
" Let <Tab> also do completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Leaderf settings
" let g:Lf_IgnoreCurrentBufferName = 1
" :nnoremap <C-L> :Leaderf file<CR>

" Integrate fzf via Homebrew
set rtp+=/usr/local/opt/fzf
" Integrate fzf via install on servers
set rtp+=~/.fzf
" Shortcuts for using fzf in vim
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>t :Tags<cr>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let g:php_cs_fixer_rules = "@PSR1"
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

" Syntastic configuration for PHP
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=psr12'
let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'
