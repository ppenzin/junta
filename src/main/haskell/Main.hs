{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Application's entry point
-}
module Main (main) where

import Junta.Juntafile
import Junta.Action
import System.Environment
import System.Process
import System.Exit

-- | Entry point
main :: IO ()
main = readConfig "JuntaOrg.yml"
       >>= \config -> getArgs
       >>= \args -> juntaAction config args
       >>  exit

{- * Helpful functions -}
-- ** Sucessfully terminate
exit = exitWith ExitSuccess
-- ** Terminate with `bad' exit status
abort = exitWith $ ExitFailure 8
