{ inputs, ... }:
{
  flake-file = {
    description = "Nix configuration";
    inputs = {
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:vic/flake-file";
      import-tree.url = "github:vic/import-tree";

      nix-darwin = {
        url = "github:nix-darwin/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
    outputs = ''
      inputs:
      inputs.flake-parts.lib.mkFlake { inherit inputs; }
        (inputs.import-tree ./modules)
    '';
  };

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
  ];
}
