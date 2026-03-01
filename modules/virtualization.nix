{ ... }:
{ 
    virtualisation.virtualbox.host = {
      enable = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
    users.extraGroups.vboxusers.members = [ "d2" ];
    virtualisation.docker.enable = true;
}
