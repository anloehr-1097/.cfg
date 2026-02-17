return {
		"neovim/nvim-lspconfig",
        event = {"BufReadPre", "BufNewFile"},
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
            {"antosha417/nvim-lsp-file-operations", config = true}
		},
		config = function()
			-- basic completion setup
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For LuaSnip users
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				},
			})
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- local lspconfig_default_caps = lspconfig.util.default_config
			-- lspconfig_default_caps.capabilities =
			-- 	vim.tbl_deep_extend("force", lspconfig_default_caps.capabilities, capabilities)
			--
			local venv_path = os.getenv("VIRTUAL_ENV")
			local conda_path = os.getenv("CONDA_PREFIX")
			local py_path = nil
			if venv_path ~= nil then
				py_path = venv_path .. "/bin/python3"
			elseif conda_path ~= nil then
				py_path = conda_path .. "/bin/python3"
			else
				py_path = vim.g.python3_host_prog or "/usr/bin/python3"
			end

			-- Global lsp settings
			vim.lsp.config("*", {
				capabilities = {
					textDocument = {
						semanticTokens = {
							multilineTokenSupport = true,
						},
					},
				},
				root_markers = { ".git" },
			})
			vim.lsp.config["lua-ls"] = {
				cmd = { "lua-language-server" },
				capabilities = capabilities,
				filetypes = { "lua" },
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
				root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
			}
			vim.lsp.enable("lua-ls")

			vim.lsp.config["clangd"] = {
				cmd = { "clangd", "--background-index" },
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = { "compile_commands.json", "compile_flags.txt", ".git/", ".clangd", ".clang-format" },
			}
			vim.lsp.enable("clangd")

			vim.lsp.config("pylsp", {
				name = "pylsp",
				-- cmd_cwd = py_path,
				cmd = { "pylsp" },
				filetypes = { "python" },
				capabilities = capabilities,
				root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "setup.py" }),
				root_markers = { "pyproject.toml", ".git", "*.lock" },
				settings = {
					pylsp = {
						plugins = {
							black = { enabled = false },
							jedi_completion = {
								enabled = true,
								fuzzy = true,
								include_params = true,
							},
							pylsp_mypy = {
								enabled = true,
								live = true,
								config_sub_paths = { "." },
								overrides = { "--python-executable", py_path, true },
								print("Using python executable for mypy: " .. py_path),
							},
						},
					},
				},
			})
			vim.lsp.enable("pylsp")

            vim.lsp.config("pyright",  {
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },
                        },
                    },
                },
            })
            vim.lsp.enable("pyright")

			vim.lsp.config("ruff", {
				name = "ruff",
				cmd = { "ruff", "server" },
				filetypes = { "python" },
				root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "setup.py" }),
				root_markers = { "pyproject.toml", ".git" },
				settings = {},
			})
			vim.lsp.enable("ruff")

			-- note: diagnostics are not exclusive to lsp servers
			-- so these can be global keybindings
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					-- Enable completion triggered by <c-x><c-o>
					vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<space>bf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                    vim.keymap.set('n', '<space>bf', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
				end,
			})
		end,

    opts = {
        servers = {
            clangd = {
                cmd = {"clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",},
            }

        }
    };
	}
