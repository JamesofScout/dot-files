{ config, pkgs, services, ...} : {
  home.username = "florian";
  home.homeDirectory = "/home/florian";
  

  home.stateVersion = "23.05";

  programs.home-manager = {
    enable = true;
  };

  home.packages = with pkgs; [
    wcm
    waybar
    btop
    emacs
    alacritty
  ];

  # programs.thunderbird.enable = true;
          

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
    ];
  };

  services.kanata.enable = true;
}
