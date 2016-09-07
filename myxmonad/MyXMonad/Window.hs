-- |
-- Module:     MyXMonad.Window
-- Copyright:  (c) 2016 Ertugrul Soeylemez
-- License:    BSD3
-- Maintainer: Ertugrul Soeylemez <esz@posteo.de>

module MyXMonad.Window
    ( -- * Window operations
      focusRandomWindow,
      scrMoveTo
    )
    where

import qualified XMonad.StackSet as W
import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import System.Random
import XMonad
import XMonad.Actions.FloatKeys


focusRandomWindow :: X ()
focusRandomWindow =
    gets (W.integrate' . W.stack . W.workspace . W.current . windowset) >>= \ws -> do
        w <- fmap (ws !!) (liftIO $ randomRIO (0, length ws - 1))
        windows (W.shiftMaster . W.focusWindow w)


scrMoveTo :: Rational -> Rational -> X ()
scrMoveTo x y =
    (() <$) . runMaybeT $ do
        scr <- lift (gets $ W.current . windowset)
        win <- MaybeT (return . fmap W.focus . W.stack . W.workspace $ scr)
        let Rectangle _ _ w h = screenRect . W.screenDetail $ scr
            x0 = round (x * fromIntegral (w - 3))
            y0 = round (y * fromIntegral (h - 27))
        lift (keysMoveWindowTo (x0, y0) (x, y) win)
