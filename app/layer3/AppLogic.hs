{-# LANGUAGE FlexibleContexts #-}

module AppLogic (app) where

import BusinessLogic (generateSummary)
import Capabilities (
  HasFilePaths (
    getInputFile,
    getOutputFile
  ),
  HasFileSystem (getFileSystem),
  HasJsonParser (getJsonParser),
 )
import Control.Monad.Except (MonadError)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Reader (MonadReader, asks)
import Data.Aeson (encode)
import Effects (
  FileSystem (readFileContents, writeFileContents),
  JsonParser (parseJson),
 )

app ::
  ( MonadReader env m
  , MonadIO m
  , MonadError String m
  , HasFileSystem env
  , HasJsonParser env
  , HasFilePaths env
  ) =>
  m ()
app = do
  fileSystem <- asks getFileSystem
  jsonParser <- asks getJsonParser
  inputPath <- asks getInputFile
  outputPath <- asks getOutputFile
  contents <- liftIO $ readFileContents fileSystem inputPath
  users <- liftIO $ parseJson jsonParser contents
  let summary = generateSummary users
  liftIO $ writeFileContents fileSystem outputPath (encode summary)
