module Build where

{-| High-level build description
 -}
data Build = Build {name :: String}

{-| High-level build runner class
 -}
class Builder a where
    build :: Build -> a
