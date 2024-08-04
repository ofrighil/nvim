return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"MysticalDevil/inlay-hints.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lsp = require("lspconfig")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
					end, opts)
				end
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lsp.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					hint = {
						enable = true,
					},
				},
			},
		})

		lsp.cmake.setup({ capabilities = capabilities })
		lsp.clangd.setup({ capabilities = capabilities })

		lsp.nil_ls.setup({ capabilities = capabilities })

		lsp.ocamllsp.setup({ capabilities = capabilities })

		lsp.pylsp.setup({ capabilities = capabilities })

		lsp.rust_analyzer.setup({ capabilities = capabilities })
	end,
}
