# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/bluetooth.nix
      ./modules/nvidia.nix
      ./modules/mounts.nix
      ./modules/razer.nix
      ./modules/virtualization.nix
      ./modules/gaming.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stumper"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

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
      packageOverrides = pkgs: {
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config = { allowUnfree = true; }; };
      };
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # utilities
    zsh
    starship # zsh prompt
    wget
    nmap
    vlc
    puddletag
    wireguard-tools
    qbittorrent
    htop
    ctop
    vulkan-tools
    unstable.cosmic-term
    unstable.libgcc
    ffmpeg
    unrar
    (appimage-run.override { extraPkgs = pkgs: [ pkgs.icu ]; })
    gsettings-desktop-schemas # dependency for flynnyviz
    unzip
    dualsensectl
    ncdu

    # administration
    rustdesk
    remmina
    nix-index

    # socials
    teamspeak_client
    telegram-desktop
    element-desktop
    signal-desktop

    # productivity
    thunderbird
    kate
    vim
    unstable.obsidian
    zoom-us

    # programming
    vscode
    delta # pager for git
    dbeaver-bin
    unstable.rustup
    gcc
    pkg-config

    # creative
    (blender.override { cudaSupport = true; })
    pureref
    davinci-resolve
    gimp
#    obs-studio
    (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
    ];
  })

    # fun
    unstable.spotify
    unstable.koodo-reader

    # misc.
    anki
  ];

  programs.dconf.enable = true;
  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
  programs.git = {
    enable = true;
#   MOVE TO HOME-MANAGER
#    extraConfig = {
#        user = {
#            name = "D2ans0";
#            email = "git@stumpy.dev";
#        };
#        init = { defaultBranch = "main"; };
#        core = { pager = "delta"; };
#        interactive = { diffFilter = "delta --color-only"; };
#        delta = {
#            navigate = true;
#            side-by-side = true;
#            line-numbers = true;
#        };
#        merge = { conflictstyle = "diff3"; };
#        diff = { colorMoved = "default"; };
#    };
  };

  fonts.packages = with pkgs; [
    fira-code-nerdfont
    jetbrains-mono
  ];


  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  # installed flatpak packages:
  # dev.vencord.Vesktop
  # com.usebottles.bottles
  # com.github.Matoking.protontricks


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
