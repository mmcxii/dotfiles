{ ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "01:00";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = [ "02:00" ];
    };
  };
}
