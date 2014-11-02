import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
--import XMonad.Hooks.EwmhDesktops
import System.IO

import XMonad.Hooks.SetWMName

import XMonad.Layout.Cross
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders

floatPrograms = ["Gimp","skype","Do", "Tilda"]
myManageHook = composeAll $
    (className =? "Conky" --> doIgnore) : map (\name -> className =? name --> doFloat) floatPrograms 

-- | The available layouts.  Note that each layout is separated by |||, which
-- denotes layout choice.
layouts = tiled ||| Mirror tiled ||| noBorders Full ||| simpleCross ||| Grid
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myNormalBorderColor  = "#4e4e4e"
myFocusedBorderColor = "#8a8a8a"

myStartupHook :: X()
myStartupHook = setWMName "LG3D"

main = do
    xmproc <- spawnPipe "xmobar -x 0"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $ lessBorders OtherIndicated layouts,
        --, handleEventHook = fullscreenEventHook,
	    startupHook = myStartupHook,
        logHook = dynamicLogWithPP $ xmobarPP{
                        ppOutput = hPutStrLn xmproc,
                        ppTitle = xmobarColor "#859900" "" . shorten 50
        },
        modMask = mod4Mask,     -- Rebind Mod to the Windows key
        terminal = "gnome-terminal",

        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor
    } `additionalKeys` hotkeys

hotkeys = [
        ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
        ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
        ((0, xK_Print), spawn "scrot"),
        ((mod4Mask, xK_p), spawn "dmenu_run")
        ]
