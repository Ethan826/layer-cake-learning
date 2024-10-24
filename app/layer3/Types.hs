{-# LANGUAGE DeriveGeneric #-}

module Types where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data User = User
  { name :: String
  , age :: Int
  }
  deriving (Show, Generic)

instance FromJSON User
instance ToJSON User

data Summary = Summary
  { totalUsers :: Int
  , averageAge :: Double
  }
  deriving (Show, Generic)

instance ToJSON Summary