-- ~/.config/nvim/lua/plugins/none-ls.lua
return {
    "nvimtools/none-ls.nvim",
    config = function()
        local none_ls = require("none-ls")

        none_ls.setup({
            sources = {
                none_ls.builtins.formatting.stylua,
                none_ls.builtins.formatting.prettier.with({
                    filetypes = { "html", "css", "javascript", "javascriptreact", "typescriptreact", "json", "scss", "less" },
                    extra_filetypes = { "svelte", "yaml", "markdown", "markdown.mdx", "graphql" },
                }),
                none_ls.builtins.diagnostics.eslint_d.with({
                    command = "eslint_d",
                }),
                none_ls.builtins.code_actions.eslint_d.with({
                    command = "eslint_d",
                }),
                none_ls.builtins.formatting.shfmt,
                none_ls.builtins.diagnostics.shellcheck.with({
                    command = "shellcheck",
                }),
                none_ls.builtins.diagnostics.phpcs,
                none_ls.builtins.formatting.phpcbf,
                none_ls.builtins.diagnostics.djlint,
                none_ls.builtins.formatting.djlint,
                none_ls.builtins.formatting.stylelint,
                none_ls.builtins.diagnostics.stylelint,
                none_ls.builtins.diagnostics.erb_lint,
                none_ls.builtins.diagnostics.rubocop,
                none_ls.builtins.formatting.rubocop,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })

        vim.keymap.set("n", "<leader>gf", function() vim.lsp.buf.format({ async = true }) end, {})
        vim.notify("none-ls setup complete", vim.log.levels.INFO)
    end,
}
