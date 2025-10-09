return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.8',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        
        -- Basic telescope setup
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<M-v>"] = "select_vertical",
                    },
                    n = {
                        ["<M-v>"] = "select_vertical",
                    },
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown()
                }
            },
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            }
        })

        -- Enable telescope extensions
        require('telescope').load_extension('ui-select')
        
        -- Keymaps
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files', noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files', noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'Telescope grep string', noremap = true, silent = true, nowait = true })
        
        -- Add colorscheme picker
        vim.keymap.set('n', '<leader>th', builtin.colorscheme, { desc = 'Choose colorscheme with preview' })
        
        -- Buffer management
        vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Show and pick buffers' })
    end,
} 
