{ config, pkgs, ... }:
let
  # prod
  nvidia_570_133_07 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.133.07";
    sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
    sha256_aarch64 = "sha256-yTovUno/1TkakemRlNpNB91U+V04ACTMwPEhDok7jI0=";
    openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
    settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
    persistencedSha256 = "sha256-G1V7JtHQbfnSRfVjz/LE2fYTlh9okpCbE4dfX9oYSg8=";
  };
  nvidia_575_51_02_beta = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "575.51.02";
    sha256_64bit = "sha256-XZ0N8ISmoAC8p28DrGHk/YN1rJsInJ2dZNL8O+Tuaa0=";
    sha256_aarch64 = "sha256-NNeQU9sPfH1sq3d5RUq1MWT6+7mTo1SpVfzabYSVMVI=";
    openSha256 = "sha256-NQg+QDm9Gt+5bapbUO96UFsPnz1hG1dtEwT/g/vKHkw=";
    settingsSha256 = "sha256-6n9mVkEL39wJj5FB1HBml7TTJhNAhS/j5hqpNGFQE4w=";
    persistencedSha256 = "sha256-gmco+clEIY8bedxHC4wp+fH5JavTzyI1BI8BxoeJJI=";
  };
in {
  # Allow unfree, and pin older driver versions
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
#    nvidia_555_42_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/c0024cfbe18d290fff52c20b0afef5ac33f7a16a.tar.gz") { config = { allowUnfree = true; }; };
#    nvidia_555_52_beta = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/46a8207b852d2243e889f731e197b06a7052bac2.tar.gz") { config = { allowUnfree = true; }; };
#    nvidia_555_58_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/10ed11d6856a7b67b9b2cef5e52af5c7de34b93f.tar.gz") { config = { allowUnfree = true; }; };
#    nvidia_560_35_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/3a4ac243bf3ec40a2cd558f1dfcfe540b42b62c6.tar.gz") { config = { allowUnfree = true; }; };
#    nvidia_565_77_prod = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/b0749e8e6fbce843a674d0cdab7777b6d042002d.tar.gz") { config = { allowUnfree = true; }; };
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
#    package = (pkgs.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # latest stable
#    package = (pkgs.nvidia_555_42_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 555.42.02
#    package = (pkgs.nvidia_555_52_beta.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 555.52.02
#    package = (pkgs.nvidia_555_58_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # 555.58
#    package = (pkgs.nvidia_560_35_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest; # 560.35
#    package = (pkgs.nvidia_565_77_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.beta; # 565.57
#    package = (pkgs.nvidia_570_133_prod.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.production; # 570.133
#    package = config.boot.kernelPackages.nvidiaPackages.production;
#    package = nvidia_570_133_07;
    package = nvidia_575_51_02_beta;
  };
}
