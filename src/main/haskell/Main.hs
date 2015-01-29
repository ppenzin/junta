module Main (main) where

import Junta.Juntafile
import System.Environment
import System.Process
import System.Exit

main :: IO ()
main = readConfig "JuntaOrg.yml"
       >>= (\config -> getArgs)
       >>= parseArgs
       >>  exit

parseArgs _ = putStrLn "TODO, all broken" >> abort
exit = exitWith ExitSuccess
abort = exitWith $ ExitFailure 8
