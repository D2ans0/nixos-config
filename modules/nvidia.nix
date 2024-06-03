{ config, pkgs, ... }:
{
  # Allow unfree and add unstable packages as an option
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_555_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/c0024cfbe18d290fff52c20b0afef5ac33f7a16a.tar.gz") { config = { allowUnfree = true; }; };
  };


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
#     package = (pkgs.unstable.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # latest stable
    package = (pkgs.nvidia_555_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 555.42.02
  };
}
