return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  --   {
  --     "oxfist/night-owl.nvim",
  --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --     priority = 1000, -- make sure to load this before all the other start plugins
  --     config = function()
  --       -- load the colorscheme here
  --       require("night-owl").setup()
  --       vim.cmd.colorscheme("night-owl")
  --       vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
  --     end,
  --   },
}
