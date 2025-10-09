vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Better movement of selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up"   })

-- Keep cursor centered when joining lines or paging
vim.keymap.set("n", "J", "mzJ`z",        { desc = "Join line below and keep cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz",  { desc = "Page down and center"            })
vim.keymap.set("n", "<C-u>", "<C-u>zz",  { desc = "Page up and center"              })

-- Keep search matches centered and open folds
vim.keymap.set("n", "n", "nzzzv",        { desc = "Next search result centered"     })
vim.keymap.set("n", "N", "Nzzzv",        { desc = "Prev search result centered"     })

-- don't overwrite the default register when pasting in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete to the black hole (so you don't clobber your registers)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- quick Escape from insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Search & replace the word under the cursor throughout the buffer
-- After you hit <leader>s, the command line will be:
-- :%s/\<current_word\>/current_word/gI
-- with the cursor placed just before the final slashes so you can tweak flags.
vim.keymap.set(
  "n",
  "<leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>",
  { desc = "Search & replace word under cursor" }
)

-- Make the current file executable
vim.keymap.set(
  "n",
  "<leader>x",
  "<cmd>!chmod +x %<CR>",
  { silent = true, desc = "Make file executable" }
)

