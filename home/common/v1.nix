{
  config,
  pkgs,
  self,
  ...
}:
{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11";

  home.packages = [
  ];

  home.file = {
    ".config/nix" = {
      source = "${self}/dotfiles/nix";
      recursive = true;
    };
    ".config/alacritty" = {
      source = "${self}/dotfiles/alacritty";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${self}/dotfiles/nvim";
      recursive = true;
    };
    ".config/oh-my-posh/" = {
      source = "${self}/dotfiles/oh-my-posh/";
      recursive = true;
    };
    ".zshrc" = {
      source = "${self}/dotfiles/zsh/.zshrc";
    };
    ".tmux.conf" = {
      source = "${self}/dotfiles/tmux/.tmux.conf";
    };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
