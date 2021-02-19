Config { 

    -- Colors are inspired by theme "Gruvbox"
    --
    font =         "xft:Ubuntu Mono:size=12:weight=bold:antialias=true:hinting=true"
    , bgColor =     "#282828"           -- Background color for the bar
    , fgColor =     "#504945"           -- Forground color. Controls text elements
    , position =    TopSize C 100 30    -- Location of the bar (Alignment, width %, min height). Use "Top" for default
    , alpha =       240                 -- Transparency. 0 is transparent, 255 is opaque
    , iconOffset =  11                  -- Offsets any icons displayed

    -- Border
    --
    , border =      BottomB     -- Sets the location of a colored border
    , borderColor = "#504945"   -- Set the color of the border of enabled
    , borderWidth = 2           -- Width of border in pixels if set
   
    , sepChar =  "%"   -- delineator between plugin names and straight text
    , alignSep = "}{"  -- separator between left-right alignment
    , template = " <action=`gnome-control-center`><icon=mylogo.xpm/></action> | %StdinReader% }{ %disku% | %multicpu% | %memory% | %battery% | <fc=#fbf1c7>%pacupdate%</fc> | <action=`gnome-calendar`>%date%</action> "
   
    , lowerOnStart =     True                    -- Send to bottom of window stack on start
    , hideOnStart =      False                   -- Start with window unmapped (hidden)
    , allDesktops =      True                    -- Show on all desktops
    , overrideRedirect = True                    -- Set the Override Redirect flag (Xlib)
    , pickBroadest =     False                   -- Choose widest display (multi-monitor)
    , persistent =       True                    -- Enable/disable hiding (True = disabled)
    , iconRoot =         "/home/zn/.xmonad/xpm"  -- Sets directory for any icons used
    , commands = 

        -- CPU Activity Monitor
        [ Run DiskU         [("/", "<fc=#fbf1c7>hdd:<used>/<size></fc>")][] 20

        , Run MultiCpu      [ "--template"  , "<ipat> <total><fc=#fbf1c7>%</fc>"
                            , "--Low"       , "50"      -- units: %
                            , "--High"      , "85"      -- units: %
                            , "--low"       , "#b8bb26"
                            , "--normal"    , "#fabd2f"
                            , "--high"      , "#cc241d"
                            , "--"
                                , "--load-icon-pattern" , "<icon=cpu/cpu_%%.xpm/>"
                            ] 10
                          
        -- RAM Monitor
        , Run Memory        [ "--template"  ,"<usedipat> <usedratio><fc=#fbf1c7>%</fc>"
                            , "--Low"       , "20"      -- units: %
                            , "--High"      , "90"      -- units: %
                            , "--low"       , "#98971a"
                            , "--normal"    , "#fabd2f"
                            , "--high"      , "#cc241d"
                            , "--"
                                , "--used-icon-pattern" , "<icon=ram/ram_%%.xpm/>"
                            ] 10

        -- Battery Monitor
        , Run Battery       [ "--template"  , "<leftipat> <acstatus>"
                            , "--Low"       , "30"      -- units: %
                            , "--High"      , "80"      -- units: %
                            , "--low"       , "#cc241d"
                            , "--normal"    , "#b8bb26"
                            , "--high"      , "#98971a"
                            , "--" 
                                , "--on-icon-pattern"   , "<icon=battery/on/battery_on_%%.xpm/>"
                                , "--off-icon-pattern"  , "<icon=battery/off/battery_off_%%.xpm/>"
                                , "--idle-icon-pattern" , "<icon=battery/idle/battery_idle_%%.xpm/>"
                                , "-o"  , "<left><fc=#fbf1c7>%</fc>" -- Battery in use
                                , "-O"  , "<left><fc=#fbf1c7>%</fc>" -- Battery charging
                                , "-i"  , "<fc=#928374>IDLE</fc>"    -- Battery charged and idle
                            ] 50
        -- Workspaces
        , Run StdinReader

        -- Pacman Updates
        , Run Com "/home/zn/.local/bin/pacupdates" [] "pacupdate" 36000

        -- Date
        , Run Date          "<fc=#fbf1c7>%F (%a) %T</fc>" "date" 10
    ] 
}
