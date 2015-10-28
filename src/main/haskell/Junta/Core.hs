{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Core abstractions: plugins, goals, phases. For now without mapping to user-accessible strings.

Every build action is, by nature, IO operation. Will use exception to abort execution.

-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ExistentialQuantification #-}

module Junta.Core where

import Control.Exception
import Data.Typeable

-- | Build typeclass
class BuildLifecycle a where
    runBuild :: a -> IO ()

-- | Build supertype
data BuildElement = forall a. BuildLifecycle a => BuildElement a
-- | Instance for the supertype
instance BuildLifecycle BuildElement where
    runBuild (BuildElement e) = runBuild e

-- | Exception type
data BuildException = BuildException { message :: String {- ^ decriptive error message -}}
    deriving (Show, Typeable)

-- | Default instance of exception
instance Exception BuildException

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

-- | Instance of build lifecycle for the build
instance BuildLifecycle Build where
    -- | Execute build
    runBuild b = (mapM_ runBuild (buildPhases b))
                       `catches` [Handler (\ (e :: BuildException) -> throw e                                              ),
                                  Handler (\ (e :: BuildException) -> throw (BuildException $ "Internal error: " ++ show e))]

-- | Instance of build lifecycle for a phase
instance BuildLifecycle Phase where
    -- | Execute a single phase
    runBuild p = (mapM_ runBuild (phaseGoals p))
                       `catches` [Handler (\ (e :: BuildException) -> throw e                                              ),
                                  Handler (\ (e :: BuildException) -> throw (BuildException $ "Internal error: " ++ show e))]

-- | Instance of build lifecycle for a goal
instance BuildLifecycle Goal where
    -- | Run a goal
    runBuild g = handle (\ex -> throw (BuildException $ show (ex :: SomeException))) $ action g
    
