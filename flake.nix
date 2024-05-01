{
  outputs = { nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; }; in {
      packages.default = pkgs.python311Packages.buildPythonPackage {
        pname = "lmaofit";
        version = "1.0.0";
        src = ./.;
        pyproject = true;

        nativeBuildInputs = with pkgs.python311Packages; [
          poetry-core
        ];

        propagatedBuildInputs = with pkgs.python311Packages; [
          lmfit
          matplotlib
        ];
      };
    }) // {
    templates.default = {
      path = ./template;
      description = "";
    };
  };
}
