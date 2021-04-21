{ pkgs, ... }:

{
  home-manager.users.greenday = {
    services = {
      polybar = {
        enable = true;
        package = pkgs.polybar.override {
          i3 = true;
          i3GapsSupport = true;
          pulseSupport = true;
        };
        config = {
          "bar/top" = {
            bottom = false;
            fixed-center = true;
            radius = 0;
            wm-name = "i3";
            modules-left = "logo sep i3";
            modules-right = "volume sep battery sep date";
            tray-position = "right";
            tray-detached = false;
            font-0 = "Iosevka Nerd Font:size=12;3";
            font-1 = "icomoon\-feather:size=12;3";
          };

          "module/i3" = {
            type = "internal/i3";
            pin-workspaces = true;
            strip-wsnumbers = true;
            enable-click = true;
          };

          "module/date" = {
            type = "internal/date";
            interval = 30;
            date = "%d.%m.%y";
            time = "%H:%M";
            label = "%time%  %date%";
          };

          "module/battery" = {
            type = "internal/battery";
            full-at = 95;
            battery = "BAT0";
            poll-interval = 30;
          };

          "module/volume" = {
            type = "internal/pulseaudio";
            interval = 5;
            use-ui-max = false;
            format-volume = "<ramp-volume><label-volume>";
            label-muted-text = "ﱝ";
            label-muted-foreground = "#666";
            ramp-volume-0 = "奄";
            ramp-volume-1 = "奔";
            ramp-volume-2 = "墳";
            click-right = "pavucontrol &";
          };

          "module/decor-glyph" = {
            type = "custom/text";
            content-foreground = "#899ca1";
            margin = 0;
          };

          "module/sep" = {
            "inherit" = "module/decor-glyph";
            content = "/";
          };
        };
        script = "polybar top &";
      };
    };
  };
}
