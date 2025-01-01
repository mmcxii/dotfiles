{
  config,
  pkgs,
  self,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # MacOS Utils
    pkgs.mkalias

    # Terminal Utils
    pkgs.ripgrep
    pkgs.fzf
    pkgs.zoxide
    pkgs.oh-my-posh
    pkgs.tmux

    # Apps
    pkgs.neovim
    pkgs.obsidian

    # Languages
    pkgs.nodejs_22
    pkgs.python3

    # Language Support
    pkgs.nixfmt-rfc-style

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
