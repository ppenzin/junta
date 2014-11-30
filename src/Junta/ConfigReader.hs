module Junta.ConfigReader where

import Data.Yaml
import Data.Maybe (fromJust)

import qualified Data.ByteString.Char8 as BS

import Junta.Juntafile

readConfig :: String -> IO ProjectConfig
readConfig path = BS.readFile path
         >>= (\ymlData -> return $ fromJust $ (Data.Yaml.decode ymlData :: Maybe ProjectConfig))

