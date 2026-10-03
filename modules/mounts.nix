{ ... }:
{
  fileSystems."/mnt/media" = {
    device = "//192.168.254.1/share";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,rw";

    in ["${automount_opts},credentials=/etc/nixos/secrets/smb-local,uid=1000,gid=2004"];
  };

  fileSystems."/run/media/d2/2TB 980 EVO" = {
   device = "/dev/disk/by-partuuid/6febc3c9-3d5a-4f4c-8857-e6b1b4d1b87d";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/run/media/d2/WDBlue 7200RPM" = {
    device = "/dev/disk/by-partuuid/c6100257-d4fa-4057-b0b4-29fb2f446529";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/run/media/d2/ADATA 256GB" = {
    device = "/dev/disk/by-partuuid/fd6ee729-2ad6-417f-94cb-dadb5bf62742";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/run/media/d2/6TBChungucito" = {
    device = "/dev/disk/by-partuuid/1921843c-9e55-4836-be86-0536ca2b59f2";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 32*1024; # 32 GiB
  }];
}
