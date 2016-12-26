{ pkgs ? import <nixpkgs> {} }:

let ghc = pkgs.haskellPackages.ghcWithPackages (hspkgs: with hspkgs; [
        async
        directory
        filepath
        optparse-applicative
        process
        kan-extensions
    ]);
in

pkgs.stdenv.mkDerivation {
    name = "ertes-scripts";
    src = ./.;
    buildInputs = [ghc];
}
