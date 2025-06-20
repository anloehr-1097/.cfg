local function load_dap_configs()
	local cwd = vim.fn.getcwd()
	local dap_config_file = cwd .. "/.nvim/dap.lua"
	if vim.fn.filereadable(dap_config_file) == 1 then
		local dap_config = dofile(dap_config_file)

		for _, config in ipairs(dap_config) do
			table.insert(require("dap").configurations.python, config)
		end
	end
end
-- Create a command to call the function from command mode in nvim
vim.api.nvim_create_user_command("LoadDapConfig", load_dap_configs, {})

return {
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local venv_path = os.getenv("VIRTUAL_ENV")
			local conda_prefix = os.getenv("CONDA_PREFIX")

			local venv_py
			if venv_path then
				venv_py = venv_path .. "/bin/python"
			elseif conda_prefix then
				venv_py = conda_prefix .. "/bin/python"
			elseif os.getenv("PYTHONPATH") then
				venv_py = "/usr/bin/python3"
			else
				venv_py = nil
			end

			if venv_py then
				require("dap-python").setup(venv_py)
			end

			local keymap = vim.keymap
			local dap_py = require("dap-python")

			local opts_map = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				-- set keybinds
				opts_map.desc = "Set denbugging breakpoint"
				keymap.set("n", "<leader>ba", function()
					dap_py.test_method()
				end, opts_map)
			end
		end,

		splitString = function(input)
			local words = {}
			for word in string.gmatch(input, "%S+") do
				table.insert(words, word)
			end
			return words
		end,
	},
}
