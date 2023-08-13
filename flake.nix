{
  description = "Home Manager configuration of florian";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    wired.url = "github:Toqozz/wired-notify/309270cd01d1e61cf5c32fa7fb18ed6f09a15c47";
  };

  outputs = { nixpkgs, home-manager, wired, stylix, ... }:
    let
      system = "x86_64-linux";
    in {
      homeConfigurations."florian" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ wired.overlays.x86_64-linux];
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          wired.homeManagerModules.default
          stylix.homeManagerModules.stylix
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
