return {
	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			local keymap = vim.keymap
			local dap_py = require("dap-python")

			local opts_map = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				-- set keybinds
				opts_map.desc = "Set denbugging breakpoint"
				keymap.set("n", "<leader>sd", "<cmd> dap_py.test_method() <CR>", opts_map)
			end
		end,
	},
}
