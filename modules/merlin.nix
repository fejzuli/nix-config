{ self, ... }:
let
  description = "Merlin Attila Fejzuli";
in
{
  flake.modules.darwin.merlin = {
    users.users.merlin = {
      inherit description;
      home = "/Users/merlin";
    };
  };

  flake.modules.homeManager.merlin = { mkHome, ... }: {
    imports = [
      self.modules.homeManager.terminal
    ];
    home.homeDirectory = mkHome "merlin";
  };
}
