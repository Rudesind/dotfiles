-- Order matters. Load plugins before base settings
require("base") -- General Terminal Settings
require("bootstrap") -- For plugin manager
require("lazy").setup("plugins") -- Load Plugin Manager
require("colorscheme") -- For colors
require("telescope").setup("telescope_config") -- Load the Telescope plugin
