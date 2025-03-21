{ config, pkgs, ... }:

{
  # State version untuk nix-darwin
  system.stateVersion = 5;  # Versi terbaru dari nix-darwin
  # Izinkan unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  # nix.useDaemon = true;

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
      "cloudflared"
      # "mas"              # Mac App Store CLI
      # "kobweb"           # Kobweb CLI
      # "gh"               # GitHub CLI
    ];

    # Mac Apps (Casks)
    casks = [
      "google-chrome"
      "firefox"
      "arc"
      "1password"
      "1password-cli"
      "warp"
      "android-platform-tools"
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
