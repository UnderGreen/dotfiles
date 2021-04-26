# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  nixpkgs.config = { allowUnfree = true; };

  home-manager.useGlobalPkgs = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        theme = pkgs.nixos-grub2-theme;
      };
    };
    plymouth.enable = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time = { timeZone = "America/Toronto"; };
  services.timesyncd.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.greenday = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
    initialHashedPassword =
      "$6$6bSZ0eBfeekdl$diqXX2Pa7fr1iNMTDJjELOg2gyLyVjDhhCfdjtcaTZM43cd2x0ebJnxKVhjiezrAZYclv.yv/s4/WF1kWyfC3/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPo+v93dCBADaJ+K92ptX1mGQAFIu4WP1R+d6ThC4G7La2T9oPS/iHXToiSfUteCmQu3VWLpLNp6mSY/l9W/zyirF5jmC7d7voJDBdg5nYKZFLo+wXEa7PrcFKPId/JK60A9482Ubw/GhGEZD7XNSSEGpzdhIFSkXEhAIeuMrn8ewVc1405dYKFryOXWOVxGipR1yj6tXKGlc0yn3mRuPPgNCfb2MThlbGg8e0sJ3g7Gv6buDRiDe8sWSPCinvF/omg5AvPnNt4rN6ffgJ8tQtWNsS7FJpYlDTiSm4XCw5v0TIlSVu+OypJf18+eowGEioellp039dKFvv+D/d1oy+qJAS+A3FTCp/Ntgvr1VvbHy4GEIO595x6AuwYM4mTJBXmAjn3HUgjAnwy9BBDWsRRy8GM4eNBp+lbgbdPysO0sAJPB98EsqtkofRjSKTWVZD2ptgrxJmlzOKWfh1pMaun9xnqLvpZy5P9oTB3AidKSxKHQ2lRs00JgXos6p53Tc2Ybq1t+Pr9pVS2t0oq60h6Sfc4t0SL/iulpyhfdO+SXnrrxANzaR/R5Mz1gvEtXPXFqbB8l3MpjB+OzmmDgbakC6mxfz3FUCUrmaTnJ8UYvKiqSyWtDetk8Vzc4CzxPYI8H7UrZWOxYicvvsMfvrov13y9/hthB8MloxFxKfOow== greendayonfire@gmail.com"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager git wget vim ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.logind.extraConfig = "RuntimeDirectorySize=8G";

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    libvirtd.enable = true;
  };

  hardware.opengl = {
    enable = config.services.xserver.enable;
    driSupport32Bit = true;
  };

  # Remove unused blocks for SSD
  services.fstrim.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

