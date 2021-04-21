{ pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,ctrl:nocaps,terminate:ctrl_alt_bksp";

    videoDrivers = [ "nvidia" "intel" ];

    desktopManager.xterm.enable = false;

    displayManager = {
      defaultSession = "none+i3";
      lightdm = { enable = true; };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  home-manager.users.greenday = {
    home.file.".icons/default".source =
        "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";

    xsession = {
      pointerCursor = {
        package = pkgs.capitaine-cursors;
        name = "Capitaine Cursors - White";
        size = 32;
      };
   
      windowManager.i3 = {
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
    };
  };
}
