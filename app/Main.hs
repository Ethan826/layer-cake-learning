module Main where

import AppEnv (getAppEnv)
import AppLogic (app)
import AppM (runAppM)
import Control.Monad.Except (runExceptT)
import System.Exit (exitFailure)

main :: IO ()
main = do
  env <- getAppEnv
  result <- runAppM env (runExceptT app)
  case result of
    Left err -> do
      putStrLn ("Error: " ++ err)
      exitFailure
    Right _ -> putStrLn "Application ran successfully"
