{ config, pkgs, ... }:

{
  home.username = "nichsecord";
  home.homeDirectory = "/Users/nichsecord";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../../../.zshrc;
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;
}