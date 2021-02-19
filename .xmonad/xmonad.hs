------------------------------------------------------------------------
-- IMPORTS
------------------------------------------------------------------------

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

------------------------------------------------------------------------
-- CONFIG
------------------------------------------------------------------------

myFont :: String
myFont = "xft:Ubuntu Mono:size=12:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "alacritty"            -- Default terminal for xmonad

myModMask :: KeyMask
myModMask = mod4Mask                -- "Mod" key is set to super or windows key

myBrowser :: String
myBrowser = "qutebrowser "          -- Sets browser for tree select

myEditor :: String
myEditor = "vim"                    -- Sets editor for tree select

myBorderWidth :: Dimension
myBorderWidth = 2                   -- Side of border around windows

myNormalBorderColor :: String
myNormalBorderColor  = "#504945"    -- Border color for non-focused windows

myFocusedBorderColor :: String
myFocusedBorderColor = "#fbf1c7"    -- Border color for focused windows

altMask :: KeyMask
altMask = mod1Mask                  -- Used for xprompts

mySpacing :: Int
mySpacing = 10

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True          -- Whether focus follows the mouse pointer.

myClickJustFocuses :: Bool
myClickJustFocuses = False          -- Whether clicking on a window to focus also passes the click to the window

------------------------------------------------------------------------
-- WORKSPACES
------------------------------------------------------------------------

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["main","web","code","prod","test","dev"] 

------------------------------------------------------------------------
-- XPROMPT
------------------------------------------------------------------------

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
      -- , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 23
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , defaultPrompter     = id $ map toUpper  -- change prompt to UPPER
      -- , defaultPrompter     = unwords . map reverse . words  -- reverse the prompt
      -- , defaultPrompter     = drop 5 .id (++ "XXXX: ")  -- drop first 5 chars of prompt and add XXXX:
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
znXPConfig' :: XPConfig
znXPConfig' = znXPConfig
      { autoComplete        = Nothing
      }

------------------------------------------------------------------------
-- XPROMPT KEYMAP
------------------------------------------------------------------------

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

------------------------------------------------------------------------
-- SEARCH ENGINES
------------------------------------------------------------------------

archwiki :: S.SearchEngine

archwiki = S.searchEngine "Arch Wiki" "https://wiki.archlinux.org/index.php?search="
stack = S.searchEngine "StackOverflow" "https://stackoverflow.com/search?q="
sndev = S.searchEngine "ServiceNow Developer" "https://developer.servicenow.com/dev.do#!/search/quebec/Reference/"
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

------------------------------------------------------------------------
-- KEY BINDINGS
------------------------------------------------------------------------

