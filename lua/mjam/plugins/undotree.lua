return {
    "mbbill/undotree",
    lazy = false,  -- Make sure it loads at startup
    cmd = "UndotreeToggle",  -- Load when this command is used
    config = function()
        vim.g.undotree_DiffCommand = "FC"
        vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR><C-w>h', { silent = true })
    end,
} 