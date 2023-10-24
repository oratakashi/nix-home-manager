# home.nix
Home Manager configuration files

## Installation

- Install the [Nix package manager](https://nixos.org/download.html#nix-quick-install)
- Clone this repo to `~/.config/home-manager` by running:

  ```
  nix-shell -p git --command "git clone https://github.com/FruitieX/home.nix.git $HOME/.config/home-manager"
  ```

- Edit `home.nix`, change at least `home.homeDirectory` to match yours.

- Install [Home Manager](https://github.com/nix-community/home-manager#installation)

- Run `home-manager switch`