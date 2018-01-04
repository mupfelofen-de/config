{-# LANGUAGE FlexibleContexts #-}

-- |
-- Module:     Main
-- Copyright:  (c) 2016 Ertugrul Soeylemez
-- License:    BSD3
-- Maintainer: Ertugrul Soeylemez <esz@posteo.de>

module Main where

import qualified XMonad.StackSet as W
import Control.Monad.State
import Data.Monoid
import MyXMonad.Audio
import MyXMonad.Window
import MyXMonad.Workspace
import System.Taffybar.Hooks.PagerHints
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.XSelection


main :: IO ()
main = xmonad (docks (cfg `additionalKeysP` myKeys))
    where
    myKeys =
        [ -- Switch workspaces
          ("M-<F1>", gotoGroup "work"),
          ("M-<F2>", gotoGroup "text"),
          ("M-<F3>", gotoGroup "chat"),
          ("M-<F4>", gotoGroup "free"),
          ("M-1",    gotoWS 1),
          ("M-2",    gotoWS 2),
          ("M-3",    gotoWS 3),
          ("M-4",    gotoWS 4),
          ("M-v",    toggleWS),

          -- Send windows to other workspaces
          ("M-S-<F1>", shiftToGroup "work"),
          ("M-S-<F2>", shiftToGroup "text"),
          ("M-S-<F3>", shiftToGroup "chat"),
          ("M-S-<F4>", shiftToGroup "free"),
          ("M-S-1",    shiftToWS 1),
          ("M-S-2",    shiftToWS 2),
          ("M-S-3",    shiftToWS 3),
          ("M-S-4",    shiftToWS 4),

          -- Layout
          ("M-<Down>",  sendMessage Expand),
          ("M-<Left>",  sendMessage (IncMasterN (-1))),
          ("M-<Right>", sendMessage (IncMasterN 1)),
          ("M-<Up>",    sendMessage Shrink),

          -- Window operations
          ("M-<Tab>",   windows W.focusDown),
          ("M-S-<Tab>", windows W.focusUp),
          ("M-^",       windows W.shiftMaster),
          ("M-S-^",     windows (W.focusDown . W.swapUp)),
          ("M-x",       kill),

          ("M-s r", focusRandomWindow),
          ("M-s f", withFocused float),
          ("M-s s", withFocused (windows . W.sink)),

          -- Screens
          ("M-<",        nextScreen),
          ("M-S-<",      shiftNextScreen),
          ("M-<Return>", swapNextScreen),

          ("M-o b", spawn "switch-display.sh beamer"),
          ("M-o f", spawn "switch-display.sh free"),
          ("M-o h", spawn "switch-display.sh home"),
          ("M-o m", spawn "switch-display.sh mobile"),
          ("M-o o", spawn "switch-display.sh"),
          ("M-o s", spawn "switch-display.sh single"),

          -- Lock
          ("M-l M-k", spawn "lock-desktop -t"),
          ("M-l M-l", spawn "lock-desktop"),
          ("M-l M-p", spawn "lock-desktop -s ram"),
          ("M-l M-.", spawn "lock-desktop -s disk"),

          -- Redshift
          ("M-<F9>",  spawn "redshift -O 2375"),
          ("M-<F10>", spawn "redshift -O 3750"),
          ("M-<F11>", spawn "redshift -O 5125"),
          ("M-<F12>", spawn "redshift -O 6500"),

          -- Applications
          ("M-c c", asks (terminal . config) >>= spawn),
          ("M-c e", spawn "emacsclient -c"),
          ("M-c f", spawn "palemoon"),
          ("M-c p", spawn "palemoon --private-window"),
          ("M-c s", addWorkspace "mail-1"),
          ("M-c t", spawn "mytaffybar"),
          ("M-c r", spawn "gmrun"),

          ("M-c S-f", safePromptSelection "palemoon"),

          ("M-<KP_Home>", scrMoveTo 0 0),   ("M-<KP_Up>",    scrMoveTo 0.5 0),   ("M-<KP_Page_Up>",   scrMoveTo 1 0),
          ("M-<KP_Left>", scrMoveTo 0 0.5), ("M-<KP_Begin>", scrMoveTo 0.5 0.5), ("M-<KP_Right>",     scrMoveTo 1 0.5),
          ("M-<KP_End>",  scrMoveTo 0 1),   ("M-<KP_Down>",  scrMoveTo 0.5 1),   ("M-<KP_Page_Down>", scrMoveTo 1 1),

          ("<Print>", spawn "scrot ~/tmp/scrshot/%Y-%m-%d-%H:%M:%S.png"),
          ("S-<Print>", spawn "scrot -u ~/tmp/scrshot/%Y-%m-%d-%H:%M:%S.png"),

          -- Misc
          ("C-M-q", restart "myxmonad" False),
          ("M-q",   restart "myxmonad" True),

          -- Multimedia
          ("<XF86AudioLowerVolume>",  liftIO $ withVolume "default" "Master" (subtract (1/32))),
          ("<XF86AudioMute>",         liftIO $ toggleMute "default" "Master" not),
          ("<XF86AudioPlay>",         spawn "mpc -q toggle"),
          ("<XF86AudioRaiseVolume>",  liftIO $ withVolume "default" "Master" (+ 1/32)),
          ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10"),
          ("<XF86MonBrightnessUp>",   spawn "xbacklight -inc 10"),
          ("M-m",                     spawn "urxvtc -e ncmpc"),
          ("M-.",                     spawn "mpc -q next"),
          ("M-,",                     spawn "mpc -q prev"),
          ("M--",                     spawn "mpc -q stop") ]

    cfg = myDef {
            -- Misc
            focusFollowsMouse = False,
            clickJustFocuses  = False,
            modMask           = mod4Mask,
            terminal          = "urxvtc",
            workspaces        = (++ ["mail-1"]) $ do
                n <- ["work", "text", "chat", "free"]
                i <- [1..4]
                return (n ++ "-" ++ show i),

            -- Hooks
            handleEventHook =
                handleEventHook myDef <>
                fullscreenEventHook,

            layoutHook =
                let reg = Tall 1 (1/100) (3/5) |||
                          Mirror (Tall 1 (1/100) (33/40)) |||
                          Full

                    -- im = let prop = Title "Gajim" `Or` Const False
                    --      in gridIM (1/5) prop |||
                    --         Full

                in avoidStruts .
                   smartBorders .
                   smartSpacing 1 $
                   reg,

            manageHook =
                (className =? "mpv"   --> doFloat) <>
                (className =? "URxvt" --> insertPosition Below Newer) <>
                (isFullscreen         --> doFullFloat) <>
                manageHook myDef,

            -- Appearance
            borderWidth        = 2,
            focusedBorderColor = "#f00",
            normalBorderColor  = "#000"
          }

    myDef = ewmh (pagerHints def)
