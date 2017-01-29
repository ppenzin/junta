{- |
Module      :  $Header$
License     :  FreeBSD
Maintainer  :  penzin.dev@gmail.com
Stability   :  stable 
Portability :  portable

Build configuration that is read by the tool at startup

-}

module Junta.ProjectConfiguration where

import Control.Lens
import Data.Either
import Data.Map as M
import Data.Maybe
import Data.Yaml.YamlLight
import Data.Yaml.YamlLight.Lens
import Data.ByteString.Char8 as BS

-- | Build configuration
data ProjectConfiguration = ProjectConfiguration { _config_name :: String
                                                 , _config_version :: String 
                                                 } deriving (Show, Eq)

-- | Read Yaml to get instance of configuration
parseConfigYaml :: (Monad m) => YamlLight -> m ProjectConfiguration
parseConfigYaml m = getStr "name" m
               >>= \name -> getStr "version" m
               >>= \version -> return (ProjectConfiguration name version)

-- | Get a top level field from a Yaml map or fail
-- TODO hide
getStr :: (Monad m) => String -> YamlLight -> m String
getStr k ym =  if (isNothing y) then fail ("Field \"" ++ k ++ "\" not found") else return (fromJust y)
    where y = ym ^? key (BS.pack k) . _Yaml :: Maybe String

-- | Convert build configuration to and from Yaml
instance AsYaml ProjectConfiguration where
  fromYaml = parseConfigYaml
  toYaml c = YMap $ fromList [(YStr $ BS.pack $ "name", YStr $ BS.pack $ _config_name c), (YStr $ BS.pack $ "version", YStr $ BS.pack $ _config_version c)]
