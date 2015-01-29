module Junta.Action (juntaAction) where
   
import Junta.Juntafile

juntaAction :: ProjectConfig -> [String] -> IO ()
juntaAction config args = putStrLn "TODO" >>
                          putStrLn "Arguments to junta:" >>
                          print args >>
                          putStrLn "Project configuration:" >>
                          print config

