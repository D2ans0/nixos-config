# { config, lib, pkgs, ... }:
{ pkgs, ... }:
{
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [ unstable.openrazer-daemon unstable.polychromatic ];
  hardware.openrazer.users = ["d2"];
}
