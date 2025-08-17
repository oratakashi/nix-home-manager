{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/oratakashi";
  home.stateVersion = "23.11"; # Add this line to fix the error
  # home.sessionVariables.PATH = "${config.home.homeDirectory}/.config/home-manager/result/sw/bin:$PATH";
  home.sessionPath = [
    "${config.home.homeDirectory}/.config/home-manager/result/sw/bin"
    "${config.home.homeDirectory}/.config/kobweb/bin"
  ];

  # Tambahkan konfigurasi macOS lainnya
  home.packages = with pkgs; [
    cocoapods
    wget
    kdoctor
    # Package macOS spesifik lainnya bisa ditambahkan di sini
    (pkgs.writeScriptBin "setup-kobweb" ''
      #!/usr/bin/env bash

      # Menghapus direktori jika sudah ada
      rm -rf ~/.config/kobweb

      # Membuat direktori
      mkdir -p ~/.config/kobweb

      # Mengunduh file menggunakan wget
      wget https://github.com/varabyte/kobweb-cli/releases/download/v0.9.18/kobweb-0.9.18.zip -P ~/.config/kobweb

      # Ekstrak file
      unzip ~/.config/kobweb/kobweb-0.9.18.zip -d ~/.config/kobweb

      # Menghapus file zip
      rm -rf ~/.config/kobweb/kobweb-0.9.18.zip
      mv ~/.config/kobweb/kobweb-0.9.18/* ~/.config/kobweb
      rm -rf ~/.config/kobweb/kobweb-0.9.18

      echo "Kobweb CLI setup completed."
    '')
  ];

  programs.zsh.shellAliases = {
    # ... alias lainnya ...
    home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#oratakashi";
  };

  programs.fish.shellAliases = {
    # ... alias lainnya ...
    home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#oratakashi";
  };
}