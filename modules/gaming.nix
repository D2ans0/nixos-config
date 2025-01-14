{ pkgs, ... }:

{

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-5 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/29fe096e2030dd8741bb97dc1c06547816ac957f.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-13 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a09c9e044bde2d3dc076e914a6883b6ac3a02223.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-18 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f975c8df9ec0c6ce5b50f8d43e7fdac085081914.tar.gz") { config = { allowUnfree = true; }; };
        proton-ge9-21 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/37ce591b9853e4a88d7da23e729eb845267c23c9.tar.gz") { config = { allowUnfree = true; }; };
#         nexusmods = import (fetchTarball "https://github.com/matejc/nixpkgs/archive/nexus-mods-app_2.tar.gz") { config = { allowUnfree = true; }; };
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge9-5.proton-ge-bin proton-ge9-13.proton-ge-bin proton-ge9-18.proton-ge-bin proton-ge9-21.proton-ge-bin];
#   unavailable on stable 24.05, wait for 24.11, or switch to unstable to activate
#    protontricks = {
#      enable = true;
#      package = pkgs.unstable.protontricks;
#    };
  };

  programs.gamemode.enable = true;

  programs.alvr = {
    enable = true;
    package = pkgs.unstable.alvr;
    openFirewall = true;
  };
  # enable mangohud for all vulkan apps
  hardware.graphics = {
    extraPackages = with pkgs; [mangohud];
    extraPackages32 = with pkgs; [mangohud];
  };

  environment.systemPackages = with pkgs; [
    prismlauncher           # minecraft launcher
    wineWowPackages.stable
    winetricks
    zenity                  # mod manager 2 installer requirement
    p7zip
    sunshine                # game streaming
    mangohud                # performance UI for vulkan applications
    unstable.protontricks
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
