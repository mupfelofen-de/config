-- |
-- Module:     MyXMonad.Audio
-- Copyright:  (c) 2016 Ertugrul Soeylemez
-- License:    BSD3
-- Maintainer: Ertugrul Soeylemez <esz@posteo.de>

module MyXMonad.Audio
    ( -- * Mixer controls
      toggleMute,
      withVolume
    )
    where

import Control.Lens
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import Data.Ratio
import Sound.ALSA.Mixer


toggleMute :: String -> String -> (Bool -> Bool) -> IO ()
toggleMute mname cname f =
    withMixer mname $ \mixer ->
        void . runMaybeT $ do
            sw <-
                MaybeT (getControlByName mixer cname) >>=
                MaybeT . return . playback . switch
            withChans sw f


unitRange :: (Functor f, Profunctor p) => Integer -> Integer -> p Rational (f Rational) -> p Integer (f Integer)
unitRange x0 x1 =
    rmap (fmap (\y -> x0 + round (fromInteger r * clamp y))) .
    lmap (\x -> (x - x0) % r)

    where
    r     = x1 - x0
    clamp = min 1 . max 0


withChans :: PerChannel a -> (a -> a) -> MaybeT IO ()
withChans pch f =
    case channels pch of
      [] -> return ()
      chs@(ch1:_) ->
          if joined pch
            then MaybeT (getChannel ch1 pch) >>=
                 lift . setChannel ch1 pch . f
            else
                forM_ chs $ \ch ->
                    MaybeT (getChannel ch pch) >>=
                    lift . setChannel ch pch . f


withVolume :: String -> String -> (Rational -> Rational) -> IO ()
withVolume mname cname f =
    withMixer mname $ \mixer ->
        void . runMaybeT $ do
            vol <-
                MaybeT (getControlByName mixer cname) >>=
                MaybeT . return . playback . volume

            (x0, x1) <- lift (getRange vol)
            withChans (value vol) (unitRange x0 x1 %~ f)
