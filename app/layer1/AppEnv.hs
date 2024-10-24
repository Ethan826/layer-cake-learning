{-# LANGUAGE NamedFieldPuns #-}

module AppEnv (getAppEnv) where

import AppM (AppEnv (..))
import Data.Aeson (eitherDecode)
import qualified Data.ByteString.Lazy as B
import Data.IORef (newIORef)
import Effects (FileSystem (..), JsonParser (..))
import System.Environment (getArgs)
import Types (User)

-- File system setup
fileSystem :: FileSystem
fileSystem =
  FileSystem
    { readFileContents = B.readFile
    , writeFileContents = B.writeFile
    }

parseJson' :: B.ByteString -> IO [User]
parseJson' = either (fail . show) pure . eitherDecode

jsonParser :: JsonParser
jsonParser = JsonParser{parseJson = parseJson'}

getAppEnv :: IO AppEnv
getAppEnv = do
  args <- getArgs
  let inputPath = if not (null args) then head args else "input.json"
  let outputPath = if length args > 1 then args !! 1 else "summary.json"
  envCounter <- newIORef 0
  pure
    AppEnv
      { envFileSystem = fileSystem
      , envJsonParser = jsonParser
      , envCounter
      , inputFile = inputPath
      , outputFile = outputPath
      }
