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
    kanata
  ];

  # programs.thunderbird.enable = true;

  programs.fish.enable=true;
  programs.fish.interactiveShellInit="starship init fish | source";
  home.shellAliases = {
    ls = "lsd";
    gs = "git status";
  };
  
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
    ];
  };

  systemd.user.services.kanata = {
    Unit.Description = "Kanata Keyboard Manager";
    Install.WantedBy=["default.target"];
    Service = {
      Restart="always";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg /home/florian/.config/home-manager/kanata.kbd";
    };
  };
}
