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

import Data.Yaml.YamlLight
import Data.Either
import Junta.BuildContext
import Junta.ProjectConfiguration

-- | Name of the file containing project configuration
-- Pathe relateve to root directory of a project
configFileName :: String
configFileName = "junta.yml"

-- | Pre-build action, returns build context if everything went well
preBuild :: IO (BuildContext)
preBuild = print "In preBuild"
        >> parseYamlFile configFileName
       >>= \yml -> parseConfigYaml yml
       >>= \bc -> return (BuildContext bc "ghc" ["src/main/haskell"])
-- | TODO check GHC version?

