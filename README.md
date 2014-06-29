junta
============
Build management tool based on conventions and standard work flows

# About
## TL-DR
Build tool, based on the idea of conventions and standard work flows (that Maven
makes use of).

## Synopsis
Junta is an attempt to bring conventions and standard work flows to Haskell
builds. It is intended to be an alternative to Cabal  (hence the name).

## Motivation 
Cabal build process is [kludgy][cabal] and [there is not much alternatives to it][alt].

I think a Haskell build tool needs to strive for the same robustness that
Apache Maven provides.

Writing a Haskell/Cabal plugin for Maven or Gradle could be an option, but it
would be a comparably large effort and it would have to be done in Java or
Groovy (I wanted to show that Haskell is fit for such tasks).

# Building
## Dependencies
- Cabal 1.20 for sandboxes
- Haddock for documentation
- Libraries are listed in the cabal file

## Running a Build
There is a makefile that runs all cabal build steps in one go. Simply run
```
make
```
to build the project. 

[cabal]: http://ppenzin.github.io/2014/05/26/haskell-build-automation-cabal/
[alt]: http://ppenzin.github.io/2014/06/12/haskell-build-automation-alternatives/
