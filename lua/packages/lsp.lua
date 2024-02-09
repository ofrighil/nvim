return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("fidget").setup({})

        local lsp = require("lspconfig")

        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end
        local capabilities = require("cmp_nvim_lsp").default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )

        require("neodev").setup()
        lsp.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        lsp.cmake.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lsp.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lsp.ocamllsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lsp.pylsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lsp.ruff_lsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lsp.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup()
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.scroll_docs(4),
                ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    behaviour = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable() then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end,
                    { "i", "s" }
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    { "i", "s" }
                ),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luansip" },
                { name = "path" },
                { name = "buffer" },
            })
        })
    end,
}
