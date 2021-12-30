{ pkgs ? import ./nix/pinned.nix {} }:
let
  project = pkgs.haskellPackages.callPackage ./default.nix {};
in
pkgs.mkShell {
  name = "servant-api-doc";
  buildInputs = with pkgs; project.env.nativeBuildInputs ++ [
    ghcid
    cabal-install
    ghc
    ormolu
    (import ./nix/ch-hs-imports.nix)
    zlib
    lzma
  ];
}
