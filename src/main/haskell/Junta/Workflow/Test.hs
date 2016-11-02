{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Test phase. Run unit tests from test subdirectories.

-}

module Junta.Workflow.Test (doTest) where

import Junta.BuildContext

-- | Perform Test action
doTest :: BuildContext -> IO BuildContext
doTest c = print (projectName c) >> print "in Test" >> return c -- TODO
