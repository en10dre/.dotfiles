return {
    -- Lua
    {
        "tjdevries/colorbuddy.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbuddy")
        end
    }
}
