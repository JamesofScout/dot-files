{ pkgs, ...} : {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
    ];
    userSettings = {
      "editor.fontLigatures" = true;
    };
  };
}