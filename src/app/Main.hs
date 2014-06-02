module Junta.Main where

import Data.Yaml
import Control.Applicative -- <$>, <*>
import Data.Maybe (fromJust)

import qualified Data.ByteString.Char8 as BS

main = do 
    print "Welcome to Junta"
