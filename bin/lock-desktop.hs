-- |
-- Copyright:  (c) 2016 Ertugrul Söylemez
-- License:    BSD3
-- Maintainer: Ertugrul Söylemez <esz@posteo.de>

module Main (main) where

import Control.Concurrent
import Control.Concurrent.Async
import Control.Exception
import Control.Monad.Codensity
import Control.Monad.IO.Class
import Options.Applicative
import System.Directory
import System.FilePath
import System.Process


data Options =
    Options {
      _suspend      :: Maybe SuspendType,
      _suspendDelay :: Rational,
      _transparent  :: Bool
    }
    deriving (Eq, Ord, Show)


data SuspendType = SuspendToDisk | SuspendToRam
    deriving (Eq, Ord, Show)


options :: Parser Options
options =
    Options
    <$> option (eitherReader suspType)
            (long "suspend-type" <> short 's' <> metavar "TYPE" <> value Nothing <>
             help "Suspend type (\"disk\", \"none\" or \"ram\")")
    <*> option (fromInteger <$> auto <|> auto)
            (long "suspend-delay" <> short 'd' <> metavar "SECS" <> value 2 <>
             help "Suspend delay in seconds (default: 2)")
    <*> switch
            (long "transparent" <> short 't' <>
             help "Transparent lock screen")

    where
    suspType "disk" = Right (Just SuspendToDisk)
    suspType "none" = Right Nothing
    suspType "ram"  = Right (Just SuspendToRam)
    suspType _      = Left "Suspend type must be \"disk\", \"none\" or \"ram\""


main :: IO ()
main = do
    opts <- execParser (info (helper <*> options) mempty)
    homeDir <- getHomeDirectory

    let suspend t = do
            threadDelay (round (1000000 * _suspendDelay opts))
            putStrLn "Suspending"
            callProcess
                "systemctl"
                [case t of
                   SuspendToDisk -> "hibernate"
                   SuspendToRam  -> "suspend"]

    lowerCodensity $ do
        maybe (pure ())
              (\t -> Codensity $ \k ->
                         withAsync (suspend t) $ \res ->
                             k ()
                             `finally` (cancel res >> waitCatch res))
              (_suspend opts)

        liftIO $
             if _transparent opts
               then callProcess "xtrlock-pam" ["-b", "none"]
               else do
                   callProcess "feh"
                       ["--no-fehbg",
                        "--bg-center", homeDir </> "gfx" </> "bgr" </> "lock-screen" <.> "png"]
                   callProcess "xtrlock-pam" ["-b", "bg"]
                   callProcess (homeDir </> ".fehbg") []
