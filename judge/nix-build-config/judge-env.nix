{ 
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { inherit system; },
}:

let
  inherit (pkgs) buildEnv;

  gcc = import ../hydro-nix-channel/gccWithCache.nix { };
  php = pkgs.php.withExtensions ({ enabled, all }: [ ]);

in buildEnv {
  name = "judge-env";
  paths = [
    gcc
    php
  ] ++ (with pkgs; [
    go-judge
    coreutils
    bash
    diffutils
    nix
    zip
    unzip
    fpc
    gdb
    ghc
    rustc
    kotlin
    go
    nodejs
    esbuild
    openjdk_headless
    ruby
    mono
    python3Full
    pypy3
  ]) ++ (with pkgs.python3Packages; [
    pandas
    pytz
    dateutil
    six
    numpy
    tkinter
    pillow
  ]);
}
