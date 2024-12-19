return {
  "paul-louyot/toggle-quotes.nvim",

  vim.keymap.set("n", "<C-'>", "<cmd>ToggleQuotes<CR>", { desc = "Toggle quotes" }),
  vim.keymap.set("i", "<C-'>", "<cmd>ToggleQuotes<CR>", { desc = "Toggle quotes" }),
}
