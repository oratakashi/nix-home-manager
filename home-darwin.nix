{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/oratakashi";

  # Tambahkan konfigurasi macOS lainnya
  home.packages = with pkgs; [
    cocoapods
    # Package macOS spesifik lainnya bisa ditambahkan di sini
  ];

  programs.zsh.shellAliases = {
    # ... alias lainnya ...
    darwin-rebuild = "darwin-rebuild switch --flake ~/.config/home-manager#oratakashi";
  };
}