{
  self,
  ...
}:
{
  imports = [
    "${self}/modules/darwin/base.nix"
    "${self}/modules/darwin/garbage-collection.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
  system = {
    stateVersion = 5;
    primaryUser = "nichsecord";
  };

  homebrew = {
    enable = true;
    casks = [
      "sparrow"
      "keet"
      "proton-mail"
      "protonvpn"
      "makemkv"
    ];
    masApps = {
      "Copilot" = 1447330651;
    };
  };
}
