return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local lsp_kind_comparator = function(conf)
        local lsp_types = require("cmp.types").lsp
        return function(entry1, entry2)
          if entry1.source.name ~= "nvim_lsp" then
            if entry2.source.name == "nvim_lsp" then
              return false
            else
              return nil
            end
          end
          local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
          local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

          local priority1 = conf.kind_priority[kind1] or 0
          local priority2 = conf.kind_priority[kind2] or 0
          if priority1 == priority2 then
            return nil
          end
          return priority2 < priority1
        end
      end

      local nextCompletion = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.snippet.active({ direction = 1 }) then
          feedkey('<cmd>lua vim.snippet.jump(1)<cr>', '')
        else
          fallback() -- The fallback function sends a already mapped key
        end
      end, { "i", "s" })

      local previousCompletion = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback() -- The fallback function sends a already mapped key
        end
      end, { "i", "s" })


      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = nextCompletion,
          ["<Down>"] = nextCompletion,
          ["<S-Tab>"] = previousCompletion,
          ["<Up>"] = previousCompletion,
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-k>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        },
        sorting = {
          priority_weight = 1.0,
          comparators = {
            cmp.config.compare.exact,
            lsp_kind_comparator({
              kind_priority = {
                Parameter = 14,
                Field = 13,
                Variable = 12,
                Property = 11,
                Constant = 10,
                Enum = 10,
                EnumMember = 10,
                Event = 10,
                Function = 10,
                Method = 10,
                Operator = 10,
                Reference = 10,
                Struct = 10,
                File = 8,
                Folder = 8,
                Class = 5,
                Color = 5,
                Module = 5,
                Keyword = 2,
                Constructor = 1,
                Interface = 1,
                Snippet = 0,
                Text = 1,
                TypeParameter = 1,
                Unit = 1,
                Value = 1,
              },
            }),
            cmp.config.compare.locality,
            cmp.config.compare.score,
          },
        },
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp", keyword_length = 1 },
          },
          {
            { name = "buffer" },
            { name = "path" },
          }),
      })
    end,
    event = "InsertEnter",
  },
}
