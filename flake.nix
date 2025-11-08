{
  description = "Home Manager configuration";

  inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    localpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
        "emil2" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };

      # macOS configuration
      homeConfigurations."emil" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [ 
          ./home.nix
          { home.homeDirectory = "/Users/emil"; }
        ];
      };
      
      homeConfigurations."emil@darwin-x86" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [ 
          ./home.nix
          { home.homeDirectory = "/Users/emil"; }
        ];
      };
    };
}
