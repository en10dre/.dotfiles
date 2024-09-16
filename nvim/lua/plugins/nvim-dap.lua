return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require('dap')

            local widgets = require('dap.ui.widgets')

            -- Keybindings for debugging actions
            vim.keymap.set('n', '<F5>', function() dap.continue() end,
                { noremap = true, silent = true, desc = 'Continue Debugging' })
            vim.keymap.set('n', '<F10>', function() dap.step_over() end,
                { noremap = true, silent = true, desc = 'Step Over' })
            vim.keymap.set('n', '<F11>', function() dap.step_into() end,
                { noremap = true, silent = true, desc = 'Step Into' })
            vim.keymap.set('n', '<F12>', function() dap.step_out() end,
                { noremap = true, silent = true, desc = 'Step Out' })

            vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end,
                { noremap = true, silent = true, desc = 'Toggle Breakpoint' })
            vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end,
                { noremap = true, silent = true, desc = 'Set Conditional Breakpoint' })
            vim.keymap.set('n', '<Leader>lp', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end, { noremap = true, silent = true, desc = 'Set Log Point' })

            vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end,
                { noremap = true, silent = true, desc = 'Open REPL' })
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end,
                { noremap = true, silent = true, desc = 'Run Last Debug Configuration' })

            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() widgets.hover() end,
                { noremap = true, silent = true, desc = 'Hover Info' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() widgets.preview() end,
                { noremap = true, silent = true, desc = 'Preview Value' })
            vim.keymap.set('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end,
                { noremap = true, silent = true, desc = 'Show Stack Frames' })
            vim.keymap.set('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end,
                { noremap = true, silent = true, desc = 'Show Scopes' })
            dap.configurations.java = {
                {
                    -- You need to extend the classPath to list your dependencies.
                    -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
                    classPaths = {},

                    -- If using multi-module projects, remove otherwise.
                    projectName = "yourProjectName",

                    javaExec = "~/.sdkman/candidates/java/21.0.4-tem/bin/java",
                    mainClass = "your.package.name.MainClassName",

                    -- If using the JDK9+ module system, this needs to be extended
                    -- `nvim-jdtls` would automatically populate this property
                    modulePaths = {},
                    name = "Launch YourClassName",
                    request = "launch",
                    type = "java"
                },
            }
            dap.adapters["local-lua"] = {
                type = "executable",
                command = "node",
                args = {
                    vim.fn.expand("~/local-lua-debugger-vscode/extension/debugAdapter.js")
                },
                enrich_config = function(config, on_config)
                    if not config["extensionPath"] then
                        local c = vim.deepcopy(config)
                        -- 💀 If this is missing or wrong you'll see
                        -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
                        c.extensionPath = "~/local-lua-debugger-vscode/"
                        on_config(c)
                    else
                        on_config(config)
                    end
                end,
            }
            -- Set the configuration for Lua files
            dap.configurations.lua = {
                {
                    type = "local-lua",
                    request = "launch",
                    name = "Launch Lua file",
                    program = function()
                        return vim.fn.input('Path to Lua file: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}', -- Current workspace directory
                    stopOnEntry = false,
                    extensionPath = vim.fn.expand("~/local-lua-debugger-vscode/"),
                },
            }
        end
    }
}
