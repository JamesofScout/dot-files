{pkgs,...}: {
  home.packages = with pkgs; [
    cargo
    rustc
    rustup
    rust-analyzer
  ];
}