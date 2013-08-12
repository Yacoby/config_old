import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
--import XMonad.Hooks.EwmhDesktops
import System.IO

import XMonad.Hooks.SetWMName

floatPrograms = ["Gimp","skype","Do", "Tilda"]
myManageHook = composeAll $
    (className =? "Conky" --> doIgnore) : map (\name -> className =? name --> doFloat) floatPrograms 

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $ layoutHook defaultConfig
        --, handleEventHook = fullscreenEventHook

	    , startupHook = setWMName "LG3D"
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys` hotkeys

hotkeys = [
        ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
        ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
        ((0, xK_Print), spawn "scrot"),
        ((mod4Mask, xK_p), spawn "dmenu_run")
        ]