-- Key bindings. Add, modify or remove key bindings here.
-- TODO: Change key maping to "easy" style. See XMonad.Util.EZConfig
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask  , xK_Return), spawn $ XMonad.terminal conf)         -- launch a terminal
    , ((modm,                 xK_p     ), spawn "dmenu_run")                    -- launch dmenu
    , ((modm .|. shiftMask  , xK_p     ), spawn "gmrun")                        -- launch gmrun
    , ((modm .|. shiftMask  , xK_c     ), kill)                                 -- close focused window
    , ((modm,                 xK_space ), sendMessage NextLayout)               -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask  , xK_space ), setLayout $ XMonad.layoutHook conf)   -- Reset the layouts on the current workspace to default
    , ((modm,                 xK_n     ), refresh)                              -- Resize viewed windows to the correct size
    , ((modm,                 xK_Tab   ), windows W.focusDown)                  -- Move focus to the next window
    , ((modm,                 xK_j     ), windows W.focusDown)                  -- Move focus to the next window
    , ((modm,                 xK_k     ), windows W.focusUp  )                  -- Move focus to the previous window
    , ((modm,                 xK_m     ), windows W.focusMaster  )              -- Move focus to the master window
    , ((modm,                 xK_Return), windows W.swapMaster)                 -- Swap the focused window and the master window
    , ((modm .|. shiftMask  , xK_j     ), windows W.swapDown  )                 -- Swap the focused window with the next window
    , ((modm .|. shiftMask  , xK_k     ), windows W.swapUp    )                 -- Swap the focused window with the previous window
    , ((modm,                 xK_h     ), sendMessage Shrink)                   -- Shrink the master area
    , ((modm,                 xK_l     ), sendMessage Expand)                   -- Expand the master area
    , ((modm,                 xK_t     ), withFocused $ windows . W.sink)       -- Push window back into tiling
    , ((modm                , xK_comma ), sendMessage (IncMasterN 1))           -- Increment the number of windows in the master area
    , ((modm                , xK_period), sendMessage (IncMasterN (-1)))        -- Deincrement the number of windows in the master area
    , ((modm .|. controlMask, xK_x     ), xmonadPrompt znXPConfig)              -- Custom xmonadPrompt keymap
    , ((modm .|. controlMask, xK_p     ), shellPrompt znXPConfig)               -- Custom xmonadPrompt keymap
    , ((modm .|. controlMask, xK_l     ), spawn "slock")                        -- Custom xmonadPrompt keymap
    , ((modm .|. controlMask, xK_j     ), nextScreen)                           -- Move focus to next screen
    , ((modm .|. controlMask, xK_k     ), prevScreen)                           -- Move focus to previous screen

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    --
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))                      -- Quit xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")   -- Restart xmonad

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

    -- Search engine prompt
    -- TODO: Change to modm-s
    --
    [((modm .|. controlMask, k), S.promptSearch znXPConfig' f) 
        | (k, f) <- searchList ]

------------------------------------------------------------------------
-- MOUSE BINDINGS
------------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
--
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

------------------------------------------------------------------------
-- LAYOUTS
------------------------------------------------------------------------

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

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
	{ swn_font	= "xft:Ubuntu:bold:size=60"
	, swn_fade	= 1.0
	, swn_bgcolor	= "#1c1f24"
	, swn_color	= "#ffffff"
	}

------------------------------------------------------------------------
-- WINDOW RULES
------------------------------------------------------------------------

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- EVENT HANDLING
------------------------------------------------------------------------

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- STATUS BARS AND LOGGING
------------------------------------------------------------------------

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
myLogHook h k = dynamicLogWithPP $ def
	{ ppOutput = \x -> hPutStrLn h x >> hPutStrLn k x
        , ppCurrent = xmobarColor "#d65d0e" "" . wrap "[" "]" -- Current workspace in xmobar
	, ppVisible = xmobarColor "#fabd2f" ""                -- Visible but not current workspace
	, ppHidden = xmobarColor "#458588" "" . wrap "*" ""   -- Hidden workspaces in xmobar
	, ppHiddenNoWindows = xmobarColor "#b16286" ""        -- Hidden workspaces (no windows)
	, ppTitle = xmobarColor "#fbf1c7" "" . shorten 60     -- Title of active window in xmobar
	, ppSep =  " | "          			      -- Separators in xmobar
	, ppUrgent = xmobarColor "#cc241d" "" . wrap "!" "!"  -- Urgent workspace
	, ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]	      -- Order of items displayed.
	}

------------------------------------------------------------------------
-- STARTUP HOOK
------------------------------------------------------------------------

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
	spawnOnce "nitrogen --restore &"
	spawnOnce "picom &"
	spawnOnce "xautolock -time 15 -locker slock &"

------------------------------------------------------------------------
-- MAIN
------------------------------------------------------------------------

-- Now run xmonad with all the defaults we set up. Not using the 
-- the "defaults" variable so I can modify "logHook."

main = do

    xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc.hs"
    xmproc1 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/xmobarrc.hs"
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

------------------------------------------------------------------------
-- HELP
------------------------------------------------------------------------

-- | Finally, a copy of the default bindings in simple textual tabular format.
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
