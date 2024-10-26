return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "willoamboman/mason.nvim",
        "willoamboman/mason-lspconfig.nvim",
        "L3MON4D3/LuaSnip",
    },


    config = function()
        -- note: diagnostics are not exclusive to lsp servers
        -- so these can be global keybindings
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>');
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>');
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>');
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- these will be buffer-local keybindings
                -- because they only work if you have an active language server
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<space>bf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end
        })

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        local default_setup = function(server)
            require('lspconfig')[server].setup({
                capabilities = lsp_capabilities,
            })
        end

        local lspconfig = require('lspconfig')
        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        -- formatter options
                        black = { enabled = false },
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        -- linter options
                        pylint = { enabled = true, executable = "pylint", ignore = {"E252", "E701"}},
                        pyflakes = { enabled = false },
                        pycodestyle = { enabled = false },
                        flake8 = { enabled = false, ignore = { "E252" }},
                        -- type checker
                        pylsp_mypy = { enabled = true, live = true },
                        -- auto-completion options
                        jedi_completion = { fuzzy = true },
                        -- import sorting
                        pyls_isort = { enabled = true },
                    },
                },
            },
            flags = {
                debounce_text_changes = 200,
            },
        }



        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'pylsp', 'clangd', 'lua_ls', 'bashls'},
            handlers = {
                default_setup,
            },
        })

        local cmp = require('cmp')

        cmp.setup({
            sources = {
                {name = 'nvim_lsp'},
            },
            mapping = cmp.mapping.preset.insert({
                -- Enter key confirms completion item
                ['<CR>'] = cmp.mapping.confirm({select = false}),

                -- Ctrl + space triggers completion menu
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
    end;

}
