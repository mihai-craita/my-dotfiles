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

--- leaader G similar with git grep
vim.keymap.set("n", "<leader>G", function()
  require('telescope.builtin').live_grep({
    theme = "ivy",
    glob_pattern = {
      "!**/.git/*",
      "!**/node_modules/*",
      "!**/vendor/*",
      "!**/storage/*",  -- Exclude Laravel storage directory
      "!**/cache/*",   -- Exclude cache directories
      "!**/build/*",   -- Exclude build directories
    },
    file_ignore_patterns = {
      "^.git/",
      "^node_modules/",
      "^vendor/",
      "^storage/",
      "^cache/",
      "^build/",
    },
    additional_args = { "--hidden", "--glob", "!**/.git/*", "--ignore-case" },
    search_dirs = { "app/", "src/" }, -- Optional: Limit search to specific directories
  })
end)
