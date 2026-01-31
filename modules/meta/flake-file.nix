{ inputs, ... }:
{
  flake-file = {
    description = "Nix configuration";
    inputs = {
      flake-file.url = "github:vic/flake-file";
      import-tree.url = "github:vic/import-tree";
    };
    outputs = ''
      inputs:
      inputs.flake-parts.lib.mkFlake { inherit inputs; }
        (inputs.import-tree ./modules)
    '';
  };

  imports = [ inputs.flake-file.flakeModules.default ];
}
