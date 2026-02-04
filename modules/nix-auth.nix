{ moduleWithSystem, ... }:
{
  flake-file.inputs.nix-auth = {
    url = "github:numtide/nix-auth";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-parts.follows = "flake-parts";
      treefmt-nix.follows = "treefmt-nix";
    };
  };

  flake.modules.homeManager.nix-auth = moduleWithSystem (
    { inputs', ... }:
    { lib, ... }:
    let
      package = inputs'.nix-auth.packages.default;
    in
    {
      home.packages = [ package ];

      programs.fish.interactiveShellInit = lib.mkAfter ''
        ${lib.getExe' package "nix-auth"} completion fish | source
      '';
    }
  );
}
