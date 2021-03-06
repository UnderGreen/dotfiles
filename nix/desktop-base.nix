{ pkgs, config, ... }:

{
  imports = [
    ./programs/alacritty.nix
    ./programs/dircolors.nix
    ./programs/fzf.nix
    ./programs/rofi.nix

    ./services/bluetooth.nix
    ./services/dropbox.nix
    ./services/gnupg.nix

    # Run emacs with X gui
    (import ./services/emacs.nix {
      inherit pkgs config;
      emacsPackage = pkgs.emacs;
    })

    ./services/picom.nix
    ./services/polybar.nix
    ./services/redshift.nix
    ./services/xserver.nix
  ];

  environment.systemPackages = with pkgs; [ google-chrome ];

  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  home-manager.users.greenday = {
    home.packages = with pkgs; [
      keepassxc
      multimarkdown
      nixfmt
      pavucontrol
      tdesktop
    ];

    xresources = {
      extraConfig = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "xresources";
        rev = "bc0525c20209760c8fe50f45aedde265027a0dc0";
        sha256 = "3vo67r0B0nPwmpmpT/r9oZYYtRHaZOmRxDJeVFUhwcs=";
      } + "/Xresources");
    };

    xdg = { userDirs = { enable = true; }; };

    gtk = {
      enable = true;
      font = { name = "Noto Sans 10"; };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "Adwaita";
      };
      gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    };

    home.file.".background-image".source = ./files/wallpaper.jpg;
  };

  qt5 = {
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
    
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true; # ls /run/current-system/sw/share/X11-fonts
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "IBM Plex Mono 10" ];
        sansSerif = [ "IBM Plex Sans 10" ];
        serif = [ "IBM Plex Serif 10" ];
      };
    };

    fonts = with pkgs; [
      cantarell-fonts
      emacs-all-the-icons-fonts
      fira
      font-awesome-ttf
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraMono" "Hack" "Meslo" "Iosevka" ]; })
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      roboto
      roboto-slab
    ];
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = config.services.xserver.enable;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };
}
