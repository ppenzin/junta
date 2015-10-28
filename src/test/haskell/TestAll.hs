{-# LANGUAGE DeriveDataTypeable #-}
import Prelude hiding (catch)
import System.IO.Error hiding (catch)
import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Control.Exception
import Data.Typeable
import Data.Maybe

import Junta.Core

isRight :: Either a b -> Bool
isRight (Right a) = True
isRight _         = False

data DummyException = Foo | Bar
  deriving (Show, Typeable)

instance Exception DummyException

main = defaultMain unitTests

-- | Helper function to fail on exceptions
acceptNoError :: SomeException -> Assertion
acceptNoError e = assertFailure ("Unexpected error: " ++ show e)

-- | Helper function to expect a build error with a particular error message
expectErrorMessage :: String -> BuildException -> Assertion
expectErrorMessage msg e = ((message e) @?= msg)

-- | Test root
unitTests :: TestTree
unitTests = testGroup "Unit tests"
  [ goalTests
  , phaseTests
  , buildTests
  ]

-- | Tests for build goals
goalTests :: TestTree
goalTests = testGroup "Goal tests"
  [ testGoalFail
  , testGoalPass
  ]

testGoalFail = testCase "Run goal and fail" $ runBuild (Goal (throw Foo)) `catch` (expectErrorMessage "Foo")
testGoalPass = testCase "Run goal and pass " $ runBuild (Goal (return ())) `catch` acceptNoError

-- | Tests for build phases
phaseTests :: TestTree
phaseTests = testGroup "Phase tests"
  [ whenPhaseGoalsPassPhasePassesToo
  , whenTwoPhaseGoalsFailTheFirstOneBreaksThePhase
  ]

whenPhaseGoalsPassPhasePassesToo = testCase "Happy path with all phase goals passing" $ runBuild (Phase [happyGoalA, happyGoalB, happyGoalC]) `catch` acceptNoError
whenTwoPhaseGoalsFailTheFirstOneBreaksThePhase = testCase "Fail two goals, expect first failure as result" $ runBuild (Phase [happyGoalC, Goal (throw Foo), Goal (throw Bar)]) `catch` expectErrorMessage "Foo"

happyGoalA = Goal (return ())
happyGoalB = Goal (return ())
happyGoalC = Goal (return ())

-- | Tests for the whole build
buildTests :: TestTree
buildTests = testGroup "Build tests"
  [ whenPhaseFailsBuildFails
  , whenPhasesSucceedBuildSucceeds
  ]

whenPhasesSucceedBuildSucceeds = testCase "Happy path with all phases passing" $ runBuild (Build [Phase [happyGoalA, happyGoalB], Phase [happyGoalC]]) `catch` acceptNoError
whenPhaseFailsBuildFails = testCase "Fail two goals, expect first failure as result" $ runBuild (Build [Phase [happyGoalC], Phase[happyGoalA, Goal (throw Foo), Goal (throw Bar)]]) `catch` expectErrorMessage "Foo"
