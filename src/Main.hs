module Main (main) where

import Data.Yaml
import Data.Maybe (fromJust)

import qualified Data.ByteString.Char8 as BS

import Junta.App.Models.Juntafile

main :: IO ()
main = do
         ymlData <- BS.readFile "constrfile.yml"
         let juntafile = Data.Yaml.decode ymlData :: Maybe Juntafile
         print $ fromJust juntafile
{-
main = do 
    print "Welcome to Junta"
-}
