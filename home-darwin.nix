{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/oratakashi";

  # Tambahkan konfigurasi macOS lainnya
  home.packages = with pkgs; [
    cocoapods
    # Package macOS spesifik lainnya bisa ditambahkan di sini
  ];
}