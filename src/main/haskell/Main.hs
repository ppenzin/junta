module Main (main) where

import Junta.Juntafile
import Junta.Action
import System.Environment
import System.Process
import System.Exit

main :: IO ()
main = readConfig "JuntaOrg.yml"
       >>= \config -> getArgs
       >>= \args -> juntaAction config args
       >>  exit

{----- Helpful functions -----}
exit = exitWith ExitSuccess
abort = exitWith $ ExitFailure 8
