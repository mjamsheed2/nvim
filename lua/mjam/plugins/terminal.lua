return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        -- Detect OS
        local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
        
        -- Only configure PowerShell on Windows
        if is_windows then
            local powershell_options = {
                shell       = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
                shellcmdflag= "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                shellredir  = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                shellpipe   = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                shellquote  = "",
                shellxquote = "",
            }

            for option, value in pairs(powershell_options) do
                vim.opt[option] = value
            end
        end
        -- On Linux, use default shell (usually bash or zsh)
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-`>]], -- ctrl + ` to toggle terminal
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true,
            float_opts = {
                border = 'curved',
                width = function()
                    return math.floor(vim.o.columns * 0.8)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.8)
                end,
            },
        })

        -- Custom terminal commands
        local Terminal = require('toggleterm.terminal').Terminal

        -- Lazygit terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "curved",
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
        })

        -- Function to toggle lazygit
        function _lazygit_toggle()
            lazygit:toggle()
        end

        -- Additional keymaps
        vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle Lazygit"})
        vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", {desc = "Toggle floating terminal"})
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", {desc = "Toggle horizontal terminal"})
        vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", {desc = "Toggle vertical terminal"})
        vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = "Escape Terminal mode", noremap = true, silent = true })
    end
} 
