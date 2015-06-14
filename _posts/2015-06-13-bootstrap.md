---
layout: post
title:  "Bootstrapping"
date:   2015-06-13 22:44:23
comments: true
categories: [Dependency Hell, Scope Reduction, Roadmap]
---

Ironically, Cabal's "dependency hell" issue that this project is intended to
solve prevents it from building from time to time, so it would be wise to
reduce the scope and solve that problem first.

The plan is to have a few intermediate versions of the tool to bootstrap (or a
few intermediate versions of the project model for that matter). The first
feature to be implemented is dependency resolution supporting multiple
versions; after that test support can be added, then other features.

This incremental approach would allow Junta project to move forward without
having to implement a significant subset of functionality before any results
can be demonstrated.

