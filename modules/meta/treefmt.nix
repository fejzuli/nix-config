{ inputs, ... }:
{
  flake-file.inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    stylua = {
      enable = true;
      settings = {
        collapse_simple_statement = "Always";
        column_width = 80;
        indent_type = "Spaces";
      };
    };
  };
}
