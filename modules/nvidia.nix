{ config, pkgs, ... }:
{
  # Allow unfree and add unstable packages as an option
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_555_42_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/c0024cfbe18d290fff52c20b0afef5ac33f7a16a.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_555_52_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/46a8207b852d2243e889f731e197b06a7052bac2.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_555_58_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/10ed11d6856a7b67b9b2cef5e52af5c7de34b93f.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_560_35_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/3a4ac243bf3ec40a2cd558f1dfcfe540b42b62c6.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_565_57_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/3e31b3e7165672c1b9e04025bb35b35f05c119ce.tar.gz") { config = { allowUnfree = true; }; };
    nvidia_565_77_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/b0749e8e6fbce843a674d0cdab7777b6d042002d.tar.gz") { config = { allowUnfree = true; }; };
  };


  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
#    package = (pkgs.unstable.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # latest stable
#    package = (pkgs.nvidia_555_42_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 555.42.02
#    package = (pkgs.nvidia_555_52_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 555.52.02
#    package = (pkgs.nvidia_555_58_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # 555.58
#    package = (pkgs.nvidia_560_35_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # 560.35
#    package = (pkgs.nvidia_565_57_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 565.57
    package = (pkgs.nvidia_565_77_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # 565.77
  };
}
