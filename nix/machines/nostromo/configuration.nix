# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include base configuration for all machines
      ../base.nix

      # Include any other services and programs
      ../../services/xserver.nix
      ../../home-base.nix
      ../../desktop-base.nix
    ];

  networking.hostName = "nostromo"; # Define your hostname.

  time = {
    hardwareClockInLocalTime = true;
  };

  networking.interfaces.enp3s0.useDHCP = true;

  environment.systemPackages = with pkgs; [
    alacritty
    dmenu
    git
    google-chrome
    wget
    vim
  ];

  fonts.fontconfig.dpi = 108;
}
