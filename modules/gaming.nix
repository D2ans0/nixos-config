{ pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        proton-ge-bin_10-25 = (prev.proton-ge-bin.override { steamDisplayName = "GE-Proton10-25"; }).overrideAttrs (old: {
          pname = "proton-ge-bin_10-25";
          version = "GE-Proton10-25";
          src = final.fetchzip {
            url = "https://github.com/Weather-OS/GDK-Proton/releases/download/{finalAttrs.version}/{finalAttrs.version}.tar.gz";
            sha256 = "sha256-RKko4QMxtnuC1SAHTSEQGBzVyl3ywnirFSYJ1WKSY0k=";
          };
        });
      })
    ];
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {};
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-ge-bin_10-25
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
    wineWow64Packages.stable
    winetricks
    zenity                  # mod manager 2 installer requirement
    p7zip
    mangohud
    satisfactorymodmanager
  ];


  # Xbox controller compatibility
  # hardware.xone.enable = true;
  # hardware.xpadneo.enable = true;

}
