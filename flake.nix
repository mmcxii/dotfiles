{
  description = "Nix Configuration Flake for Packages and Dotfiles";

  inputs = {
    # Core
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      ...
    }:
    {
      # Home Manager Configurations
      homeConfigurations = {
        personal = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [
            ./home/common/v1.nix
            {
              _module.args.self = self;
            }
            ./home/personal/v1.nix
          ];
        };
      };

      # MacOS Configurations
      darwinConfigurations = {
        personal = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = {
            inherit self;
          };
          modules = [
            ./hosts/personal/v1.nix
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = false; # Apple Silicon Only
                user = "nichsecord";
              };
            }
          ];
        };

        business = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit self;
          };
          modules = [
            ./hosts/business/v1.nix
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true; # Apple Silicon Only
                user = "nsecord";
              };
            }
          ];
        };
      };
    };
}
