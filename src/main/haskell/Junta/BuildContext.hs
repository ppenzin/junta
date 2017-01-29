{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Build context data type

-}

module Junta.BuildContext where

import Junta.ProjectConfiguration

-- | Build context
--   TODO add dependencies and other information
data BuildContext = BuildContext { configuration :: ProjectConfiguration
                                 , compiler :: String 
                                 , sourceDirectories :: [String]
                                 } deriving Show
