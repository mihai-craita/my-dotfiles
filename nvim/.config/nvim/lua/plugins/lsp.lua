-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- go to next error
    vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next, opts)
    --  vim.keymap.set("n", "<leader>i", "<cmd>Telescope lsp_implementations<CR>", opts)
end

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

