{
  inputs.pynixenv.url = "/home/ercanar/dev/pynixenv";

  outputs = { nixpkgs, flake-utils, pynixenv, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python311;
        pyenv = python.withPackages (p: with p; [
          black
          ipython
          matplotlib
          pynixenv.packages.${system}.default
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ pyenv ];
        };
      });
}
