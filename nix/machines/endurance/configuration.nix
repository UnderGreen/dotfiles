# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./networking.nix
    #../modules/sops.nix
    # ../../modules/fonts.nix
    # ../../modules/bluetooth.nix
    # ../../modules/audio.nix
    # ../../modules/i3.nix
    # ../../modules/desktop.nix
    # ../../modules/golang.nix
    # ../../modules/emacs.nix
    # ../../modules/gnupg.nix
    # ../../modules/git.nix
    # ../../modules/alacritty.nix
    # ../../modules/polybar.nix
    # ../../modules/rofi.nix
    # ../../modules/xresources.nix

    # Include base configuration for all machines
    ../base.nix

    # Include any other services and programs
    ../../services/xserver.nix
    ../../home-base.nix
    ../../programs/zsh.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    lm_sensors
  ];

  services.tlp = {
    enable = true;
    settings = {
      DISK_DEVICES = "sda";
      DISK_IOSCHED = "mq-deadline";
      START_CHARGE_THRESH_BAT0 = 65;
      STOP_CHARGE_THRESH_BAT0 = 95;

      # Intel CPU HWP hints
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      TPSMAPI_ENABLE = 0;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  programs.seahorse.enable = true;

  # List services that you want to enable:

  services.thinkfan = { enable = true; };

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
