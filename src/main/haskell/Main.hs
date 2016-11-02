{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Application's entry point
-}
module Main (main) where

import System.Environment
import System.Exit

--import Junta.Core
import Junta.Workflow

-- | Entry point
main :: IO ()
main = getArgs >>= parse >> exit

-- | Argument parser
parse :: [String] -> IO ()
parse [] = printUsage
parse ps = runMain ps

-- | Execute build (separates entry point logistics)
runMain :: [String] -> IO ()
runMain []     = return ()
runMain (p:ps) = runBuild (readPhase p) >> runMain ps

-- | Pring usage
printUsage :: IO ()
printUsage = putStrLn "Usage: jnt [phase]"

exit = exitWith ExitSuccess
