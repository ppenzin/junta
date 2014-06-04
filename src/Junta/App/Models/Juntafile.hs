{-# LANGUAGE OverloadedStrings #-}
module Junta.App.Models.Juntafile ( Juntafile ) where

import Data.Yaml
import Control.Applicative -- <$>, <*>

data Juntafile = Juntafile { version :: String } deriving Show

instance FromJSON Juntafile where 
    parseJSON (Object v) = Juntafile <$>
                           v .: "version"
    parseJSON _ = error "Cannot parse Juntafile from YAML"

