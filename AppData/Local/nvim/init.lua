-- Order matters. Load plugins before base settings
require("bootstrap") -- For plugin manager
require("lazy").setup("plugins") -- Load Plugin Manager
require("base") -- General Terminal Settings
