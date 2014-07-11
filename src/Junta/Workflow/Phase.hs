-- |Phase module
module Junta.Workflow.Phase where
{-|
  * Phase module describes a simple phase implementation
  Phase is either a named phase, that has to have one prerequisite or nameless init phase.
  This way any pays depends on init either directly or via its prerquisites.
  When a phase is requested, its prerequisite is ran, which triggers the whole
  list down to init.
-}

data Phase = Init | NamedPhase { prereq :: Phase, name :: String}
