{
  config,
  pkgs,
  self,
  ...
}:
{
  imports = [
    "${self}/modules/darwin/base.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
  system = {
    stateVersion = 5;
  };
}
