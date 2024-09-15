return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8', -- or branch = '0.1.x'
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        -- Key mappings
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {})

        -- Telescope setup
        telescope.setup {
            defaults = {
                -- Add default configurations here if needed
            },
            pickers = {
                find_files = {
                    theme = "ivy",
                },
                live_grep = {
                    theme = "ivy",
                },
                buffers = {
                    theme = "ivy",
                },
                help_tags = {
                    theme = "ivy",
                },
                lsp_document_symbols = {
                    theme = "ivy",
                },
            },
            extensions = {
                -- Add extensions configurations here if needed
            },
        }
    end
}
