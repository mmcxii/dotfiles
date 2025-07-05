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
      url = "github:zhaofengli/nix-homebrew";
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
      # Business
      darwinConfigurations.business = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit self;
          inherit inputs;
        };
        modules = [
          ./hosts/business/configuration.nix
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
      homeConfigurations.business = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs.aarch64-darwin;
        modules = [
          ./modules/home-manager/dotfiles.nix
          {
            _module.args.self = self;
          }
          ./hosts/business/home.nix
        ];
      };

      # Personal - MacOS
      darwinConfigurations.personal-darwin = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs = {
          inherit self;
          inherit inputs;
        };
        modules = [
          ./hosts/personal-darwin/configuration.nix
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
      homeConfigurations.personal-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs.x86_64-darwin;

        modules = [
          ./modules/home-manager/dotfiles.nix
          {
            _module.args.self = self;
          }
          ./hosts/personal-darwin/home.nix
        ];
      };

      # Personal - NixOS
      nixosConfigurations.personal-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit self;
          inherit inputs;
        };
        modules = [
          ./hosts/personal-nixos/configuration.nix
          ./hosts/personal-nixos/hardware-configuration.nix
          ./hosts/personal-nixos/default.nix
        ];
      };
      homeConfigurations.personal-nixos = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs.x86_64-linux;

        modules = [
          ./modules/home-manager/dotfiles.nix
          {
            _module.args.self = self;
          }
          ./hosts/personal-nixos/home.nix
        ];
      };
    };
}
