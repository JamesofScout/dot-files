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
  ];

  home.stateVersion = "23.05";

  programs.home-manager = {
    enable = true;
  };

  home.packages = with pkgs; [
    eww-wayland
    dunst
    wcm
    waybar
    btop
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

  systemd.user.services.kanata = {
    Unit.Description = "Kanata Keyboard Manager";
    Install.WantedBy=["default.target"];
    Service = {
      Restart="always";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg /home/florian/.config/home-manager/kanata.kbd";
    };
  };
}
