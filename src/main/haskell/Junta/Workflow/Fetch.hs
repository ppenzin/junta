{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Fetch phase. Download dependencies recursively and build a full dependency tree.

-}

module Junta.Workflow.Fetch (doFetch) where

import Junta.BuildContext

-- | Perform Fetch action
doFetch :: BuildContext -> IO BuildContext
doFetch c = print (projectName c) >> print "in Fetch" >> return c -- TODO
