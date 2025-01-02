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

- Edit `home.nix`, change at least `home.homeDirectory` to match yours.

- Run `nix run github:nix-community/home-manager -- switch --flake .`

- Run `home-manager switch`