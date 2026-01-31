{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  perSystem =
    let
      config = {
        allowUnfree = true;
      };
    in
    { system, ... }:
    {
      _module.args = {
        pkgs = import inputs.nixpkgs { inherit system config; };
        pkgs-stable = import inputs.nixpkgs-stable { inherit system config; };
      };
    };
}
