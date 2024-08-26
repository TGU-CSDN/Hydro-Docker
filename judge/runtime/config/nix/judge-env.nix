{ 
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { inherit system; },
  hydro ? import <hydro> { inherit system; }
}:

let
  inherit (pkgs) buildEnv;

in buildEnv {
  name = "judge-env";
  paths = [ hydro.judge pkgs.go-judge ];
  postBuild = ''
    ln -sf $out/bin/go-judge /usr/local/bin/hydro-sandbox
  '';
}
