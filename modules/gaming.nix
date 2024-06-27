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
#         nexusmods = import (fetchTarball "https://github.com/matejc/nixpkgs/archive/nexus-mods-app_2.tar.gz") { config = { allowUnfree = true; }; };
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge9-5.proton-ge-bin proton-ge9-7.proton-ge-bin ];
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
