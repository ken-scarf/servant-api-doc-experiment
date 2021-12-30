let
  pkgs = import <nixpkgs> {};
  src = pkgs.fetchFromGitHub {
    owner = "piq9117";
    repo = "ch-hs-imports";
    rev = "8740fe4a967bc32f10b7353482c4ed8ced79ee2c";
    sha256 = "0z6xp9wywkl1r1js9p33vg1rw9qwd8g108b2vgkgnx3djpxbimq2";
  };
in
import "${src}/release.nix"
