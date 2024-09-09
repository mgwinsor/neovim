return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  opts = {
    preset = "modern",
  },
  spec = {
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
  },
}
