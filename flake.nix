{
  description = "protostar libraries";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.poetry.url = "github:nix-community/poetry2nix";

  inputs.source.url = "github:software-mansion/protostar/v0.9.1";
  inputs.source.flake = false;

  outputs = inputs @ { self, nixpkgs, flake-utils, poetry, source }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ poetry.overlay ]; };
        inherit (pkgs) poetry2nix;
      in
      rec {
        defaultPackage = pkgs.callPackage ./protostar.nix { inherit source; };
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            defaultPackage
          ];
        };
      }
    );
}
