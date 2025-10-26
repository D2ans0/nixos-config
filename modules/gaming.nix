{ pkgs, ... }:
{
  nixpkgs = {
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
