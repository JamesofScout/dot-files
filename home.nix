
{ config, pkgs, services, stylix, ...} : {
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
    ./theme.nix
    ./languages/rust.nix
  ];

  home.stateVersion = "23.05";
  home.file."./.config/" = {
    source = ./.config;
    recursive = true;
    # onChange = "${pkgs.eww-wayland}/bin/eww reload\n ${pkgs.hyprland}/bin/hyprctl reload";
  }; 

  programs.home-manager = {
    enable = true;
  };

  home.packages = with pkgs; [
    obsidian
    eww-wayland
    bash
    jq
    socat
    python3
    tmux
    dunst
    waybar
    btop
  ];


  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fenv";
        src = pkgs.fishPlugins.foreign-env;
      }
    ];
    shellInit =  "
      set -p fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d\n
      fenv source ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh > /dev/null
      ";
  };
  # programs.fish.loginShellInit="${pkgs.hyprland}/bin/Hyprland";
  home.shellAliases = {
    ls = "lsd";
    gs = "git status";
    gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
  };
}
