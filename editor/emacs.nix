{ pkgs, ...} :
{
  home.packages = with pkgs; [
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs:
      [ epkgs.tree-sitter
        epkgs.tree-sitter-langs
        epkgs.nix-mode]))
  ];
}