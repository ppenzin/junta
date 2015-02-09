{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Module to hold plugin class

To be moved to a separate package, so both Junta and plugins can depend on it.
-}
module Junta.Plugin (
    -- * Data types
    -- ** A build plugin
    BuildPlugin
) where

data BuildPlugin = BuildPlugin {
    buildGoals :: [String],
    buildPhase :: String -> String
}
