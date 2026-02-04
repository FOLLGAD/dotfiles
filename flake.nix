{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    localpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # Helper to generate outputs for multiple systems
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
    in {
      homeConfigurations = {
        # Default configuration for Linux
        "emil@linux" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            { nixpkgs.config.allowUnfree = true; }
          ];
        };
      };

      # Standalone macOS Home Manager (prefer darwinConfigurations instead)
      homeConfigurations."emil" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [ 
          ./home.nix
          {
            home.homeDirectory = "/Users/emil";
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
      
      homeConfigurations."emil@darwin-x86" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [ 
          ./home.nix
          {
            home.homeDirectory = "/Users/emil";
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      # nix-darwin configurations (recommended for macOS)
      #
      # Apply with:
      #   darwin-rebuild switch --flake .#emil-mac
      darwinConfigurations."emil-mac" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./darwin.nix
        ];
      };

      # Dev shells for each system
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            buildInputs = [
              home-manager.packages.${system}.default
            ];
          };
        }
      );
    };
}
