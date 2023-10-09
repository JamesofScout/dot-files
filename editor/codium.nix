{ pkgs, ...} : {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
    ];
    userSettings = {
      "editor.fontLigatures" = true;
      "git.confirmSync" = false;
      "terminal.integrated.fontLigatures" = true;      
    };
  };
}
