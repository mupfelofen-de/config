#! /usr/bin/env zsh

rm -rf ~/.cabal/{bin,lib,setup-exe-cache,share} ~/.ghc/*-linux-*
cabal install world
