return {
    'tpope/vim-fugitive', -- Replace with the correct plugin if different
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Status' })
    end
}
