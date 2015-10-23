{-# LANGUAGE DeriveDataTypeable #-}
import Prelude hiding (catch)
import System.IO.Error hiding (catch)
import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Control.Exception
import Data.Typeable

import Junta.Core

isRight :: Either a b -> Bool
isRight (Right a) = True
isRight _         = False

data DummyException = Foo | Bar
  deriving (Show, Typeable)

instance Exception DummyException

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests]

unitTests = testGroup "Unit tests"
  [ testGoalFail
  , testGoalPass
  ]

testGoalFail = testCase "Run goal and fail" $ runGoal (Goal (throw Foo)) `catch` handleBuildError
    where handleBuildError e
              | isBuildException e = ((message e) @?= "Foo")
              | otherwise = assertFailure "Wrong exception type"

testGoalPass = testCase "Run goal and pass " $ runGoal (Goal (return ())) `catch` handleBuildError
    where handleBuildError :: SomeException -> Assertion
          handleBuildError _ = assertFailure "Unexpected error"


