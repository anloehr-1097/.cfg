return {
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)

            local venv_path = os.getenv('VIRTUAL_ENV')
            local venv_py
            local dap_config
            if venv_path then
                venv_py = venv_path .. '/bin/python'
            else
                venv_py = '/usr/bin/python3'
            end

            local cwd = vim.fn.getcwd()
            local dap_config_file = cwd .. '/.nvim/dap.lua'
            if vim.fn.filereadable(dap_config_file) == 1 then
                dap_config = dofile(dap_config_file)
            end

            --local dap_python = require('nvim-dap-python')
            --dap_python.setup(venv_py)

            require('dap-python').setup(venv_py)
            table.insert(require('dap').configurations.python, {
                type = 'python',
                request = 'launch',
                name = "Launch " .. (dap_config.module or "Module");
                module = dap_config.module or function()
                    return vim.fn.input('Module name to debug: ')
                end;
                args = dap_config.args or function()
                    return vim.fn.input('Arguments: ', ''):split(" ")
                end;
                -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
            })


			-- local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			-- require("dap-python").setup(path)
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
    }

}
