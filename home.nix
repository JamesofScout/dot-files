
{ config, pkgs, services, ...} : {
  home.username = "florian";
  home.homeDirectory = "/home/florian";
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
  imports = [
    ./editor/intelij.nix
    ./editor/emacs.nix
    ./editor/codium.nix
    ./editor/nvim.nix
  ];

  home.stateVersion = "23.05";
  home.file."./.config/" = {
    source = ./.config;
    recursive = true;
    onChange = "${pkgs.eww-wayland}/bin/eww reload\n ${pkgs.hyprland}/bin/hyprctl reload";
  }; 

  programs.home-manager = {
    enable = true;
  };

  home.packages = with pkgs; [
    eww-wayland
    dolphin
    bash
    jq
    socat
    python3
    tmux
    dunst
    wcm
    waybar
    btop
    alacritty
    kanata
  ];

  # programs.thunderbird.enable = true;

  programs.fish.enable=true;
  programs.fish.loginShellInit="${pkgs.hyprland}/bin/Hyprland";
  programs.fish.interactiveShellInit="starship init fish | source";
  home.shellAliases = {
    ls = "lsd";
    gs = "git status";
    gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
  };

  systemd.user.services.kanata = {
    Unit.Description = "Kanata Keyboard Manager";
    Install.WantedBy=["default.target"];
    Service = {
      Restart="always";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg /home/florian/.config/kanata.kbd";
    };
  };
}
