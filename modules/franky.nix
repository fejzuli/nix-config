{ self, ... }:
{
  flake.darwinConfigurations = self.lib.mkDarwin "aarch64-darwin" "franky";

  flake.modules.darwin.franky = {
    imports = [
      self.modules.darwin.terminal
      self.modules.darwin.merlin
      self.modules.darwin.home-manager
    ];

    networking.hostName = "franky";

    security.pam.services.sudo_local.touchIdAuth = true;

    home-manager.users.merlin = self.modules.homeManager.merlin;
  };
}
