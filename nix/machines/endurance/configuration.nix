# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./networking.nix
    #../modules/sops.nix
    ../../modules/home.nix
    ../../modules/fonts.nix
    ../../modules/bluetooth.nix
    ../../modules/audio.nix
    ../../modules/i3.nix
    ../../modules/desktop.nix
    ../../modules/golang.nix
    ../../modules/emacs.nix
    ../../modules/gnupg.nix
    ../../modules/zsh.nix
    ../../modules/git.nix
    ../../modules/alacritty.nix
    ../../modules/polybar.nix
    ../../modules/rofi.nix
    ../../modules/xresources.nix
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Remove unused blocks for SSD
  services.fstrim.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  nix = {
    maxJobs = lib.mkDefault 4;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.greenday = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "video"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    initialHashedPassword =
      "$6$6bSZ0eBfeekdl$diqXX2Pa7fr1iNMTDJjELOg2gyLyVjDhhCfdjtcaTZM43cd2x0ebJnxKVhjiezrAZYclv.yv/s4/WF1kWyfC3/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPo+v93dCBADaJ+K92ptX1mGQAFIu4WP1R+d6ThC4G7La2T9oPS/iHXToiSfUteCmQu3VWLpLNp6mSY/l9W/zyirF5jmC7d7voJDBdg5nYKZFLo+wXEa7PrcFKPId/JK60A9482Ubw/GhGEZD7XNSSEGpzdhIFSkXEhAIeuMrn8ewVc1405dYKFryOXWOVxGipR1yj6tXKGlc0yn3mRuPPgNCfb2MThlbGg8e0sJ3g7Gv6buDRiDe8sWSPCinvF/omg5AvPnNt4rN6ffgJ8tQtWNsS7FJpYlDTiSm4XCw5v0TIlSVu+OypJf18+eowGEioellp039dKFvv+D/d1oy+qJAS+A3FTCp/Ntgvr1VvbHy4GEIO595x6AuwYM4mTJBXmAjn3HUgjAnwy9BBDWsRRy8GM4eNBp+lbgbdPysO0sAJPB98EsqtkofRjSKTWVZD2ptgrxJmlzOKWfh1pMaun9xnqLvpZy5P9oTB3AidKSxKHQ2lRs00JgXos6p53Tc2Ybq1t+Pr9pVS2t0oq60h6Sfc4t0SL/iulpyhfdO+SXnrrxANzaR/R5Mz1gvEtXPXFqbB8l3MpjB+OzmmDgbakC6mxfz3FUCUrmaTnJ8UYvKiqSyWtDetk8Vzc4CzxPYI8H7UrZWOxYicvvsMfvrov13y9/hthB8MloxFxKfOow== greendayonfire@gmail.com"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    git
    home-manager
    lm_sensors
    wget
    vim
    #firefox
  ];

  nixpkgs.config.allowUnfree = true;

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
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  programs.seahorse.enable = true;

  # List services that you want to enable:

  services.thinkfan = { enable = true; };

  services.logind.extraConfig = "RuntimeDirectorySize=8G";

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };

  hardware.opengl = {
    enable = config.services.xserver.enable;
    driSupport32Bit = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "21.03"; # Did you read the comment?

}
