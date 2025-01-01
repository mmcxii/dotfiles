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
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages;
    in
    {
      # Home Manager Configurations
      homeConfigurations = {
        personal = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.x86_64-darwin;

          modules = [
            ./home/common/default.nix
            {
              _module.args.self = self;
            }
            ./home/personal/default.nix
          ];
        };

        business = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.aarch64-darwin;
          modules = [
            ./home/common/default.nix
            {
              _module.args.self = self;
            }
            ./home/personal/default.nix
          ];
        };
      };

      # MacOS Configurations
      darwinConfigurations = {
        personal = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = {
            inherit self;
            inherit inputs;
          };
          modules = [
            ./hosts/personal/default.nix
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
            inherit inputs;
          };
          modules = [
            ./hosts/business/default.nix
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
