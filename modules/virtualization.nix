{ ... }:
{ 
    virtualisation.virtualbox.host = {
      enable = true;
    };
    users.extraGroups.vboxusers.members = [ "d2" ];
    virtualisation.docker.enable = true;
}
