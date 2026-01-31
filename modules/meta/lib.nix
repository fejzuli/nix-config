{ lib, inputs, self, withSystem, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = let
    injectPkgs = system: withSystem system ({ pkgs, pkgs-stable, ... }: {
      nixpkgs = { inherit pkgs; };
      _module.args = { inherit pkgs-stable; };
    });
  in {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          (injectPkgs system)
          self.modules.nixos.config-base
          self.modules.nixos.${name}
        ];
      };
    };

    mkDarwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          (injectPkgs system)
          self.modules.darwin.config-base
          self.modules.darwin.${name}
        ];
      };
    };
  };
}
