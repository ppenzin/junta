module Junta.ConfigReaderTest (configReaderTests) where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck as QC
import Data.ByteString.Char8

import Junta.Juntafile

configReaderTests = testGroup "Configuration Reader Tests" 
  [ testCase "Happy path read test" $
      parseConfigFromString happyPathInput @?= happyPathOutput
  ]

happyPathInput = pack "version: \"0.0.1\""
happyPathOutput = ProjectConfig { version = "0.0.1" }
