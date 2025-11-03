return {
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
          end
        end,
      },
    },
  },

  -- solarized
  {
    "maxmx03/solarized.nvim",
    branch = "main",
    lazy = false,
    name = "solarized",
    main = "solarized",
    priority = 1000,
    -- Display colors in a new buffer with command: `:Solarized colors`
    -- See: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
    opts = {
      -- See: https://github.com/maxmx03/solarized.nvim/blob/main/lua/solarized/palette.lua
      palette = "selenized",
      variant = "winter",
      -- See: https://github.com/maxmx03/solarized.nvim?tab=readme-ov-file#default-config
      styles = {
        keywords = { bold = false },
      },
    },
    config = function(plugin, opts)
      vim.o.background = "light"
      require(plugin.main).setup(opts)
      vim.cmd.colorscheme = "solarized"
    end,
  },

  -- choose your theme...
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-latte",
    }
  }
}
