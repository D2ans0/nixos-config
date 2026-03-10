# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/bluetooth.nix
      # ./modules/nvidia.nix # no longer using nvidia gpu
      ./modules/amd.nix
      ./modules/mounts.nix
      ./modules/razer.nix
      ./modules/virtualization.nix
      ./modules/gaming.nix
      ./modules/smbd.nix
      ./modules/audio.nix
    ];

  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
#    kernel.sysctl = {
#      "vm.swappiness" = 20;
#    };
#    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "stumper"; # Define your hostname.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = { 
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d +1";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    libgcc.lib
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.enp9s0.wakeOnLan.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tbilisi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };

  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.zsh.enable = true;

  users.groups.docker = {};
  users.groups.shared = { gid = 2004;};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.d2 = {
    isNormalUser = true;
    description = "d2";
    extraGroups = [ "networkmanager" "wheel" "docker" "shared"];
    shell =  pkgs.zsh;
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # utilities
    zsh
    starship # zsh prompt
    wget
    wget2
    nmap
    lsof
    vlc
    picard
    wireguard-tools
    qbittorrent
    htop
    btop
    ctop
    vulkan-tools
    cosmic-term
    libgcc
    ffmpeg-full
    unrar
    (appimage-run.override { extraPkgs = pkgs: [ pkgs.icu ]; })
    gsettings-desktop-schemas # dependency for flynnyviz
    unzip
    dualsensectl
    ncdu
    jq
    xdotool

    # administration
    kubectl
    kubernetes-helm
    nix-index

    # socials
    # teamspeak3 # removed because of qtwebengine 5, which depends on chromium. QT-WE5 doesn't get built by Hydra as it's insecure. I AM NOT BUILDING CHROMIUM JUST TO UPDATE MY DAMN SYSTEM
    telegram-desktop
    signal-desktop

    # productivity
    thunderbird
    vim
    obsidian
    zoom-us

    # programming
    vscode
    delta # pager for git
    dbeaver-bin
    rustup
    gcc
    pkg-config

    # creative
    inkscape
    adwaita-icon-theme # undeclared inkscape dependency, waiting on #447250 in nixpkgs
    blender
    pureref
    gimp

    # fun
    spotify
    koodo-reader

    # misc.
    anki
    kando
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
  programs.dconf.enable = true;
  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
  programs.kdeconnect.enable = true;
  programs.git = {
    enable = true;
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    jetbrains-mono
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
  services.flatpak.enable = true;
  # installed flatpak packages:
  # dev.vencord.Vesktop
  # com.usebottles.bottles
  # com.github.Matoking.protontricks


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.fwupd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
