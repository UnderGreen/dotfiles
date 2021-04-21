{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      config = {
        General = {
          Enable = ''
                   Source,Sink,Media
          '';
        };
      };
    };
    pulseaudio = {
      extraModules = [ pkgs.pulseaudio-modules-bt];
    };
  };
}
