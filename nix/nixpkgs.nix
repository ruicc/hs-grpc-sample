nixpkgsArgs:
  import (builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/archive/879121648fe522b38cc1cf75aef160a14a1f2e7b.tar.gz";
    sha256 = "0sg8vnl5yms7c37wxrbhlkaqgj55ikw3r59xwpjjk2dmn2d2205j";
  }) nixpkgsArgs
