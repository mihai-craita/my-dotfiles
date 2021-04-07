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
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/vim-easy-align'
    Plug 'mhinz/vim-startify'
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

let g:coc_global_extensions = ['coc-phpls', 'coc-json', 'coc-tsserver']
nmap <silent> gd <Plug>(coc-definition)

" Let <Tab> also do completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Shortcuts for using fzf in vim
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

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
