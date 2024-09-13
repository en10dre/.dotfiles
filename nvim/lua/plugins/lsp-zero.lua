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
                    ts_ls = { 'javascript', 'typescript' },
                    lua_ls = { 'lua' },
                    html = { 'html' },
                    clangd = { 'c', 'c++' },
                    cssls = { 'css', 'scss', "less" },
                    bashls = { 'bash' },
                }
            })

            -- LSP attachment function with error handling
            local function lsp_attach(client, bufnr)
                if not client then
                    log_error("Failed to attach LSP client to buffer " .. bufnr)
                    return
                end
                -- Enable features specific to the language server
            end

            -- Extend LSP configuration with error handling
            local success, err = pcall(function()
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
                    ensure_installed = {
                        'lua_ls', 'rust_analyzer', 'ts_ls', 'html',
                        'emmet_language_server', 'cssls', 'clangd', 'eslint',
                        'bashls'
                    },
                    handlers = {
                        -- Default handler for LSP servers
                        function(server_name)
                            local server_config = {}
                            local success, err = pcall(function()
                                require('lspconfig')[server_name].setup(server_config)
                            end)

                            if not success then
                                log_error("Failed to set up LSP server: " .. server_name .. "\n" .. err)
                            end
                        end,

                        -- Custom configuration for specific LSP servers
                        lua_ls = function()
                            local success, err = pcall(function()
                                require('lspconfig').lua_ls.setup({
                                    on_init = function(client)
                                        if client.workspace_folders and
                                            #client.workspace_folders > 0 then
                                            local path = client.workspace_folders[1].name
                                            if vim.loop.fs_stat(path .. '/.luarc.json')
                                                or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                                                return
                                            end
                                            client.config.settings.Lua = vim.tbl_deep_extend('force',
                                                client.config.settings.Lua, {
                                                    runtime = { version = 'LuaJIT' },
                                                    workspace = {
                                                        checkThirdParty = false,
                                                        library = { vim.env.VIMRUNTIME },
                                                    }
                                                })
                                        end
                                    end,
                                })
                            end)

                            if not success then
                                log_error("Failed to configure lua_ls: " .. err)
                            end
                        end,

                        -- Repeat similar error handling for other LSP servers
                        ts_ls = function()
                            local success, err = pcall(function()
                                require('lspconfig').ts_ls.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure ts_ls: " .. err)
                            end
                        end,

                        html = function()
                            local success, err = pcall(function()
                                require('lspconfig').html.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure html: " .. err)
                            end
                        end,

                        emmet_language_server = function()
                            local success, err = pcall(function()
                                require('lspconfig').emmet_language_server.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure emmet_language_server: " .. err)
                            end
                        end,

                        bashls = function()
                            local success, err = pcall(function()
                                require('lspconfig').bashls.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure bashls: " .. err)
                            end
                        end,

                        rust_analyzer = function()
                            local success, err = pcall(function()
                                require('lspconfig').rust_analyzer.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure rust_analyzer: " .. err)
                            end
                        end,

                        eslint = function()
                            local success, err = pcall(function()
                                require('lspconfig').eslint.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure eslint: " .. err)
                            end
                        end,

                        clangd = function()
                            local success, err = pcall(function()
                                require('lspconfig').clangd.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure clangd: " .. err)
                            end
                        end,

                        cssls = function()
                            local success, err = pcall(function()
                                require('lspconfig').cssls.setup({})
                            end)
                            if not success then
                                log_error("Failed to configure cssls: " .. err)
                            end
                        end
                    },
                })
            end)

            if not success then
                log_error("Error setting up LSP configuration: " .. err)
            end

            -- Autocompletion setup
            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'path' },
                    { namee = 'buffer' },
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
