# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./networking.nix
    
    #../modules/sops.nix
    # ../../modules/golang.nix
    # ../../modules/emacs.nix
    # ../../modules/gnupg.nix

    # Include base configuration for all machines
    ../base.nix

    # Include any other services and programs
    ../../home-base.nix
    ../../desktop-base.nix
    ../../services/laptop.nix
    ../../modules/settings.nix
  ];

  settings = {
    fontSize = 12;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # programs.seahorse.enable = true;

  # List services that you want to enable:

  # control the speed of the fans on Thinkpad
  services.thinkfan = { enable = true; };

  # enable events based on battery level
  services.upower.enable = true;

  services.xserver.dpi = 141;
  fonts.fontconfig.dpi = 141;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
