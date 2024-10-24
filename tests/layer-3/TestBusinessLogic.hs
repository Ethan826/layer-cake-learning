{-# LANGUAGE OverloadedStrings #-}

module TestBusinessLogic where

import BusinessLogic (generateSummary)
import DataTypes (Summary (..), User (..))
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "generateSummary" $ do
    it "returns zero totalUsers and averageAge for empty user list" $ do
      let users = []
      let expected = Summary{totalUsers = 0, averageAge = 0.0}
      generateSummary users `shouldBe` expected

    it "calculates totalUsers and averageAge correctly for a list of users" $ do
      let users =
            [ User "Alice" 30
            , User "Bob" 40
            , User "Charlie" 35
            ]
      let expected = Summary{totalUsers = 3, averageAge = 35.0}
      generateSummary users `shouldBe` expected

    it "handles users with zero and high ages correctly" $ do
      let users =
            [ User "Baby" 0
            , User "Old Joe" 100
            ]
      let expected = Summary{totalUsers = 2, averageAge = 50.0}
      generateSummary users `shouldBe` expected