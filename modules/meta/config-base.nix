{ self, ... }:
let
  common = {
    system.configurationRevision = self.rev or self.dirtyRev or null;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
in
{
  flake.modules.nixos.config-base = {
    imports = [ common ];
    system.stateVersion = "25.11";
  };

  flake.modules.darwin.config-base = {
    imports = [ common ];
    system.stateVersion = 6;
  };

  flake.modules.homeManager.config-base = {
    home.stateVersion = "25.11";
  };
}
