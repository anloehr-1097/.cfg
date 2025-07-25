function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- return {
--     {
--         "folke/tokyonight.nvim",
--         config = function()
--             require("tokyonight").setup({
--                 -- your configuration comes here
--                 -- or leave it empty to use the default settings
--                 style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--                 transparent = true, -- Enable this to disable setting the background color
--                 terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--                 styles = {
--                     -- Style to be applied to different syntax groups
--                     -- Value is any valid attr-list value for `:help nvim_set_hl`
--                     comments = { italic = false },
--                     keywords = { italic = false },
--                     -- Background styles. Can be "dark", "transparent" or "normal"
--                     sidebars = "dark", -- style for sidebars, see below
--                     floats = "dark", -- style for floating windows
--                 },
--             })
--
--         vim.cmd.colorscheme("tokyonight")
--         end
--     }
-- }
--
-- return {
-- 	{
-- 		"folke/tokyonight.nvim",
-- 		config = function()
-- 			require("tokyonight").setup({
-- 				-- your configuration comes here
-- 				-- or leave it empty to use the default settings
-- 				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
-- 				transparent = true, -- Enable this to disable setting the background color
-- 				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
-- 				styles = {
-- 					-- Style to be applied to different syntax groups
-- 					-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 					comments = { italic = false },
-- 					keywords = { italic = false },
-- 					-- Background styles. Can be "dark", "transparent" or "normal"
-- 					sidebars = "dark", -- style for sidebars, see below
-- 					floats = "dark", -- style for floating windows
-- 				},
-- 			})
--
-- 			vim.cmd.colorscheme("tokyonight")
-- 		end,
-- 	},
-- }

-- Nordic Theme --
-- return {
-- 	"AlexvZyl/nordic.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("nordic").load()
-- 	end,
-- }
--     "rose-pine/neovim",
-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			disable_background = true,
-- 			styles = {
-- 				italic = false,
-- 			},
-- 		})
--
-- 		vim.cmd("colorscheme rose-pine")
--
-- 		ColorMyPencils()
-- 	end,
-- }
--
-- return {
-- 	"RostislavArts/naysayer.nvim",
-- 	priority = 1000,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd.colorscheme("naysayer")
-- 	end,
-- }

-- return {
-- 	"maxmx03/solarized.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	---@type solarized.config
-- 	opts = {},
-- 	config = function(_, opts)
-- 		vim.o.termguicolors = true
-- 		vim.o.background = "dark"
-- 		require("solarized").setup(opts)
-- 		vim.cmd.colorscheme("solarized")
-- 	end,
-- }

-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("cyberdream").setup({
-- 			transparent = false, -- Enable transparent background
-- 			styles = {
-- 				comments = { italic = false }, -- Disable italic for comments
-- 				keywords = { italic = false }, -- Disable italic for keywords
-- 			},
-- 			-- Add any other configuration options here
-- 		})
-- 		vim.cmd("colorscheme cyberdream")
-- 	end,
-- }

-- Neosolarized
return {
	"Tsuzat/Neosolarized.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		require("NeoSolarized").setup({
			transparent = false, -- Enable transparent background

			styles = {
				comments = { italic = false }, -- Disable italic for comments
				keywords = { italic = false }, -- Disable italic for keywords
			},
			-- Add any other configuration options here
		})
		vim.cmd("colorscheme NeoSolarized")
	end,
}
--     "rose-pine/neovim",
-- {
--     name = "rose-pine",
--     config = function()
--         require('rose-pine').setup({
--             disable_background = true,
--             styles = {
--                 italic = false,
--             },
--         })
--
--         vim.cmd("colorscheme rose-pine")
--
--         ColorMyPencils()
--     end
-- },
--
-- }

-- return {
-- 	"thimc/gruber-darker.nvim",
-- 	config = function()
-- 		local bg = "#011628" local bg_2 = "#000233"
-- 		local bg_dark = "#011423"
-- 		local bg_dark_2 = "#011100"
-- 		local bg_highlight = "#143652"
-- 		local bg_search = "#0A64AC"
-- 		local bg_visual = "#275378"
-- 		local fg = "#CBE0F0"
-- 		local fg_dark = "#B4D0E9"
-- 		local fg_gutter = "#627E97"
-- 		local border = "#547998"
--
-- 		require("gruber-darker").setup({
-- 			-- OPTIONAL
-- 			transparent = false, -- removes the background
-- 			-- underline = false, -- disables underline fonts
-- 			-- bold = false, -- disables bold fonts
-- 			on_colors = function(colors)
-- 				colors.bg = bg_2
-- 				colors.bg_dark = bg_dark_2
-- 				colors.bg_float = bg_dark
-- 				colors.bg_highlight = bg_highlight
-- 				colors.bg_popup = bg_dark
-- 				colors.bg_search = bg_search
-- 				colors.bg_sidebar = bg_dark
-- 				colors.bg_statusline = bg_dark
-- 				colors.bg_visual = bg_visual
-- 				colors.border = border
-- 				colors.fg = fg
-- 				colors.fg_dark = fg_dark
-- 				colors.fg_float = fg
-- 				colors.fg_gutter = fg_gutter
-- 				colors.fg_sidebar = fg_dark
-- 			end,
-- 		})
--
--     vim.cmd.colorscheme("gruber-darker")
-- 	end,
-- -- {
-- --         "folke/tokyonight.nvim",
-- --         config = function()
-- --             require("tokyonight").setup({
-- --                 -- your configuration comes here
-- --                 -- or leave it empty to use the default settings
-- --                 style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
-- --                 transparent = true, -- Enable this to disable setting the background color
-- --                 terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
-- --                 styles = {
-- --                     -- Style to be applied to different syntax groups
-- --                     -- Value is any valid attr-list value for `:help nvim_set_hl`
-- --                     comments = { italic = false },
-- --                     keywords = { italic = false },
-- --                     -- Background styles. Can be "dark", "transparent" or "normal"
-- --                     sidebars = "dark", -- style for sidebars, see below
-- --                     floats = "dark", -- style for floating windows
-- --                 },
-- --             })
-- --
-- --         --vim.cmd.colorscheme("tokyonight")
-- --         end
-- --     },
--
-- }
