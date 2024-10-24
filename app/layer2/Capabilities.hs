{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Capabilities (
  HasCounter (..),
  HasFileSystem (..),
  HasJsonParser (..),
  HasFilePaths (..),
  Counter,
) where

import Data.IORef (IORef)
import Effects (FileSystem, JsonParser)

class HasFileSystem a where
  getFileSystem :: a -> FileSystem

class HasJsonParser a where
  getJsonParser :: a -> JsonParser

type Counter = IORef Int

class HasCounter a where
  getCounter :: a -> Counter

class HasFilePaths a where
  getInputFile :: a -> FilePath
  getOutputFile :: a -> FilePath