{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-5 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/29fe096e2030dd8741bb97dc1c06547816ac957f.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-7 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/ec21888446f41e13dfc79613e30438aca5b232aa.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-9 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/2970ef41ee4eb0478eaba1118c71438ca5bc8a37.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-11 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d93419d83721acbabf95e870721e29041e5df07e.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-12 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/eccdf319d767436590ac081e16f055fff91f6cd8.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-13 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a09c9e044bde2d3dc076e914a6883b6ac3a02223.tar.gz") { config = { allowUnfree = true; }; };
        
#         nexusmods = import (fetchTarball "https://github.com/matejc/nixpkgs/archive/nexus-mods-app_2.tar.gz") { config = { allowUnfree = true; }; };
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge9-5.proton-ge-bin proton-ge9-7.proton-ge-bin proton-ge9-9.proton-ge-bin proton-ge9-11.proton-ge-bin proton-ge9-12.proton-ge-bin proton-ge9-13.proton-ge-bin];
  };

  programs.gamemode.enable = true;

  programs.alvr = {
    enable = true;
    package = pkgs.unstable.alvr;
    openFirewall = true;
  };
  # enable mangohud for all vulkan apps
  hardware.opengl = {
    extraPackages = with pkgs; [mangohud];
    extraPackages32 = with pkgs; [mangohud];
  };

  environment.systemPackages = with pkgs; [
    prismlauncher           # minecraft launcher
    heroic
    wineWowPackages.stable
    winetricks
    protontricks
    gnome.zenity            # mod manager 2 installer requirement
    p7zip
    sunshine                # game streaming
    mangohud                # performance UI for vulkan applications
  ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  # Xbox controller compatibility
  # hardware.xone.enable = true;
  # hardware.xpadneo.enable = true;

}
