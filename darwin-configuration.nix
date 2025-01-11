{ config, pkgs, ... }:

{
  # Izinkan unfree packages
  nixpkgs.config.allowUnfree = true;

  # Konfigurasi homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    
    # Homebrew Packages (CLI Tools)
    brews = [
      "mas"              # Mac App Store CLI
      "kobweb"           # Kobweb CLI
      # "gh"               # GitHub CLI
    ];

    # Mac Apps (Casks)
    casks = [
      "google-chrome"
    ];

    # Mac App Store Apps
    masApps = {
      # "Xcode" = 497799835;
      # "WhatsApp" = 1147396723;
    };

    # Homebrew Taps (Repositories)
    taps = [
      "homebrew/cask"
      "homebrew/core"
      "homebrew/services"
    ];
  };

  # System settings dan konfigurasi lainnya bisa ditambahkan di sini
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllExtensions = true;
}