return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                fzf = {},
                ["ui-select"] = require("telescope.themes").get_dropdown({})
            }
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>sf", builtin.find_files)
        vim.keymap.set("n", "<leader>sr", builtin.resume)
        vim.keymap.set("n", "<leader>sw", builtin.live_grep)

        --
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})

        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep >") })
        end)
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
        vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {})
    end,
}
