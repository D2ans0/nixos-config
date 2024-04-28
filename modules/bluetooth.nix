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
    LE = {
      MinConnectionInterval = 7;
      MaxConnectionInterval = 9;
      ConnectionLatency = 0;
    };
  };
  hardware.bluetooth.input.General = { UserspaceHID = true; };
  hardware.xpadneo.enable = true;
}
