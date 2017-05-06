module Main where

import Data.Foldable (foldl')
import System.Taffybar
import System.Taffybar.Battery
import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.Text.CPUMonitor
import System.Taffybar.Text.MemoryMonitor
import System.Taffybar.WindowSwitcher
import System.Taffybar.WorkspaceSwitcher


abbrevWs :: [a] -> [a]
abbrevWs [] = []
abbrevWs (x:xs) = x : foldl' (\_ y -> [y]) [] xs


main :: IO ()
main = do
    pager <- pagerNew pagerCfg
    taffybarMain (cfg pager)

    where
    cfg pager =
        defaultTaffybarConfig {
          barPosition  = Bottom,

          endWidgets   =
              [ textClockNew Nothing "%a %m-%d %T" 1,
                systrayNew,
                textBatteryNew "($time$)" 1,
                batteryBarNew defaultBatteryConfig 1,
                textMemoryMonitorNew "$rest$" 5,
                textCpuMonitorNew "$total$" 5 ],

          monitorNumber = 1,

          startWidgets =
              [ wspaceSwitcherNew pager,
                windowSwitcherNew pager ]
       }

    pagerCfg = defaultPagerConfig {
                 activeLayout     = const "",
                 activeWindow     = colorize "#fff" "#000" . shorten 300,
                 activeWorkspace  = colorize "#ff6" "#008",
                 emptyWorkspace   = const "",
                 hiddenWorkspace  = colorize "#999" "#000" . abbrevWs,
                 urgentWorkspace  = colorize "#f60" "#800",
                 visibleWorkspace = colorize "#ddd" "#000" . ('(' :) . (++ ")") . abbrevWs,
                 widgetSep        = " "
               }
