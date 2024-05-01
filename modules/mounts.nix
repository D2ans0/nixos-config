# { config, ... }:
{ ... }:
{
  fileSystems."/mnt/media" = {
    device = "//192.168.254.1/share";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,rw";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=2004"];
  };

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/d2/2TB NVME" = {
   device = "/dev/nvme1n1p2";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/d2/WDBlue 7200RPM" = {
    device = "/dev/sda1";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/d2/ADATA 256GB" = {
    device = "/dev/sdb1";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };
}
