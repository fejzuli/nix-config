{ moduleWithSystem, ... }:
{
  flake-file.inputs = {
    nix-auth.url = "github:numtide/nix-auth";
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
