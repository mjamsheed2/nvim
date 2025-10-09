return {
    -- Collection of colorschemes
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            -- Reset all highlights to default
            vim.cmd.highlight("clear")
            -- Ensure background is correct
            vim.o.background = "dark"
            -- Set to default colorscheme
            vim.cmd.colorscheme("default")
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
    },
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
    },
    {
        "projekt0n/github-nvim-theme",
        priority = 1000,
    },
} 