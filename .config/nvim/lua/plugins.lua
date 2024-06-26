-- Todo: Add logo to header of dashboard
-- Todo: Configure Dashboard to use the telescope plugin
-- Todo: Use the "doom" theme
return {

    {   
        'ellisonleao/gruvbox.nvim',
        priority = 1000 , 
        config = true, 
        opts = ...
    },

    {
        'nvim-lua/plenary.nvim'
    },

    {   
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    },

    {
        'nvim-tree/nvim-web-devicons',
    },

    {
        'nvim-treesitter/nvim-treesitter', 
    },

    {
        "goolord/alpha-nvim",
        config = function ()
            local alpha = require'alpha'
            local dashboard = require'alpha.themes.dashboard'
            dashboard.section.header.val = {
                [[--------------------------------------------------------]],
                [[████   █████████   ░▒▒░▒▓▒███████████   █████████░  ████]],
                [[███▓▒▓  █████████   ██▒░▒██████▓▓███   █████████   █████]],
                [[██████   █████████   ████████▓▒▒███   █████████   ██████]],
                [[███████   █████████   ████████████               ███████]],
                [[████████   ██▓░▒████   ██████████               ████████]],
                [[███▒▒▓███   ███▓░▒███   ████████   █████████   █████████]],
                [[██████████   █████████   █▒░███   █████████   █████░░▒░█]],
                [[░░█████████   █████████   ████   █████████   ███████████]],
                [[----------------BUILDING BETTER NOTES-------------------]],
            }
            dashboard.section.buttons.val = {
                dashboard.button( "e", "  New file" , ":ene<CR>"),
                dashboard.button( "o", "  Search files" , ":Telescope find_files <CR>"),
                dashboard.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
            }
            local handle = io.popen('fortune')
            local fortune = handle:read("*a")
            handle:close()
            dashboard.section.footer.val = fortune
            dashboard.config.opts.noautocmd = true
            vim.cmd[[autocmd User AlphaReady echo 'ready']]
            alpha.setup(dashboard.config)
        end
    },
}
