module Junta.Workflow where

-- | Stub phase, that only has a name
data Phase = Phase { name :: String } deriving Show

-- Monad is used for nesting and sequencing phases
