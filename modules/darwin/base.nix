{
  config,
  pkgs,
  self,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.systemPackages = with pkgs; [
    # MacOS Utils
    mkalias

    # Terminal Utils
    ripgrep
    fzf
    zoxide
    oh-my-posh
    tmux

    # Apps
    neovim
    obsidian
    spotify

    # Languages
    nodejs_22
    python3

    # Language Support
    nixfmt-rfc-style
    nixd

    # TODO: Investigate why these packages aren't working.
    #raycast
    #vscode
    #lazygit
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
      "ghostty"
      "arc"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  # MacOS System Configuration
  system = {
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
          "/Applications/Ghostty.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/Applications/Todoist.app"
          "/Applications/Arc.app"
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
