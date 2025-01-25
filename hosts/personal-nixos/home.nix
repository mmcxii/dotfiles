
{ ... }:
{

  home.username = "nsecord";
  home.homeDirectory = "/home/nsecord";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
