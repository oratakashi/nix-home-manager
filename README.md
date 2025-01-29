# home.nix

Home Manager configuration files

## Installation

- Install the Nix package manager :

  ```
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```

- Clone this repo to `~/.config/home-manager` by running:

  ```
  nix-shell -p git --command "git clone git@github.com:oratakashi/nix-home-manager.git $HOME/.config/home-manager"
  ```

- Run initial configuration on your specifict platform:

  - MacOS :

    - Run Initial Setup for Nix Darwin

    ```
    nix build  ~/.config/home-manager#darwinConfigurations.oratakashi.system
    ```

    - Run Nix Darwin Switch

    ```
    cd ~/.config/home-manager
    ./result/sw/bin/darwin-rebuild switch --flake .#oratakashi
    ```

  - Linux :

    ```
    nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#linux
    ```

  - Windows / WSL :

    ```
    nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#windows
    ```

- Run `home-update`
