-- Imports

-- Base
import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll
import qualified XMonad.Actions.Search as S

-- Data
import Data.Char (toUpper)

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeysP)

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicBars

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.ShowWName
import XMonad.Layout.Renamed
import XMonad.Layout.IndependentScreens

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

-- My Config

myFont :: String
myFont = "xft:Ubuntu Mono:size=12:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "alacritty"            -- Default terminal for xmonad

myModMask :: KeyMask
myModMask = mod4Mask                -- "Mod" key is set to super or windows key

myBrowser :: String
myBrowser = "brave"                 -- My default browser

myEditor :: String
myEditor = "vim"                    -- Sets editor for tree select

myBorderWidth :: Dimension
myBorderWidth = 2                   -- Size of border around windows

myNormalBorderColor :: String
myNormalBorderColor  = "#504945"    -- Border color for non-focused windows

myFocusedBorderColor :: String
myFocusedBorderColor = "#fbf1c7"    -- Border color for focused windows

altMask :: KeyMask
altMask = mod1Mask                  -- Used for xprompts

mySpacing :: Int
mySpacing = 10                      -- My preferred spacing between windows

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True          -- Whether focus follows the mouse pointer.

myClickJustFocuses :: Bool
myClickJustFocuses = False          -- Whether clicking on a window to focus also passes the click to the window


-- My Workspaces
-- Workspace Example:
-- workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["main","web","code","notes","music"]

-- XPrompt Config

