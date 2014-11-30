module Main (main) where

import Junta.Juntafile
import Junta.ConfigReader

main :: IO ()
main = readConfig "JuntaOrg.yml"
       >>= (\config -> print $ config)
{-
main = do 
    print "Welcome to Junta"
-}
