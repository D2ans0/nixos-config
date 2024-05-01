# { config, lib, ... }:
{ config, ... }:
{
  # Allow unfree and add unstable packages as an option
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz;") { config = { allowUnfree = true; }; };
  };

#  enable unstable repo for kernel packages (may be needed for unstable Nvidia drivers)
#  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta; # 535.43.16
    package = config.boot.kernelPackages.nvidiaPackages.latest; # 545.29.02
#     package = config.boot.kernelPackages.nvidiaPackages.beta; # 545.23.06
  };
}
