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



" language servers setup for neovim nvim-lspconfig
lua << EOF

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require 'cmp'
cmp.setup {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
          -- elseif luasnip.expand_or_jumpable() then
            -- luasnip.expand_or_jump()
          elseif has_words_before() then
              cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          -- elseif luasnip.jumpable(-1) then
        -- luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }
        } , {
            { name = 'buffer' },
        }
    )
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.intelephense.setup {
  capabilities = capabilities,
}

require'lspconfig'.gopls.setup{}

require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
}
require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "php" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap grn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
" go to next error
nnoremap <leader>gn :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>vll :call LspLocationList()<CR>
