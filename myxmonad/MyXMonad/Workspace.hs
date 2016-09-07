{-# LANGUAGE FlexibleContexts #-}

-- |
-- Module:     MyXMonad.Workspace
-- Copyright:  (c) 2016 Ertugrul Soeylemez
-- License:    BSD3
-- Maintainer: Ertugrul Soeylemez <esz@posteo.de>

module MyXMonad.Workspace
    ( -- * Workspace operations
      gotoGroup,
      gotoWS,
      shiftToGroup,
      shiftToWS
    )
    where

import qualified XMonad.StackSet as W
import Control.Monad
import Data.List
import Data.Maybe
import XMonad
import XMonad.Actions.DynamicWorkspaces


findGroup :: WorkspaceId -> X [WindowSpace]
findGroup gname = do
    let findWS f = gets (filter (\w -> gname == takeWhile (/= '-') (W.tag w)) . f . windowset)
    fmap concat . mapM findWS $
        [pure . W.workspace . W.current,
         W.hidden,
         map W.workspace . W.visible]


findGroup_ :: WorkspaceId -> X (Maybe WorkspaceId)
findGroup_ = fmap (fmap W.tag . listToMaybe) . findGroup


wsTag :: Int -> X WorkspaceId
wsTag n = do
    gname <- gets (takeWhile (/= '-') . W.currentTag . windowset)
    return (intercalate "-" [gname, show n])


gotoGroup :: WorkspaceId -> X ()
gotoGroup gname =
    findGroup_ gname >>=
    maybe (return ()) addWorkspace


gotoWS :: Int -> X ()
gotoWS = wsTag >=> addWorkspace


shiftToGroup :: WorkspaceId -> X ()
shiftToGroup =
    findGroup_ >=>
    maybe (return ()) (\w -> windows (W.shift w) >> addWorkspace w)


shiftToWS :: Int -> X ()
shiftToWS =
    wsTag >=> \w -> windows (W.shift w) >> addWorkspace w
