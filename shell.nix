let
  grpc-haskell-src = builtins.fetchGit {
    url = https://github.com/awakesecurity/gRPC-haskell;
    rev = "112777023f475ddd752c954056e679fbca0baa44";
  };
  grpc-haskell = import "${grpc-haskell-src}/release.nix";
  pkgs = import nix/nixpkgs.nix { overlays = [ grpc-haskell.overlay ]; };

in pkgs.mkShell {
  packages = [
    pkgs.coreutils
    pkgs.grpc
    pkgs.zlib
    pkgs.ghcid
    pkgs.haskell.compiler.ghc923
    pkgs.haskellPackages.cabal-install
  ];
}
