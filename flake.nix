{
  description = "Oratakashi Cross-Platform Nix System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      # macOS configuration
      "darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ 
          ./home-shared.nix    # Menggunakan path relatif
          ./home-darwin.nix    # Relatif terhadap lokasi flake.nix
        ];
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