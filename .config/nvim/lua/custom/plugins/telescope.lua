return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("telescope").setup {
      }

      local builtin = require "telescope.builtin"

      vim.keymap.set("n", "<C-L>", builtin.live_grep)
      vim.keymap.set("n", "<C-P>", builtin.find_files)
      vim.keymap.set("n", "S", builtin.buffers)
    end,
  },
}
