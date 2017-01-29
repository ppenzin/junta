{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Install phase. Install build artifacts in the local repository.

-}

module Junta.Workflow.Install (doInstall) where

import Junta.BuildContext

-- | Perform Install action
doInstall :: BuildContext -> IO BuildContext
doInstall c = print "TODO Install" >> return c -- TODO
