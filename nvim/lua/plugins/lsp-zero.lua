return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,                            -- Marks this plugin for lazy loading
        event = { "BufReadPre", "BufNewFile" }, -- Specifies when the plugin should load
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'hrsh7th/vim-vsnip',
            'rafamadriz/friendly-snippets',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Error logging function
            local function log_error(err_msg)
                vim.notify("LSP Error: " .. err_msg, vim.log.levels.ERROR)
            end

            -- Format on save configuration
            lsp_zero.format_on_save({
                format_opts = {
                    async = true, -- Enable asynchronous formatting
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['jdtls'] = { 'java' },
                    ['xml'] = { 'xml' },
                }
            })

            -- LSP attachment function with error handling
            local function lsp_attach(client, bufnr)
                if not client then
                    log_error("Failed to attach LSP client to buffer " .. bufnr)
                    return
                end
                -- Enable features specific to the language server
                local opts = { buffer = bufnr }
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            -- Extend LSP configuration with error handling
            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
            })

            lsp_zero.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            -- Mason setup
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'jdtls', 'marksman',
                    'emmet_language_server',
                    'kotlin_language_server' },
                handlers = {
                    -- Default handler for LSP servers
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    -- Custom configuration for specific LSP servers
                    clangd = function()
                        require 'lspconfig'.clangd.setup {}
                    end,
                    lemminx = function()
                        require('lspconfig').lemminx.setup({})
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({})
                    end,
                    html = function()
                        require('lspconfig').html.setup({
                            capabilities = capabilities,
                        })
                    end,
                    cssls = function()
                        require('lspconfig').cssls.setup({
                            capabilities = capabilities,
                        })
                    end,
                    marksman = function()
                        require('lspconfig').marksman.setup({
                        })
                    end,
                    jdtls = function()
                        require('lspconfig').jdtls.setup({
                        })
                    end,
                    kotlin_language_server = function()
                        require('lspconfig').kotlin_language_server.setup({
                        })
                    end,
                }
            })

            -- Autocompletion setup
            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    -- { name = 'cody' },
                    { name = 'path' },
                },
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                -- Setup vim-dadbod
                cmp.setup.filetype({ "sql" }, {
                    sources = {
                        { name = "vim-dadbod-completion" },
                        { name = "buffer" },
                    },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
            })
        end
    }
}
