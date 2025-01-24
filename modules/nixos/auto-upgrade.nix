{ config, ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "00:00";
    flake = "${config.users.users.nsecord.home}/dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    allowReboot = true;
  };
}
