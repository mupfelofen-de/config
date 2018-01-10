{ pkgs ? import <nixpkgs> {} }:

let ghc = import ./ghc.nix { inherit pkgs; };
in pkgs.stdenv.mkDerivation {
    name = "ertes-scripts";
    src = ./.;
    buildInputs = [ghc];
}
