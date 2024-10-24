module BusinessLogic (generateSummary) where

import Types (Summary (..), User (..))

generateSummary :: [User] -> Summary
generateSummary users =
  Summary
    { totalUsers = total
    , averageAge = avgAge
    }
 where
  total = length users
  avgAge =
    if total == 0
      then 0
      else fromIntegral (sum (map age users)) / fromIntegral total