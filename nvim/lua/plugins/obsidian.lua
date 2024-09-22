return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "ZettelKosmos",
                path = "~/zettelkosmos",
            },
        },

        notes_subdir = "07 - Atomic Notes",

        templates = {
            folder = "06 - Templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },

        -- see below for full list of options 👇
        new_notes_location = "notes_subdir",
        disable_frontmatter = true,
    },
}
