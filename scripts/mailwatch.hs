-- |
-- Copyright:  (c) 2017 Intelego GmbH
-- License:    BSD3
-- Maintainer: Ertugrul Söylemez <erso@intelego.net>

module Main (main) where

import Control.Applicative
import Control.Concurrent
import Control.Concurrent.STM
import Control.Exception
import Control.Monad
import Control.Monad.Codensity
import Control.Monad.IO.Class
import Data.Foldable
import GHC.Event
import System.Environment
import System.FSNotify
import System.Process
import Text.Regex.TDFA hiding (empty)


data EvState
    = NoEvent
    | Requested
    | Pending
    | Executing
    deriving (Bounded, Enum, Eq, Ord, Show)

instance Monoid EvState where
    mappend = max
    mempty = minBound


main :: IO ()
main = lowerCodensity $ do
    mgr <-
        let cfg = WatchConfig {
                    confDebounce = NoDebounce,
                    confPollInterval = 60000000,
                    confUsePolling = False
                  }
        in Codensity (withManagerConf cfg)
    evVar <- liftIO (newTVarIO mempty)
    execVar <- liftIO (newTVarIO False)

    let handleEv ev =
            when (eventPath ev =~ "(^|/)(cur|new)/")
                 (atomically (modifyTVar' evVar (mappend Requested)))

    liftIO getArgs >>= traverse_ (\fp ->
        Codensity $
            bracket (watchTree mgr fp (const True) handleEv) id)

    liftIO (callProcess "notmuch" ["new"])
    tmgr <- liftIO getSystemTimerManager
    liftIO . forever . join . atomically $ do
        ev <- readTVar evVar
        case ev of
          NoEvent -> empty
          Requested -> do
              readTVar execVar >>= check . not
              writeTVar evVar Pending
              pure . (() <$) . registerTimeout tmgr 1000000 $
                  atomically (modifyTVar' evVar (mappend Executing))
          Pending -> empty
          Executing -> do
              writeTVar evVar NoEvent
              writeTVar execVar True
              pure $ do
                  callProcess "notmuch" ["new"]
                  threadDelay 1000000
                  atomically (writeTVar execVar False)