znXPConfig :: XPConfig
znXPConfig = def
      { font                = myFont
      , bgColor             = "#282828"
      , fgColor             = "#fbf1c7"
      , bgHLight            = "#d65d0e"
      , fgHLight            = "#fbf1c7"
      , borderColor         = "#504945"
      , promptBorderWidth   = 0
      , promptKeymap        = znXPKeymap
      , position            = Top
      , height              = 23
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      , searchPredicate     = fuzzyMatch
      , defaultPrompter     = id $ map toUpper  -- change prompt to UPPER
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
znXPConfig' :: XPConfig
znXPConfig' = znXPConfig
      { autoComplete        = Nothing
      }

-- XPrompt Keymap

znXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
znXPKeymap = M.fromList $
     map (first $ (,) controlMask)      -- control + <key>
     [ (xK_z, killBefore)               -- kill line backwards
     , (xK_k, killAfter)                -- kill line forwards
     , (xK_a, startOfLine)              -- move to the beginning of the line
     , (xK_e, endOfLine)                -- move to the end of the line
     , (xK_m, deleteString Next)        -- delete a character foward
     , (xK_b, moveCursor Prev)          -- move cursor forward
     , (xK_f, moveCursor Next)          -- move cursor backward
     , (xK_BackSpace, killWord Prev)    -- kill the previous word
     , (xK_y, pasteString)              -- paste a string
     , (xK_g, quit)                     -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) altMask)          -- meta key + <key>
     [ (xK_BackSpace, killWord Prev)    -- kill the prev word
     , (xK_f, moveWord Next)            -- move a word forward
     , (xK_b, moveWord Prev)            -- move a word backward
     , (xK_d, killWord Next)            -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

-- Search Engines

archwiki :: S.SearchEngine
archwiki = S.searchEngine "Arch Wiki" "https://wiki.archlinux.org/index.php?search="

stack :: S.SearchEngine
stack = S.searchEngine "StackOverflow" "https://stackoverflow.com/search?q="

sndev :: S.SearchEngine
sndev = S.searchEngine "ServiceNow Developer" "https://developer.servicenow.com/dev.do#!/search/quebec/Reference/"

sncomm :: S.SearchEngine
sncomm = S.searchEngine "ServiceNow Community" "https://community.servicenow.com/community?id=community_search&q="

-- List of search engines to use.
searchList :: [(KeySym, S.SearchEngine)]
searchList =    [ (xK_a, archwiki)
                , (xK_c, sncomm)
                , (xK_d, S.duckduckgo)
                , (xK_g, S.google)
                , (xK_o, stack)
                , (xK_s, sndev)
                , (xK_y, S.youtube)
                , (xK_z, S.amazon)
                ]

-- Key Bindings

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Xmonad
    [ ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))                      -- Quit xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")   -- Restart xmonad

    -- Window Navigation
    , ((modm .|. shiftMask  , xK_c     ), kill)                                 -- Close focused window
    --, ((modm                , xK_a     ), killAll)                              -- Closes all windows in workspace
    , ((modm,                 xK_Tab   ), windows W.focusDown)                  -- Move focus to the next window
    , ((modm,                 xK_j     ), windows W.focusDown)                  -- Move focus to the next window
    , ((modm,                 xK_k     ), windows W.focusUp  )                  -- Move focus to the previous window
    , ((modm,                 xK_m     ), windows W.focusMaster  )              -- Move focus to the master window
    , ((modm,                 xK_Return), windows W.swapMaster)                 -- Swap the focused window and the master window
    , ((modm .|. shiftMask  , xK_j     ), windows W.swapDown  )                 -- Swap the focused window with the next window
    , ((modm .|. shiftMask  , xK_k     ), windows W.swapUp    )                 -- Swap the focused window with the previous window
    , ((modm,                 xK_h     ), sendMessage Shrink)                   -- Shrink the master area
    , ((modm,                 xK_l     ), sendMessage Expand)                   -- Expand the master area
    , ((modm                , xK_comma ), sendMessage (IncMasterN 1))           -- Increment the number of windows in the master area
    , ((modm                , xK_period), sendMessage (IncMasterN (-1)))        -- Deincrement the number of windows in the master area

    -- Screen Navigation
    , ((modm .|. controlMask, xK_j     ), nextScreen)                           -- Move focus to next screen
    , ((modm .|. controlMask, xK_k     ), prevScreen)                           -- Move focus to previous screen

    -- Layouts
    , ((modm,                 xK_t     ), withFocused $ windows . W.sink)       -- Push window back into tiling
    , ((modm,                 xK_space ), sendMessage NextLayout)               -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask  , xK_space ), setLayout $ XMonad.layoutHook conf)   -- Reset the layouts on the current workspace to default
    , ((modm,                 xK_n     ), refresh)                              -- Resize viewed windows to the correct size

    -- Prompts 
    , ((modm                , xK_p     ), shellPrompt znXPConfig)               -- Launch shellPrompt. Can replace 'demnu'
    , ((modm .|. controlMask, xK_x     ), xmonadPrompt znXPConfig)              -- Launch xmonadPrompt
    , ((modm .|. shiftMask  , xK_p     ), spawn "gmrun")                        -- Launch gmrun
    --, ((modm,                 xK_p     ), spawn "dmenu_run")                  -- Launch dmenu. Replaced by shell prompt

    -- Lock Screen
    , ((modm .|. controlMask, xK_l     ), spawn "slock")                        -- Start 'slock.' Locks the current screen

    -- Other Useful Programs
    , ((modm .|. shiftMask  , xK_Return), spawn $ XMonad.terminal conf)         -- Launch a terminal
    , ((modm                , xK_b     ), spawn myBrowser)                      -- Launches my browser

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    --
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- Run search engine prompt
    --
    [((modm .|. controlMask, k), S.promptSearch znXPConfig' f) 
        | (k, f) <- searchList ]

-- Mouse Bindings

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Layouts

--myLayout = avoidStruts (renamed [Replace "tall"] tiled ||| renamed [Replace "full"] Full)
myLayout = avoidStruts (tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = spacing mySpacing $ Tall nmaster delta ratio 

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- showWName theme
myShowWNameTheme = def
        { swn_font      = "xft:Ubuntu:bold:size=60"
        , swn_fade      = 1.0
        , swn_bgcolor   = "#1c1f24"
        , swn_color     = "#ffffff"
        }

-- Window Rules

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Event Handling

myEventHook = mempty

-- Status Bars and Logging

myLogHook h k = dynamicLogWithPP $ def
        { ppOutput = \x -> hPutStrLn h x >> hPutStrLn k x     -- Output workspaces to xmobar
        , ppCurrent = xmobarColor "#d65d0e" "" . wrap "[" "]" -- Active workspace in xmobar
        , ppVisible = xmobarColor "#fabd2f" ""                -- On screen, but not active workspace
        , ppHidden = xmobarColor "#458588" "" . wrap "*" ""   -- Not active/on screen, but has open windows
        , ppHiddenNoWindows = xmobarColor "#b16286" ""        -- Not active/on screen and has no open windows
        , ppTitle = xmobarColor "#fbf1c7" "" . shorten 60     -- Title of active window in xmobar
        , ppSep =  " | "          			      -- Separators in xmobar
        , ppUrgent = xmobarColor "#cc241d" "" . wrap "!" "!"  -- Urgent workspace
        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]	      -- Order of items displayed.
        }

-- Startup Hook

myStartupHook = do
        spawnOnce "nitrogen --restore &"                -- Start nitrogen
        spawnOnce "picom &"                             -- Start picom
        spawnOnce "xautolock -time 15 -locker slock &"  -- Autolock after 15 minutes
        spawnOnce "colctl --mode coveringmarquee --text_color 255,0,255 --color0 255,0,255 --color1 1,1,1 --color_count 2 --animation_speed 2"      -- Set color of NZXT Kraken

-- Main

main = do

    xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc.hs" -- Pass config to xmobar for monitor 0
    xmproc1 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/xmobarrc.hs" -- Pass config to xmobar for monitor 1 
    xmonad $ docks $ def {

    -- Config
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

    -- Bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

    -- Hooks, Layouts
        layoutHook         = showWName' myShowWNameTheme $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook xmproc0 xmproc1, 
        startupHook        = myStartupHook
    } --`additionalKeysP` myKeys

-- Help

help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
