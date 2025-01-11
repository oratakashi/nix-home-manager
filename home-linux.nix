{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/oratakashi";

  # Tambahkan konfigurasi Linux lainnya
  programs.zsh.shellAliases = {
    # ... alias lainnya ...
    home-update = ''
        if [[ "$(uname)" == "Darwin" ]]; then
          echo "Installing macOS configuration..."
          home-manager switch --flake ~/.config/home-manager#darwin
        elif grep -q Microsoft /proc/version 2>/dev/null; then
          echo "Installing Windows (WSL) configuration..."
          home-manager switch --flake ~/.config/home-manager#windows
        else
          echo "Installing Linux configuration..."
          home-manager switch --flake ~/.config/home-manager#linux
        fi
      '';
  };
}
