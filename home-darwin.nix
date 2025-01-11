{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/oratakashi";
  home.stateVersion = "23.11"; # Add this line to fix the error

  # Tambahkan konfigurasi macOS lainnya
  home.packages = with pkgs; [
    cocoapods
    # Package macOS spesifik lainnya bisa ditambahkan di sini
  ];

  programs.zsh.shellAliases = {
    # ... alias lainnya ...
    home-update = "./result/sw/bin/darwin-rebuild switch --flake ~/.config/home-manager#oratakashi";
  };
}