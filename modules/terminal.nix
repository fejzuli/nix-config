{ ... }:
let
  common = {
    programs = {
      bash.enable = true;
      zsh.enable = true;
      fish.enable = true;
    };
  };
in
{
  flake.modules.nixos.terminal = {
    imports = [ common ];
  };

  flake.modules.darwin.terminal = {
    imports = [ common ];
  };

  flake.modules.homeManager.terminal =
    {
      config,
      pkgs,
      pkgs-stable,
      ...
    }:
    {
      imports = [ common ];

      home.packages = [
        pkgs.iosevka
      ];

      programs = {
        direnv = {
          enable = true;
          enableFishIntegration = true;
          nix-direnv.enable = true;
        };
        fd.enable = true;
        fzf.enable = true;
        git.enable = true;
        neovim = {
          enable = true;
          defaultEditor = true;
          extraPackages = [
            pkgs.imagemagick
            pkgs-stable.lua-language-server
            pkgs.nil
          ];
        };
        ripgrep.enable = true;
        wezterm.enable = true;
      };

      xdg.configFile."wezterm/wezterm.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/configs/wezterm.lua";

      xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/configs/nvim";
    };
}
