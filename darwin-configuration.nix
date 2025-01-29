{ config, pkgs, ... }:

{
  # State version untuk nix-darwin
  system.stateVersion = 4;  # Versi terbaru dari nix-darwin
  # Izinkan unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.useDaemon = true;

  # Konfigurasi homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = false;
    };
    
    # Homebrew Packages (CLI Tools)
    brews = [
      # "mas"              # Mac App Store CLI
      # "kobweb"           # Kobweb CLI
      # "gh"               # GitHub CLI
    ];

    # Mac Apps (Casks)
    casks = [
      "google-chrome"
      "1password"
    ];

    # Mac App Store Apps
    masApps = {
      # "Xcode" = 497799835;
      # "WhatsApp" = 1147396723;
    };

    # Homebrew Taps (Repositories)
    taps = [
      # "homebrew/cask"
      # "homebrew/core"
      "homebrew/services"
      # "varabyte/tap"
    ];
  };

  # System settings dan konfigurasi lainnya
  system.defaults.dock = {
    autohide = true;
    autohide-time-modifier = 0.5;
    autohide-delay = 0.0;
  };
  system.defaults.finder.AppleShowAllExtensions = true;

  # Definisikan users yang valid
  users.users.oratakashi = {
    name = "oratakashi";
    home = "/Users/oratakashi";
  };
}