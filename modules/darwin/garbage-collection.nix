{ ... }:
{
  nix = {
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 1;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
    };
  };
}
