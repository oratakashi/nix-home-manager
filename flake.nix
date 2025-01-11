{
  description = "Oratakashi Cross-Platform Nix System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, darwin, ... }: {
    # Konfigurasi Darwin System
    darwinConfigurations."oratakashi" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.oratakashi = { pkgs, ... }: {
              home = {
                username = "oratakashi";
                homeDirectory = "/Users/oratakashi";
                stateVersion = "23.11";
              };
              imports = [ 
                ./home-shared.nix
                ./home-darwin.nix 
              ];
            };
          };
        }
      ];
    };
    homeConfigurations = {
      # macOS configuration
      "darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ 
          ./home-shared.nix    # Menggunakan path relatif
          ./home-darwin.nix    # Relatif terhadap lokasi flake.nix
        ];
        extraSpecialArgs = {
          inherit darwin;
        };
      };
      
      # Linux configuration
      "linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ 
          ./home-shared.nix
          ./home-linux.nix 
        ];
      };
      
      # Windows configuration (WSL)
      "windows" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ 
          ./home-shared.nix
          ./home-windows.nix 
        ];
      };
    };
  };
}