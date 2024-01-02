{
  description = "AWS Development Flake";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "aws-lethanix";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      with pkgs;
      {
        devShells.default = mkShell {
          inherit name;

          nativeBuildInputs = builtins.attrValues {
            inherit (pkgs)
              python3
              nodejs;
          };

          shellHook = ''
            echo "Installing aws-organization-formation"
            npm install aws-organization-formation
            alias org-formation="npm exec -- aws-organization-formation"
          '';
        };
      }
    );
}
