{ config, pkgs, ... }:

{
  home.homeDirectory = "/mnt/c/Users/oratakashi";

  # Windows mungkin tidak menggunakan Zsh
  # programs.powershell.enable = true;

  # Tambahkan konfigurasi Windows lainnya
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