return {
  -- Set colorscheme to use
  colorscheme = "onenord",

  plugins = {
    {
      "rmehri01/onenord.nvim",
      as = "onenord",
      config = function()
        require('onenord').setup({
          theme = "light", -- "dark" or "light".
        })
      end,
    },
  },

  -- Set dashboard header
  header = {
      " ",
      "    ███    ██ ██    ██ ██ ███    ███",
      "    ████   ██ ██    ██ ██ ████  ████",
      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      "    ██   ████   ████   ██ ██      ██",
  },
}
