return {
    -- VS Code-like tabs
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    separator_style = "slant",
                    always_show_bufferline = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    color_icons = true,
                    numbers = "none",
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true
                        }
                    }
                }
            })

            -- Keymaps for buffer navigation
            vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
            vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
            vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
            vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
            vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
            vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
        end
    },

    -- Code outline
    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                layout = {
                    default_direction = "right",
                    placement = "edge",
                },
                attach_mode = "global",
                backends = { "treesitter", "lsp", "markdown", "man" },
                show_guides = true,
                guides = {
                    mid_item = "├─",
                    last_item = "└─",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
                filter_kind = false,
                -- These are the defaults
                icons = {
                    Array = " ",
                    Boolean = " ",
                    Class = " ",
                    Constant = " ",
                    Constructor = " ",
                    Enum = " ",
                    EnumMember = " ",
                    Event = " ",
                    Field = " ",
                    File = " ",
                    Function = " ",
                    Interface = " ",
                    Key = " ",
                    Method = " ",
                    Module = " ",
                    Namespace = " ",
                    Null = " ",
                    Number = " ",
                    Object = " ",
                    Operator = " ",
                    Package = " ",
                    Property = " ",
                    String = " ",
                    Struct = " ",
                    TypeParameter = " ",
                    Variable = " ",
                },

                -- Keymaps in aerial window
                on_attach = function(bufnr)
                    vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Previous symbol" })
                    vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Next symbol" })
                end,
            })

            -- Toggle aerial (changed from <leader>a to <leader>o for "outline")
            vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR><C-w>l", { desc = "Toggle code outline" })
        end
    },

    -- Better error/warning management
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({
                position = "bottom",
                height = 10,
                icons = true,
                mode = "workspace_diagnostics",
                fold_open = "",
                fold_closed = "",
                group = true,
                padding = true,
                action_keys = {
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = {"<cr>", "<tab>"},
                    open_split = { "<c-x>" },
                    open_vsplit = { "<c-v>" },
                    open_tab = { "<c-t>" },
                    jump_close = {"o"},
                    toggle_mode = "m",
                    toggle_preview = "P",
                    hover = "K",
                    preview = "p",
                    close_folds = {"zM", "zm"},
                    open_folds = {"zR", "zr"},
                    toggle_fold = {"zA", "za"},
                    previous = "k",
                    next = "j"
                },
                indent_lines = true,
                auto_open = false,
                auto_close = false,
                auto_preview = true,
                auto_fold = false,
                use_diagnostic_signs = true
            })

            -- Keymaps
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
            vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Trouble workspace diagnostics" })
            vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Trouble document diagnostics" })
            vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Trouble loclist" })
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Trouble quickfix" })
            vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "Trouble LSP references" })
        end
    }
} 
