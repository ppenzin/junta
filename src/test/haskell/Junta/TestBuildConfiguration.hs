{-|
Module      : $Header$
Copyright   : (c) Petr Penzin, 2015
License     : BSD2
Maintainer  : penzin.dev@gmail.com
Stability   : stable
Portability : cross-platform

Test reading and writing build configuration

-}
-- module Junta.TestProjectConfiguration where 

import Junta.ProjectConfiguration

import Control.Applicative
import Control.Monad
import Data.ByteString.Char8 as B
import Data.Map
import Data.Yaml.YamlLight
import Test.Tasty
import Test.Tasty.SmallCheck as SC


-- We are trying to test what values return and fail methods are called whith
-- so we ca use this type
data Verifier a = Value a | Failure String
                  deriving (Show, Eq)

instance Monad Verifier where
  v >>= f = case v of 
             Failure s -> Failure s
             Value x -> f x
  return  = Value
  fail    = Failure

instance Applicative Verifier where
  pure = return
  (<*>) = ap

instance Functor Verifier where
  fmap = liftM

data TestStatus = Pass | Fail | Error
                  deriving (Show, Eq)

main = defaultMain tests

tests = testGroup "Test Build configuration"
  [ SC.testProperty "Banal read YAML test"
      ((parseConfigYaml (YMap (fromList [(YStr $ B.pack "name", YStr $ B.pack "a"), (YStr $ B.pack "version", YStr $ B.pack "1")])) :: Verifier ProjectConfiguration) == Value (ProjectConfiguration "a" "1"))
  , SC.testProperty "Missing \"version\" field"
      ((parseConfigYaml (YMap (fromList [(YStr $ B.pack "name", YStr $ B.pack "a")])) :: Verifier ProjectConfiguration) ==  Failure "Field \"version\" not found")
  , SC.testProperty "Missing \"name\" field"
      ((parseConfigYaml (YMap (fromList [(YStr $ B.pack "version", YStr $ B.pack "a")])) :: Verifier ProjectConfiguration) == Failure "Field \"name\" not found")
  , SC.testProperty "Empty input"
      ((parseConfigYaml (YMap (fromList [])) :: Verifier ProjectConfiguration) == Failure "Field \"name\" not found")
  ]
