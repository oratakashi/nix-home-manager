# home.nix

Home Manager configuration files

## Installation

- Install the Nix package manager :

  ```
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```

- Clone this repo to `~/.config/home-manager` by running:

  - Using SSH

  ```
  nix-shell -p git --command "git clone git@github.com:oratakashi/nix-home-manager.git $HOME/.config/home-manager"
  ```

  - Using HTTPS
  
  ```
  nix-shell -p git --command "git clone https://github.com/oratakashi/nix-home-manager.git $HOME/.config/home-manager"
  ```

- Run initial configuration on your specifict platform:

  - MacOS :

    - Run Initial Setup for Nix Darwin (Intel)

      ```
      nix build  ~/.config/home-manager#darwinConfigurations.oratakashi.system
      ```

    - Run Initial Setup for Nix Darwin (Apple Silicon / arm64)

      ```
      nix build  ~/.config/home-manager#darwinConfigurations.oratakashi-arm64.system
      ```

    - Run Nix Darwin Switch (Intel)

      ```
      cd ~/.config/home-manager
      ./result/sw/bin/darwin-rebuild switch --flake .#oratakashi
      ```

    - Run Nix Darwin Switch (Apple Silicon / arm64)

      ```
      cd ~/.config/home-manager
      ./result/sw/bin/darwin-rebuild switch --flake .#oratakashi-arm64
      ```

  - Linux :

    - Run Home Manager Switch 

    ```
    nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#linux
    ```

    - Change default shell to zsh

    ```
    sudo usermod -s $(which zsh) oratakashi
    ```

  - Windows / WSL :

    ```
    nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#windows
    ```

- Run `home-update`

## Fix & Patch

### Android Emulator Fix on Hackintosh

```
cp ~/.config/home-manager/emulator-fix-hackintosh/emulatorfix.plist ~/Library/LaunchAgents/
```