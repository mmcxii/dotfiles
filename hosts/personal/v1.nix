{ config, pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-darwin";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.mkalias

    pkgs.alacritty
    pkgs.neovim
    pkgs.nixfmt-rfc-style
    pkgs.tmux
    pkgs.ripgrep
    pkgs.fzf
    pkgs.zoxide
    pkgs.stow
    pkgs.oh-my-posh

    pkgs.obsidian

    pkgs.nodejs_22
    pkgs.python3

    # TODO: Investigate why these packages aren't working.
    # pkgs.raycast
    # pkgs.vscode
    # pkgs.lazygit
  ];

  homebrew = {
    enable = true;
    brews = [
      "nvm"
      "lazygit"
    ];
    casks = [
      "todoist"
      "raycast"
      "visual-studio-code"
      "font-meslo-lg-nerd-font"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  # MacOS System Configuration
  system = {
    stateVersion = 5;
    configurationRevision = self.rev or self.dirtyRev or null;

    activationScripts = {
      applications = {
        text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';
      };
    };

    defaults = {
      dock = {
        autohide = true;
        persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/Applications/Todoist.app"
        ];
      };
      finder = {
        FXPreferredViewStyle = "clmv";
      };
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        KeyRepeat = 2;
      };
    };
  };
}
