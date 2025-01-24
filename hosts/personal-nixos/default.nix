{
  self,
  pkgs,
  ...
}:
{
  imports = [
    "${self}/modules/nixos/garbage-collection.nix"
    "${self}/modules/nixos/auto-upgrade.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system = {
    stateVersion = "24.11";
  };

  environment.systemPackages = with pkgs; [
    # Terminal Utils
    ripgrep
    fzf
    zoxide
    oh-my-posh
    tmux
    lazygit

    # Apps
    neovim
    obsidian
    spotify
    proton-pass
    keet

    # Languages
    nodejs_22
    python3

    # Language Support
    nixfmt-rfc-style
    nixd
  ];
}
