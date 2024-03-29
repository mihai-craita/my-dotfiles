-- set up LSPs with :Mason
local success, lsp_zero = pcall(require, 'lsp-zero');
if success then
    local lsp = lsp_zero.preset({})

    lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {buffer = true})
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", {buffer = true})
    end)

    lsp.setup()
end
