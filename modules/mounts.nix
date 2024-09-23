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
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/d2/WDBlue 7200RPM" = {
    device = "/dev/disk/by-partuuid/9535318d-4a9c-4f10-bdd7-722c03ba832e";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/d2/ADATA 256GB" = {
    device = "/dev/disk/by-partuuid/46e55d62-d889-493e-8c4a-1ff0e8f9afb5";
    fsType = "ntfs-3g";
    options = [ "rw" "nosuid" "nodev" "uid=1000" "gid=100" ];
  };
}
