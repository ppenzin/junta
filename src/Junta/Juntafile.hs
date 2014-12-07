{-# LANGUAGE OverloadedStrings #-}
module Junta.Juntafile ( ProjectConfig, readConfig ) where

import Data.Yaml
import Data.Maybe (fromJust)
import Control.Applicative -- <$>, <*>
import qualified Data.ByteString.Char8 as BS

data ProjectConfig = ProjectConfig { version :: String } deriving Show

instance FromJSON ProjectConfig where 
    parseJSON (Object v) = ProjectConfig <$>
                           v .: "version"
    parseJSON _ = error "Cannot parse project configuration from YAML"


readConfig :: String -> IO ProjectConfig
readConfig path = BS.readFile path
         >>= (\ymlData -> return $ fromJust $ (Data.Yaml.decode ymlData :: Maybe ProjectConfig))

