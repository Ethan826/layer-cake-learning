{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module AppM (
  AppEnv (..),
  AppM (..),
  runAppM,
  AppException (..),
) where

import Capabilities (
  Counter,
  HasFilePaths (..),
  HasFileSystem (..),
  HasJsonParser (..),
 )
import Control.Exception (Exception)
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Reader (MonadReader, ReaderT (..))
import Data.Typeable (Typeable)
import Effects (FileSystem, JsonParser)

-- | Application environment
data AppEnv = AppEnv
  { envFileSystem :: FileSystem
  , envJsonParser :: JsonParser
  , envCounter :: Counter
  , inputFile :: FilePath
  , outputFile :: FilePath
  }

-- | Application monad
newtype AppM a = AppM
  { unAppM :: ReaderT AppEnv IO a
  }
  deriving (Functor, Applicative, Monad, MonadReader AppEnv, MonadIO)

-- | Run the AppM monad
runAppM :: AppEnv -> AppM a -> IO a
runAppM env app = runReaderT (unAppM app) env

-- | Implementing the capabilities for AppEnv
instance HasFileSystem AppEnv where
  getFileSystem :: AppEnv -> FileSystem
  getFileSystem = envFileSystem

instance HasJsonParser AppEnv where
  getJsonParser :: AppEnv -> JsonParser
  getJsonParser = envJsonParser

instance HasFilePaths AppEnv where
  getInputFile :: AppEnv -> FilePath
  getInputFile = inputFile

  getOutputFile :: AppEnv -> FilePath
  getOutputFile = outputFile

newtype AppException = AppException String deriving (Show, Typeable)

instance Exception AppException