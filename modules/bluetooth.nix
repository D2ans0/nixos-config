# { config, lib, ... }:
{ ... }:
{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
        Experimental = true;
        Privacy = "device";
        JustWorksRepairing = "always";
        class = "0x000100";
        FastConnectable = true;
    };
  };
  hardware.bluetooth.input.General = { UserspaceHID = true; };
  boot.kernelParams = [ "btusb.enable_autosuspend=0" ];
}
