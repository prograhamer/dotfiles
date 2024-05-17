return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.opt.termguicolors = true
      require("lualine").setup {}
    end,
  },
}
