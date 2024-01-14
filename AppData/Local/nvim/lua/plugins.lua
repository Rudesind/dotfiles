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
                --Dashboard config goes here....
                
                -- Doom theme is used for the dashboard.
                theme = 'hyper',
                config = {

                    -- Displays the current day in the dashboard.
                    week_header = {
                        enable = true,
                    },

                    -- Configuration used for the 'doom' theme.
                    center = {
                        {
                            desc = 'God dag.',
                        },
                    },
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
