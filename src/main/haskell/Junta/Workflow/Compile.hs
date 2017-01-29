{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Compile phase. Build dependencies and the sources.

-}

module Junta.Workflow.Compile (doCompile) where

import Junta.BuildContext

-- | Perform Compile action
doCompile :: BuildContext -> IO BuildContext
doCompile c = print "TODO Compile" >> print c >> return c -- TODO

