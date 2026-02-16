{ pkgs, ... }:
{

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        yabridge-fix = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/8dadfa6fde2657da2ffee788765b7b6136ffe2a5.tar.gz") {};
      };
      permittedInsecurePackages = [ "qtwebengine-5.15.19" ];
    };
  };


  environment.systemPackages = with pkgs; [
    reaper
    yabridge-fix.yabridge
    yabridgectl
  ];

}
