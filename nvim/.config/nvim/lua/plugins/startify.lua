-- startify setup
vim.api.nvim_set_var('startify_files_number', 7)
vim.api.nvim_set_var('startify_bookmarks', { {c = '~/.config/nvim/lua/extra.lua'} })
vim.api.nvim_set_var('startify_commands', {
        {n = {'Open NERDTree', 'NERDTreeToggle'}},
        {h = {'Help Startify', 'h startify'}}
    })
