{- |
Module      :  $Header$
License     :  FreeBSD

Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Entry point to guide build execution, argument and configuration parsing
-}
module Junta.Action (juntaAction) where
   
import Junta.Juntafile

{- | Run build based on configuration and command line arguments
     Takes two arguments: project configuration and a list of command-line arguments 
 -}
juntaAction :: ProjectConfig -> [String] -> IO ()
juntaAction config args = putStrLn "TODO" >>
                          putStrLn "Arguments to junta:" >>
                          print args >>
                          putStrLn "Project configuration:" >>
                          print config

