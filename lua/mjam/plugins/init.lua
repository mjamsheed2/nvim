return {
    -- You can return a list of plugins directly here
    {
        'ThePrimeagen/vim-be-good',
        cmd = 'VimBeGood',
    },

    -- Or require other files that return plugin configs
    require("mjam.plugins.telescope"),
    require("mjam.plugins.treesitter"),
    require("mjam.plugins.harpoon"),
    require("mjam.plugins.undotree"),
    require("mjam.plugins.colorscheme"),
    require("mjam.plugins.lsp"),  -- Now includes completion, autopairs, and comments
    require("mjam.plugins.lualine"),
    require("mjam.plugins.git"),  -- Separate git integration
    require("mjam.plugins.terminal"), -- Terminal integration
    require("mjam.plugins.ui"),   -- UI enhancements (bufferline, aerial, trouble)
} 
