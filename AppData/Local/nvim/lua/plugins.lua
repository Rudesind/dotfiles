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
            'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            config = function()
            require('dashboard').setup {
                
                -- Doom theme is used for the dashboard.
                theme = 'hyper',
                config = {

                    week_header = {
                        enable = true,
                    },

                    -- Configuration used for the 'doom' theme.
                    center = {
                        {
                            icon = ' ',
                            icon_hl = 'Title',
                            desc = 'Find File',
                            desc_hl = 'String',
                            key = 'b',
                            keymap = 'SPC f f',
                            key_hl = 'Number',
                            action = 'lua print(2)',
                        },
                    },

                    footer = {'[ Something clever goes here ]'},

                },
            }
            end,
            dependencies = {{'nvim-tree/nvim-web-devicons'}}
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
}
