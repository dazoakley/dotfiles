return {
  -- add catppuccin
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Configure LazyVim to load catppuccin-latte
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-latte",
      -- colorscheme = "tokyonight-day"
    },
  }
}
