{
  pkgs,
  self,
  ...
}:
{
  imports = [
    "${self}/modules/darwin/base.nix"
    "${self}/modules/darwin/garbage-collection.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system = {
    stateVersion = 5;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
  ];
  environment.systemPackages = [
    pkgs.dotnet-sdk_7
  ];

  homebrew = {
    enable = true;
    brews = [
      # Languages
      "mysql"
    ];
  };
}
