{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Application's entry point
-}
module Main (main) where

--import Junta.Core
import Junta.Workflow

-- | Entry point
main :: IO ()
main = runBuild Compile
