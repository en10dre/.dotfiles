return {
    {
        'mbbill/undotree',
        config = function()
            -- Set up a keymap to toggle the undotree
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle,
                { noremap = true, silent = true, desc = 'Toggle Undotree' })
        end,
    },
}
