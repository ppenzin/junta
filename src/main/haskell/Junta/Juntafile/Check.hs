{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Module to check project configuration for consistency
-}
module Junta.Juntafile.Check where

{-| Function to check the file: throws an error if something is wrong
 -}
checkConfig :: projectConfig -> projectConfig
checkConfig x = x -- pass through, for now
