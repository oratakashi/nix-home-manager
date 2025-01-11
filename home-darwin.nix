{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/oratakashi";
  home.stateVersion = "23.11"; # Add this line to fix the error
  home.sessionVariables.PATH = "${config.home.homeDirectory}/.config/home-manager/result/sw/bin:$PATH";

  # Tambahkan konfigurasi macOS lainnya
  home.packages = with pkgs; [
    cocoapods
    # Package macOS spesifik lainnya bisa ditambahkan di sini
  ];

  programs.zsh.shellAliases = {
    # ... alias lainnya ...
    home-update = "darwin-rebuild switch --flake ~/.config/home-manager#oratakashi";
  };
}