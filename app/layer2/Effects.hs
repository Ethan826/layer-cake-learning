module Effects (FileSystem (..), JsonParser (..)) where

import Data.ByteString.Lazy (ByteString)
import Types (User)

data FileSystem = FileSystem
  { readFileContents :: FilePath -> IO ByteString
  , writeFileContents :: FilePath -> ByteString -> IO ()
  }

data JsonParser = JsonParser
  { parseJson :: ByteString -> IO [User]
  }