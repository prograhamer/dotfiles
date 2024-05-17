local set = vim.keymap.set

set("n", "<leader>h", function()
  vim.cmd("noh")
end)

set("n", "[d", vim.diagnostic.goto_prev)
set("n", "]d", vim.diagnostic.goto_next)
