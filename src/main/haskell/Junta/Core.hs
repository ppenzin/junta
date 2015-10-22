{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Core abstractions: plugins, goals, phases. For now without mapping to user-accessible strings.

Every build action is, by nature, IO operation. Will use exception to abort execution.

-}
module Junta.Core where

import Control.Exception
import Data.Typeable

-- | Exception type
data BuildException = BuildException { message :: String {- ^ decriptive error message -}}
    deriving (Show, Typeable)

instance Exception BuildException

-- | Check if we got a build exception TODO do we need this here
isBuildException :: (Exception a) => a -> Bool
isBuildException ex = typeOf ex == typeOf (BuildException "Foo")

-- | A plugin, external part of the system that can do work and emit error messages
newtype Plugin = Plugin { pluginGoals :: [Goal] }

-- | A goal within a plugin
newtype Goal = Goal { action :: BuildStep }

-- | Build phase
newtype Phase = Phase { phaseGoals :: [Goal] }

-- | Build step -- a piece of IO
type BuildStep = IO ()

-- | A build ready to execute
newtype Build = Build { buildPhases :: [Phase] }

-- | Execute build TODO add a parameter to stop after particular phase
runBuild :: Build -> IO ()
runBuild = undefined

-- | Execute a single phase
runPhase :: Phase -> IO ()
runPhase = undefined

-- | Run a goal
runGoal :: Goal -> IO ()
runGoal g = handle (\ex -> throw (BuildException $ show (ex :: SomeException))) $ action g
