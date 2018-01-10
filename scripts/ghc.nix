{ pkgs ? import <nixpkgs> {} }:

pkgs.haskellPackages.ghcWithPackages (hspkgs: with hspkgs; [
    async
    directory
    filepath
    fsnotify
    kan-extensions
    optparse-applicative
    process
    regex-tdfa
])
