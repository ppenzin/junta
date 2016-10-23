{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Pre-build actions. This is where the configuration file is parsed and the
configuration is potentially checked for consistency.

-}

module Junta.Workflow.PreBuild (preBuild) where

import Junta.BuildContext


-- | Pre-build action, returns build context if everything went well
preBuild :: IO (BuildContext)
preBuild = print "In preBuild" >> return (BuildContext "foobar")

