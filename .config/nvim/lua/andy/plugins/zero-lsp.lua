return {
	{
		-- Mason install
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- ensure_installed = { "lua_ls", "pylsp", "clangd", "bashls", "pyright" },
				ensure_installed = { "lua_ls", "pylsp", "clangd", "bashls" },
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							before_init = function(params)
								params.rootPath = vim.fn.getcwd() -- Force local root
							end,
						})
					end,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"L3MON4D3/LuaSnip",
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

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig_default_caps = lspconfig.util.default_config
			lspconfig_default_caps.capabilities =
				vim.tbl_deep_extend("force", lspconfig_default_caps.capabilities, capabilities)

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

			require("mason-lspconfig").setup_handlers({
				-- Default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lspconfig_default_caps,
						--capabilities,
					})
				end,

				-- Custom handler for lua_ls
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = lspconfig_default_caps,
						--capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,

				["pylsp"] = function()
					require("lspconfig").pylsp.setup({
						on_attach = function(client, buffer)
							require("lsp_compl").attach(client, buffer)
						end,
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = {
										ignore = { "E501", "E252", "E701" },
										maxLineLength = 79,
									},
									pylsp_mypy = {
										enabled = true,
										live = true,
										config_sub_paths = { "." },
										overrides = { "--python-executable", py_path, true },
									},
									-- Add more pylsp-specific settings here
									jedi_completion = {
										enabled = true,
										fuzzy = true,
										include_params = true,
									},
									jedi = {
										environment = py_path,
									},
								},
							},
						},
					})
				end,

				-- Add more custom handlers for other servers as needed
			})

			-- note: diagnostics are not exclusive to lsp servers
			-- so these can be global keybindings
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
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
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<space>bf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			-- Key mappings
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
		end,
	},

	{
		-- other tools which can be installed with mason like formatters
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = { "stylua", "black", "jq", "dockerls", "cpplint", "ruff" },
				auto_update = true,
				run_on_start = true,
				run_on_end = true,
			})
		end,
	},
}
