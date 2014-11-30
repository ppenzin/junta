{-# LANGUAGE OverloadedStrings #-}
module Junta.Juntafile ( ProjectConfig ) where

import Data.Yaml
import Control.Applicative -- <$>, <*>

data ProjectConfig = ProjectConfig { version :: String } deriving Show

instance FromJSON ProjectConfig where 
    parseJSON (Object v) = ProjectConfig <$>
                           v .: "version"
    parseJSON _ = error "Cannot parse project configuration from YAML"

