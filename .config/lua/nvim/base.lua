-------------------------------------------------------------------------------
-- .___  ________  __________  ________  ___.
-- |   \ \       \ \        / /       / /   |
-- |    \ \       \ \      / /_______/ /    |
-- |     \ \       \ \    / ________  /     |
-- |      \ \       \ \  / /       / /      |
-- |_______\ \_______\ \/ /_______/ /_______|
--
-- my config.
-- 
-- TODO for this file: 
-- Indent Guides
-- Spell check (only enable when in insert mode)
-- Disable relative when in insert mode
-------------------------------------------------------------------------------

-- Set aliases for vim variables
local g = vim.g -- Global variables
local o = vim.o -- Direct variable like access
local opt = vim.opt -- Setting global and local options
local cmd = vim.cmd

-- Enables 24-bit RGB color in the terminal
o.termguicolors = true
o.background = "dark"
cmd([[colorscheme gruvbox]])

-- Syntax Concealing
o.conceallevel = 2

-- Number of screen lines to keep above/below
o.scrolloff = 8

-- Turn on line numbers and relative numbers
o.number = true
o.relativenumber = true

-- Highlight the line with the cursor
o.cursorline = true

-- Turn on "soft" tabs
o.expandtab = true

-- Word Wrap
o.wrap = true
o.linebreak = true
o.textwidth = 0
o.wrapmargin = 0

-- Enable Soft Tab
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true

-- Use the clipboard instead of registers
o.clipboard = "unnamedplus"

-- Case insensitive searching
o.ignorecase = true
o.smartcase = true

-- Disable file backups
o.backup = false
o.writebackup = false
-- o.backupdir = '/tmp/'

-- Enable undo files
o.undofile = true
-- Need "vim.fn.expand" so "~/" is regonized as home directory
opt.undodir = vim.fn.expand('~/AppData/Local/nvim/undodir') -- Windows Only

-- Disable swap files
o.swapfile = false
-- o.directory = '/tmp/'

-- Enable text highlighting for searches
o.hlsearch = true

-- Enable mouse support for all (previous) modes
opt.mouse = "a"
