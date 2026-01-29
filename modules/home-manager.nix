{ inputs, self, ... }:
let
  injectArgs = args: {
    home-manager.sharedModules = [{
      _module = { inherit args; };
    }];
  };

  common = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        self.modules.homeManager.config-base
      ];
    };
  };
in
{
  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake.modules.darwin.home-manager = { pkgs-stable, ... }: {
    imports = [
      (injectArgs {
        inherit pkgs-stable;
        mkHome = user: "/Users/${user}";
      })
      common
      inputs.home-manager.darwinModules.home-manager
    ];

    home-manager.backupCommand = "/usr/bin/trash";
  };
}
