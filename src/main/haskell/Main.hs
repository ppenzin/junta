module Main (main) where

import Junta.Juntafile

main :: IO ()
main = readConfig "JuntaOrg.yml"
       >>= (\config -> print $ config)
{-
main = do 
    print "Welcome to Junta"
-}
