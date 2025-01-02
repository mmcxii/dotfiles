{
  self,
  ...
}:
{
  imports = [
    "${self}/modules/darwin/base.nix"
    "${self}/modules/nix/garbage-collection.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
  system = {
    stateVersion = 5;
  };
}
