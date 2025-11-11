return {
    -- Mason for installing LSP servers
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",    -- Lua
                    "pyright",   -- Python
                    "gopls",     -- Go
                    "clangd",    -- C/C++
                    "verible",   -- SystemVerilog (Google's Verible)
                },
                automatic_installation = true,
            })
        end
    },

    -- Completion and snippets
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            
            -- LSP completion source
            'hrsh7th/cmp-nvim-lsp',
            
            -- Useful completion sources
            'hrsh7th/cmp-path',                -- File paths
            'hrsh7th/cmp-buffer',              -- Buffer words
            'hrsh7th/cmp-cmdline',             -- Vim's cmdline
            'rafamadriz/friendly-snippets',    -- Snippet collection
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            
            -- Load friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },

    -- Auto pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,  -- Enable treesitter integration
                disable_filetype = { "TelescopePrompt" },
            })
            
            -- Make autopairs work with cmp
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },

    -- Comment toggling
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
        dependencies = 'JoosepAlviste/nvim-ts-context-commentstring'
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Setup language servers
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            
            -- Lua
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
            vim.lsp.enable('lua_ls')

            -- Python
            vim.lsp.config('pyright', {
                capabilities = capabilities,
            })
            vim.lsp.enable('pyright')

            -- Go
            vim.lsp.config('gopls', {
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })
            vim.lsp.enable('gopls')

            -- C/C++
            vim.lsp.config('clangd', {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--suggest-missing-includes",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                },
            })
            vim.lsp.enable('clangd')

            -- SystemVerilog (Verible)
            vim.lsp.config('verible', {
                capabilities = capabilities,
                filetypes = { 'verilog', 'systemverilog' },
                root_dir = function(fname)
                    return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
                end,
            })
            vim.lsp.enable('verible')

            -- Diagnostic keymaps
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local telescope_builtin = require('telescope.builtin')
                    
                    -- Navigation with Telescope (better UI)
                    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Go to declaration', noremap = true })
                    vim.keymap.set('n', '<leader>gd', telescope_builtin.lsp_definitions, { buffer = ev.buf, desc = 'Go to definition', noremap = true })
                    vim.keymap.set('n', '<leader>gr', telescope_builtin.lsp_references, { buffer = ev.buf, desc = 'Go to references', noremap = true })
                    vim.keymap.set('n', '<leader>gi', telescope_builtin.lsp_implementations, { buffer = ev.buf, desc = 'Go to implementation', noremap = true })
                    
                    -- Information
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Show documentation' })
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Show signature help' })
                    
                    -- Workspace management
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = 'Add workspace folder' })
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = 'Remove workspace folder' })
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = 'List workspace folders' })
                    
                    -- Code actions
                    vim.keymap.set('n', '<space>D', telescope_builtin.lsp_type_definitions, { buffer = ev.buf, desc = 'Go to type definition' })
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename symbol' })
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code actions' })
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, { buffer = ev.buf, desc = 'Format code' })
                end,
            })
        end
    }
} 