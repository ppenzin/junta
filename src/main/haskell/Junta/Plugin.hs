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
    -- * Classes
    -- ** A build plugin
    BuildPlugin
) where

class BuildPlugin b where
    buildGoals :: b -> [String]
    buildPhase :: b -> String -> String
