# flake.nix
{
  description = "Development shell environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = {
            default = pkgs.mkShell {
              name = "default";
              buildInputs = with pkgs; [
                  git
              ];
            };

            elixir = pkgs.mkShell {
              name = "potion";
              buildInputs = with pkgs; [
                beam28Packages.elixir_1_19
              ];

              shellHook = ''
                export ERL_AFLAGS="-kernel shell_history enabled"
                echo "Elixir $(elixir --version | tail -1) ready"
              '';
            };
        };
      });
}

