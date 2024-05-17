return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>a", function()
        vim.cmd("Git add %")
      end)
      vim.keymap.set("n", "<leader>d", function()
        vim.cmd("Gvdiffsplit HEAD")
      end)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()

      vim.keymap.set("n", "]g", function()
        vim.cmd("Gitsigns next_hunk")
      end)
      vim.keymap.set("n", "[g", function()
        vim.cmd("Gitsigns prev_hunk")
      end)
      vim.keymap.set("n", "<leader>c", function()
        vim.cmd("Gitsigns stage_hunk")
      end)
    end,
  },
}
