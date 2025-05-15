# { config, ... }:
{ ... }:
{
  fileSystems."/mnt/media" = {
    device = "//192.168.254.1/share";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,rw";

    in ["${automount_opts},credentials=/etc/nixos/secrets/smb-local,uid=1000,gid=2004"];
  };

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/d2/2TB NVME" = {
   device = "/dev/disk/by-partuuid/3b438142-5c1a-440e-9787-1e7e593f114e";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "nofail" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/d2/WDBlue 7200RPM" = {
    device = "/dev/disk/by-partuuid/c6100257-d4fa-4057-b0b4-29fb2f446529";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/run/media/d2/ADATA 256GB" = {
    device = "/dev/disk/by-partuuid/3bca77fa-4eb0-4bb1-87aa-3b354129e200";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
