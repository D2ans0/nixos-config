{pkgs, lib, ...}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) removeSuffix;
in {
  nixpkgs = {
    overlays = [
      (final: prev: {
        proton-ge-bin_10-25 = prev.proton-ge-bin.overrideAttrs (finalAttrs: oldAttrs: {
          version = "GE-Proton10-25";
          steamDisplayName = finalAttrs.version;
          inherit (finalAttrs.passthru.variants.${prev.stdenv.hostPlatform.system}) src toolName;
          passthru = oldAttrs.passthru // {
              variants = mapAttrs (system: hash: let
                  toolName = "${finalAttrs.version}"; # remove arch name as it messes up with name replacement
                in {
                  inherit toolName;
                  src = final.fetchzip {
                    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${finalAttrs.version}/${toolName}.tar.gz";
                    inherit hash;
                  };
                }) {
                  x86_64-linux = "sha256-RKko4QMxtnuC1SAHTSEQGBzVyl3ywnirFSYJ1WKSY0k=";
                  #aarch64-linux = ""; # not used in my setup
                };
            };
        });
        proton-ge-bin_10-34 = prev.proton-ge-bin.overrideAttrs (finalAttrs: oldAttrs: {
          version = "GE-Proton10-34";
          steamDisplayName = finalAttrs.version;
          inherit (finalAttrs.passthru.variants.${prev.stdenv.hostPlatform.system}) src toolName;
          passthru = oldAttrs.passthru // {
              variants = mapAttrs (system: hash: let
                  toolName = "${finalAttrs.version}"; # remove arch name as it messes up with name replacement
                in {
                  inherit toolName;
                  src = final.fetchzip {
                    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${finalAttrs.version}/${toolName}.tar.gz";
                    inherit hash;
                  };
                }) {
                  x86_64-linux = "sha256-lzPsYYcrp5NoT3B0WFj3o10Z7tXx7xva1wEP3edeuqM=";
                  #aarch64-linux = ""; # not used in my setup
                };
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
      proton-ge-bin_10-34
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
    prismlauncher            # minecraft launcher
    heroic                   # for epic games stuff
    wineWow64Packages.stable
    winetricks
    zenity                   # mod manager 2 installer requirement
    p7zip
    mangohud
    satisfactorymodmanager
  ];


  # Xbox controller compatibility
  # hardware.xone.enable = true;
  # hardware.xpadneo.enable = true;

}
