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

main = defaultMain unitTests

unitTests :: TestTree
unitTests = testGroup "Unit tests"
  [ goalTests
  , phaseTests
  ]

goalTests :: TestTree
goalTests = testGroup "Goal tests"
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


phaseTests :: TestTree
phaseTests = testGroup "Phase tests"
  [ whenPhaseGoalsPassPhasePassesToo
  , whenTwoPhaseGoalsFailTheFirstOneBreaksThePhase
  ]

whenPhaseGoalsPassPhasePassesToo = testCase "Happy path with all phase goals passing" $ assertFailure "Unimplemented"
whenTwoPhaseGoalsFailTheFirstOneBreaksThePhase = testCase "Fail two goals, expect first failure as result" $ assertFailure "Unimplemented"
