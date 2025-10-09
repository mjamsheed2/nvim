return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',  -- This is actually default but good to be explicit about theme
                component_separators = { left = '', right = ''},  -- Minimal separators
                section_separators = { left = '', right = ''},    -- Minimal separators
            }
        })
    end
}
