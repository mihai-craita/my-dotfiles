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
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    local opts = { buffer = 0, noremap = true, silent = true }

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- go to next error
    vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next, opts)
    --  vim.keymap.set("n", "<leader>i", "<cmd>Telescope lsp_implementations<CR>", opts)
end
-- The following example advertise capabilities to `clangd`.
require'lspconfig'.intelephense.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Telescope configs
require('telescope').load_extension('fzf')
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>t", "<cmd>lua require('telescope.builtin').tags()<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<CR>")
-- end telescope setup

--  Treesitter configs
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "php", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  indent = {
      enable = true
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
