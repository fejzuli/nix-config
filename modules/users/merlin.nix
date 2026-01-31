{ self, ... }:
let
  username = "merlin";
  fullName = "Merlin Attila Fejzuli";
  email = "merlin@fejzuli.com";
in
{
  flake.modules.nixos.merlib = {
    users.users.merlin = {
      isNormalUser = true;
      description = fullName;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  flake.modules.darwin.merlin = {
    users.users.merlin = {
      description = fullName;
      home = "/Users/${username}";
    };
  };

  flake.modules.homeManager.merlin = { mkHomePath, ... }: {
    imports = [
      self.modules.homeManager.terminal
    ];

    home = {
      inherit username;
      homeDirectory = mkHomePath username;
    };

    programs.git.settings = {
      user = {
        inherit email;
        name = fullName;
      };
      init.defaultBranch = "main";
    };
  };
}
