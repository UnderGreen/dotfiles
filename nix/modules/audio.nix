{ config, pkgs, ... }:

{
  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
  hardware.pulseaudio = {
    enable = config.services.xserver.enable;
    support32Bit = true;
  };

}
