{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Primitives for interacting with project configuration
-}
module Junta.Juntafile (
    -- * Types
    -- ** Full project configuration
    ProjectConfig(..),
    -- ** Project description
    Project(..),
    -- * Functions
    -- ** Read configuration from file
    readConfigFile,
) where

import Data.Yaml.YamlLight
import Data.Maybe (fromJust)
import Control.Applicative -- <$>, <*>
import qualified Data.ByteString.Char8 as BS

import Junta.Juntafile.Check

{-| Project Configuration datatype
    Contains information needed to build the project.
    Not necessarily consistent with itself, needs checking.
 -}
data ProjectConfig = ProjectConfig {
                              schemaVersion :: String,
                              project :: Project,
                              dependencies :: [Project]
                                   } deriving (Show, Eq)

data Project = Project {
                  name :: String,
                  version :: String
                       } deriving (Show, Eq)

{-| Read config from a file
    Takes filename as an argument, returns a ProjectConfig or thorws an error
 -}
readConfigFile :: String -> IO ProjectConfig
readConfigFile path = BS.readFile path
         >>= \rawYaml -> parseYamlBytes rawYaml 
         >>= \liteYaml -> return (parseConfig liteYaml)

{-| Parse project config from a preprocessed YamlLight object
  | Takes a YamlLight structure as an input. Throws an error if it
  | cannot be parsed or there are any issues with the read configuration.
 -}
parseConfig :: YamlLight -> ProjectConfig
parseConfig input = ProjectConfig { schemaVersion = s, project = p, dependencies = d}
                    where s = getFieldAsString "schemaVersion" input
                          p = parseProject $ getField "project" input
                          d = map parseProject (getFieldAsSeq "dependencies" input)

parseProject :: YamlLight -> Project
parseProject input = Project {name = n, version = v}
                     where n = getFieldAsString "name" input
                           v = getFieldAsString "version" input

getFieldAsString :: BS.ByteString -> YamlLight -> String
getFieldAsString fieldName yml = BS.unpack $ fromJust $ unStr $ getField fieldName yml

getFieldAsSeq :: BS.ByteString -> YamlLight -> [YamlLight]
getFieldAsSeq fieldName yml = fromJust $ unSeq $ getField fieldName yml

getField :: BS.ByteString -> YamlLight -> YamlLight
getField fieldName yml = fromJust $ lookupYL (YStr fieldName) yml
