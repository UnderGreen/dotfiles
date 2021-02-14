{ config, pkgs, home-manager, lib, ... }:

{
  services = {
    gnome3.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf pkgs.gcr ];
    };

    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;

      videoDrivers = [ "intel" ];

      layout = "us,ru";
      xkbOptions = "ctrl:nocaps, lv3:ralt_switch, grp:win_space_toggle";

      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          clickMethod = "clickfinger";
          naturalScrolling = true;
        };
      };

      displayManager = {
        gdm.enable = true;
        gdm.wayland = false;
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  programs.evince.enable = true;
  
  home-manager.users.greenday = {
    gtk = {
      enable = true;
      font = { name = "Noto Sans 10"; };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = false;
      };
    };

    xsession.pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "Capitaine Cursors - White";
      size = 32;
    };

    home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = rec {
        bars = [ ];
        modifier = "Mod4";
        gaps = {
          inner = 8;
          outer = 1;
          smartGaps = true;
        };
        menu = "${pkgs.rofi}/bin/rofi -show drun";
        terminal = "${pkgs.alacritty}/bin/alacritty";

        fonts = [ "Font Awesome 5 Free 10" "IBM Flex Mono 10" ];

        colors = {
          background = "#F8F8F2";

          focused = {
            border = "#6272A4";
            background = "#6272A4";
            text = "#F8F8F2";
            indicator = "#6272A4";
            childBorder = "#6272A4";
          };

          focusedInactive = {
            border = "#44475A";
            background = "#44475A";
            text = "#F8F8F2";
            indicator = "#44475A";
            childBorder = "#44475A";
          };

          unfocused = {
            border = "#282A36";
            background = "#282A36";
            text = "#BFBFBF";
            indicator = "#282A36";
            childBorder = "#282A36";
          };

          urgent = {
            border = "#44475A";
            background = "#FF5555";
            text = "#F8F8F2";
            indicator = "#FF5555";
            childBorder = "#FF5555";
          };

          placeholder = {
            border = "#282A36";
            background = "#282A36";
            text = "#F8F8F2";
            indicator = "#282A36";
            childBorder = "#282A36";
          };
        };

        keybindings = lib.mkOptionDefault {
          "XF86AudioMute" = "exec amixer set Master toggle";
          "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
          "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
          "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
          "${modifier}+g" = "focus mode_toggle";
        };
        startup = [{
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }];
      };
    };

    services = {
      screen-locker = {
        enable = false;
        lockCmd =
          "${lib.getBin pkgs.i3lock-color}/bin/i3lock-color -n -c 000000";
      };
    };
  };
}
