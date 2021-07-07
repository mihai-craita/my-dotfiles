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
    Plug 'hrsh7th/nvim-compe'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/vim-easy-align'
    Plug 'mhinz/vim-startify'

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

" let g:coc_global_extensions = ['coc-json', 'coc-tsserver']
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> grn <Plug>(coc-rename)

" Let <Tab> also do completion

" autocomplet compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" Shortcuts for using fzf in vim
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader><leader> :buffer #<cr>

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



" language servers setup for neovim nvim-lspconfig
lua << EOF
require'lspconfig'.phpactor.setup{}
require'lspconfig'.tsserver.setup{}
EOF

" this might be setup in lua, check hrsh7th/nvim-compe plugin details

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
