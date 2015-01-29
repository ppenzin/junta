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

-- Happy path test
happyPathInput = pack (
    "schemaVersion: \"" ++ aVersion ++ "\"\n" ++
    "project:\n  name: " ++ aName ++ "\n  version: \"" ++ aVersion ++ "\""
                      )
happyPathOutput =
    ProjectConfig {
        schemaVersion = aVersion,
        project = Project { name = aName, version = aVersion }
                  }
-- Happy path properties
aVersion = "0.0.1"
aName = "aProject"
