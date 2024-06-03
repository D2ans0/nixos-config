{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
#         nexusmods = import (fetchTarball "https://github.com/matejc/nixpkgs/archive/nexus-mods-app_2.tar.gz") { config = { allowUnfree = true; }; };
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ unstable.proton-ge-bin ];
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
    prismlauncher
    wineWowPackages.stable
    winetricks
    protontricks
    gnome.zenity
    p7zip
  ];

  # Xbox controller compatibility
  # hardware.xone.enable = true;
  # hardware.xpadneo.enable = true;

}
