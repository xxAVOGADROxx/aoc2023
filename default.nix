let
  pkgs = import <nixpkgs> { };
  compilerVersion = "ghc928";
  compiler = pkgs.haskell.packages."${compilerVersion}";
in
  compiler.developPackage {
    root = ./.;
    source-overrides = {
      named = builtins.fetchTarball
        "https://github.com/monadfix/named/archive/e684a00.tar.gz";
    };
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
        [ cabal-install
          ghcid
          stylish-haskell
          haskell-language-server
          hlint
          cabal-fmt
        ]);
  }
