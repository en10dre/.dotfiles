function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                transparent = true,
            })
            vim.cmd [[colorscheme kanagawa-dragon]]
        end
    },
    {
        "sainnhe/sonokai",
        config = function()
            -- vim.cmd [[colorscheme sonokai]]
        end
    },
    {
        "sainnhe/everforest",
        config = function()
            -- vim.cmd [[colorscheme everforest]]
        end
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require("onedark").setup({
                transparent = true,

                code_style = {
                    comments = "none",
                },
            })
            -- vim.cmd [[colorscheme onedark]]
        end
    },
    {
        'Mofiqul/dracula.nvim',
        config = function()
            require("dracula").setup({
                transparent_bg = true,
            })
            -- vim.cmd [[colorscheme dracula]]
        end
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "erikbackman/brightburn.vim",
    },
    {
        lazy = false,
        priority = 1000,
        "tjdevries/colorbuddy.nvim",
        config = function()
            require("colorbuddy").setup(
            )
            -- vim.cmd.colorscheme "gruvbuddy"
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
            -- vim.cmd("colorscheme rose-pine");
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
        config = function()
            require("tokyonight").setup({
                transparent = true,
                terminal_colors = true,

                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark",
                    floats = "dark",
                },
            })
            -- vim.cmd("colorscheme tokyonight") -- Set tokyonight as default
        end
    }
}
