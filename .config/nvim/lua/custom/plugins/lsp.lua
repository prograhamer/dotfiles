return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("neodev").setup {
      }

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require("lspconfig")
      local tele = require("telescope.builtin")

      require("mason").setup()

      require("mason-tool-installer").setup { ensure_installed = { "lua_ls" } }

      local servers = {
        gopls = {
          settings = {
            gopls = {
              buildFlags = { "-tags=all" },
              gofumpt = true,
              usePlaceholders = true,
            },
          },
        },
        lua_ls = {},
        clangd = {},
        pylsp = {
          settings = {
            pylsp = {
              configurationSources = { "flake8", "pycodestyle" },
              plugins = {
                flake8 = {
                  maxLineLength = 119,
                },
                pycodestyle = {
                  maxLineLength = 119,
                },
              },
            },
          },
        },
      }

      for name, config in pairs(servers) do
        config = vim.tbl_deep_extend("force", config, {
          capabilities = capabilities,
        }, {})

        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })

          vim.keymap.set("n", "gds", function()
            tele.lsp_document_symbols {}
          end, { buffer = 0 })
          vim.keymap.set("n", "gr", tele.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gi", tele.lsp_implementations, { buffer = 0 })
        end,
      })
    end,
  },
}
