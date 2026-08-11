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
        formatter = pkgs.nixpkgs-fmt;
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

          bootdev = pkgs.mkShell {
            name = "boot.dev";
            buildInputs = with pkgs; [
              go
            ];

            shellHook = ''
              go install github.com/bootdotdev/bootdev@latest
              export PATH=$PATH:$HOME/go/bin
              echo "Environment ready"
              bootdev --version
            '';
          };

          golang = pkgs.mkShell {
            name = "go";
            buildInputs = with pkgs; [
              go
            ];

            shellHook = ''
              echo "Go environment ready"
              go version
            '';
          };
        };
      });
}

