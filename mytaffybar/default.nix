{ mkDerivation, base, stdenv, taffybar }:
mkDerivation {
  pname = "mytaffybar";
  version = "0.1.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base taffybar ];
  description = "Taffybar configuration";
  license = stdenv.lib.licenses.unfree;
}
