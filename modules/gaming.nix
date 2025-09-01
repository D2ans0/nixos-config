{ pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        ge9-5 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/29fe096e2030dd8741bb97dc1c06547816ac957f.tar.gz") {};
        ge9-13 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a09c9e044bde2d3dc076e914a6883b6ac3a02223.tar.gz") {};
        ge9-18 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f975c8df9ec0c6ce5b50f8d43e7fdac085081914.tar.gz") {};
        ge9-25 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/5168db408888db34667e8e7dccfe85e568c4349c.tar.gz") {};
        ge9-27 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/c92c1efa465497446d090134c6c8441c5fb9c4b2.tar.gz") {};
        ge10-12 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/4f3e0b708cadf6ebe60653f8eba3e3c10a7071f3.tar.gz") {};
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      ge9-5.proton-ge-bin
      ge9-13.proton-ge-bin
      ge9-18.proton-ge-bin
      (ge9-25.proton-ge-bin.override { steamDisplayName = "GE-Proton-9.25"; })
      (ge9-27.proton-ge-bin.override { steamDisplayName = "GE-Proton-9.27"; })
      (ge10-12.proton-ge-bin.override { steamDisplayName = "GE-Proton-10.12"; })

    ];
    protontricks.enable = true;
  };

  programs.gamemode.enable = true;

  programs.alvr = {
    enable = true;
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
