-- Telescope configs
pcall(require('telescope').load_extension, 'fzf')
require('telescope').setup{
    defaults = {
        layout_strategy = "vertical",
        wrap_results = true,
    }
}
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>T", "<cmd>lua require('telescope.builtin').tags()<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<CR>")
