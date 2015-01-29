{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Junta.Juntafile ( ProjectConfig(..), Project(..), readConfig, parseConfigFromString ) where

import Data.Yaml
import Data.Aeson.TH
import Data.Maybe (fromJust)
import Control.Applicative -- <$>, <*>
import qualified Data.ByteString.Char8 as BS

import Junta.Juntafile.Check

{-| Project Configuration datatype
  | Contains information needed to build the project.
  | Not necessarily consistent with itself, needs checking.
 -}
data ProjectConfig = ProjectConfig {
                              schemaVersion :: String,
                              project :: Project
                                   } deriving (Show, Eq)

data Project = Project {
                  name :: String,
                  version :: String
                       } deriving (Show, Eq)

-- | Instance of FromJSON to read the configuration from a YAML file/string
$(deriveJSON defaultOptions ''ProjectConfig)
$(deriveJSON defaultOptions ''Project)


{-| Read config from a file
    Takes filename as an argument, returns a ProjectConfig or thorws an error
 -}
readConfig :: String -> IO ProjectConfig
readConfig path = BS.readFile path
         >>= (\ymlData -> return $ parseConfigFromString ymlData)

{-| Parse project config from a string
  | Takes a UTF-8 string as an input. Throws an error if the string cannot be
  | parsed or there are any issues with the read configuration.
 -}
parseConfigFromString :: BS.ByteString -> ProjectConfig
parseConfigFromString input = checkConfig $ fromJust $ (Data.Yaml.decode input :: Maybe ProjectConfig)