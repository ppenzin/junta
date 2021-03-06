junta
============

[![Build Status](https://travis-ci.org/ppenzin/junta.svg?branch=master)](https://travis-ci.org/ppenzin/junta)

Build management tool based on conventions and standard work flows

This is an attempt to refresh the project a bit, in some sense starting over.
Build workflow should be re-imagined in terms of plugins and IO.

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
Tired of resolving the dependencies. This is the minimal (`alpha') version of
the tool, that is supposed to be only good for building the bigger version. 

The downside of that is that automated tests are now disabled and the tool will
be tested by building itself.

## Dependencies
- Cabal 1.20 or newer for sandboxes
- Haddock for documentation
- Libraries are listed in the cabal file

## Running a Build
First time:
```
cabal sandbox init
cabal install --only-dependencies
cabal configure
```
Then every time you need a build:
```
cabal build
```

[cabal]: http://ppenzin.github.io/2014/05/26/haskell-build-automation-cabal/
[alt]: http://ppenzin.github.io/2014/06/12/haskell-build-automation-alternatives/
