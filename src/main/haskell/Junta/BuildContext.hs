{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Build context data type

-}

module Junta.BuildContext where


-- | Build context
--   TODO add dependencies and other information
data BuildContext = BuildContext { projectName :: String }

