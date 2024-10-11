return {
    "divagueame/lacasitos.nvim",
    config = function()
        require("lacasitos").setup()
        local themes = { "posterpole", "rose-pine", "tokyonight-storm", "onedark" }
        local selected_theme = require("lacasitos").choose_option(themes)
        vim.cmd("colorscheme " .. selected_theme)
    end,
}
