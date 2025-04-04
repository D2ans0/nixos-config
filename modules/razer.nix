# { config, lib, pkgs, ... }:
{ pkgs, ... }:
{
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
  hardware.openrazer.users = ["d2"];
}
