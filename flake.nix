{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        # Default configuration for Linux
        "user" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };

      # macOS configuration
      homeConfigurations."user@darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [ 
          ./home.nix
          { home.homeDirectory = "/Users/user"; }
        ];
      };
      
      homeConfigurations."user@darwin-x86" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [ 
          ./home.nix
          { home.homeDirectory = "/Users/user"; }
        ];
      };
    };
}
