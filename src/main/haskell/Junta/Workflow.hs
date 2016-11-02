{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Workflow abstractions

At the moment there is only one abstraction, phase (high-level unit of work,
such as "fetch dependencies", "build", "package", "deploy", etc). This is a
work in progress, exact meaning is not finalized yet.

Workflow should probably be : 

* pre-build (read config file, check for integrity)
* fetch (dependencies)
* build (dependencies and code)
* test 
* package (as Cabal project?)
* deploy (upload to hackage, etc)

-}

module Junta.Workflow (
                        Phase (..),
                        readPhase,
                        printPhase,
                        defaultWorkflow,
                        runBuild
                      ) where

import Junta.BuildContext
import Junta.Workflow.PreBuild
import Junta.Workflow.Fetch
import Junta.Workflow.Compile
import Junta.Workflow.Test

-- | Build phases
--   TODO those can be broken down further
data Phase = Fetch   -- ^ Fetch dependencies recursively
           | Compile -- ^ Build the project and dependencies
           | Test    -- ^ Run (unit) tests
           deriving Eq

-- | Get phase from its string representation
readPhase :: String -> Phase
readPhase "fetch"   = Fetch
readPhase "compile" = Compile
readPhase "test"    = Test
readPhase _         = error "Unrecognized phase" -- TODO exception

-- | Phase to string
printPhase :: Phase -> String
printPhase Fetch   = "fetch"
printPhase Compile = "compile"
printPhase Test    = "test"

-- | Default sequence of phases
defaultWorkflow :: [Phase]
defaultWorkflow =  [Fetch, Compile, Test]

-- | Select the part of default workflow that would be executed
getPhases :: [Phase] -> Phase -> [Phase]
getPhases [] _ = error "Target phase not found in the workflow" -- TODO internal error
getPhases (p:ps) t = if (p == t) then [p] else (p : getPhases ps t)

-- | Main entry for the phase pileline
runBuild :: Phase -> IO ()
runBuild targetPhase = preBuild >>= \c -> executePhases c ps
  where ps = getPhases defaultWorkflow targetPhase

-- | Run phase pipeline
executePhases :: BuildContext -> [Phase] -> IO ()
executePhases c (Fetch:ps) = doFetch c >>= \c' -> executePhases c' ps
executePhases c (Compile:ps) = doCompile c >>= \c' -> executePhases c' ps
executePhases c (Test:ps) = doTest c >>= \c' -> executePhases c' ps
executePhases _ [] = return ()
