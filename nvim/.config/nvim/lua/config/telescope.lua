-- Telescope configs
require('telescope').setup{
    defaults = {
        layout_strategy = "horizontal",
        wrap_results = true,
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
require('telescope').load_extension('fzf')

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>T", "<cmd>lua require('telescope.builtin').tags()<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<CR>")

--- leader G for git grep with live updates (case insensitive)
vim.keymap.set("n", "<leader>G", function()
  require('telescope.builtin').live_grep({
    prompt_title = "Git Grep (case insensitive)",
    vimgrep_arguments = {
      "git",
      "grep",
      "--line-number",
      "--column",
      "--color=never",
      "-H",
      "-i",
      "-E"
    },
    cwd = vim.fn.getcwd(),
  })
end)

--- leader Gcs for case sensitive git grep
vim.keymap.set("n", "<leader>Gcs", function()
  require('telescope.builtin').live_grep({
    prompt_title = "Git Grep (case sensitive)",
    vimgrep_arguments = {
      "git",
      "grep",
      "--line-number",
      "--column",
      "--color=never",
      "-H",
      "-E"
    },
    cwd = vim.fn.getcwd(),
  })
end)
