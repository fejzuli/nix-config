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

  flake.modules.nixos.home-manager = { pkgs, pkgs-stable, ... }: {
    imports = [
      (injectArgs {
        inherit pkgs-stable;
        mkHomePath = user: "/home/${user}";
      })
      common
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.backupCommand = "${pkgs.trashy}/bin/trashy";
  };

  flake.modules.darwin.home-manager = { pkgs-stable, ... }: {
    imports = [
      (injectArgs {
        inherit pkgs-stable;
        mkHomePath = user: "/Users/${user}";
      })
      common
      inputs.home-manager.darwinModules.home-manager
    ];

    home-manager.backupCommand = "/usr/bin/trash";
  };
}
