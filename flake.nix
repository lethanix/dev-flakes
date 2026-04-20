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
              buildinputs = with pkgs; [
                  git
              ];
            };

            elixir = pkgs.mkShell {
              buildinputs = with pkgs; [
                beam28packages.elixir_1_19
              ];

              shellHook = ''
                export ERL_AFLAGS="-kernel shell_history enabled"
                echo "Elixir $(elixir --version | tail -1) ready"
              '';
            };
        };
      });
}

