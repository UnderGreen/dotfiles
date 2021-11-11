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
          "colors" ={
            background = "#282a36";
            foreground = "#f8f8f2";
            green = "#50fa7b";
            purple = "#bd93f9";
            orange = "#ffb86c";
            red = "#ff5555";
            cyan = "#8be9fd";
            comment = "#6272a4";
            yellow = "#f1fa8c";
            pink = "#ff79c6";
          };
          
          "bar/top" = {
            background = "\${colors.background}";
            foreground = "\${colors.foreground}";
            enable-ipc = true;
            bottom = false;
            wm-name = "i3";
            height = 40;
            width = "98%";
            offset-x = "1%";
            padding = 3;
            radius-bottom = 15;
            border-top-size = 0;
            border-bottom-size = 0;
            border-color = "\${colors.purple}";
            line-size = 2;
            modules-left = "launcher i3";
            modules-center = "xwindow";
            modules-right = "volume battery date";
            tray-position = "right";
            tray-detached = true;
            wm-restack = "i3";
            override-redirect = true;
            font-0 = "Iosevka Nerd Font:size=14;3";
            font-1 = "Iosevka Nerd Font:style:Semibold:size=14;3";
            font-2 = "Dejavu Sans Mono:size=14;3";
          };

          "module/launcher" = {
            type = "custom/text";
            content = "";
            content-margin = 1;
            content-foreground = "\${colors.cyan}";
            #click-left = launcher;
          };
          
          "module/i3" = {
            type = "internal/i3";
            pin-workspaces = true;
            strip-wsnumbers = true;
            enable-click = true;
            format = "<label-state> <label-mode>";
            format-margin = 1;
            label-focused = "%index% %icon%";
            label-focused-underline = "\${colors.foreground}";
            label-focused-foreground = "\${colors.purple}";
            label-focused-padding = 2;
            label-focused-font = 2;
            label-unfocused = "%index% %icon%";
            label-unfocused-foreground = "\${colors.orange}";
            label-unfocused-padding = 2;
           
            label-urgent = "!";
            label-urgent-padding = 2;
            label-urgent-underline = "\${colors.background}";
            label-urgent-font = 2;
            ws-icon-0 = "1;";
            ws-icon-1 = "2;";
            ws-icon-2 = "3;";
            ws-icon-default = "";
          };

          "module/xwindow" = {
            type = "internal/xwindow";
            label = "%title:0:75:...%";
            label-foreground = "\${colors.green}";
            label-background = "\${colors.background}";
            label-padding = 2;
            label-empty = "Empty";
            label-empty-font = 3;
            label-font = 3;
            format-margin = 2;
          };

          "module/date" = {
            type = "internal/date";
            interval = 30;
            date = "%d.%m.%y";
            time = "%H:%M";
            label = "%time% %date%";
            format-margin = 1;
            label-foreground = "\${colors.orange}";
            label-background = "\${colors.background}";
          };

          "module/battery" = {
            type = "internal/battery";
            full-at = 94;
            battery = "BAT0";
            format-discharging-margin = 1;
            format-charging-margin = 1;
            format-full-margin = 1;
            poll-interval = 30;
            ramp-capacity-0 = "";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";
            time-format = "%H:%M";
            format-discharging = "<ramp-capacity>  <label-discharging>";
            format-discharging-foreground = "\${colors.red}";
            format-charging = "<ramp-capacity>  <label-charging>";
            format-charging-foreground = "\${colors.green}";
            format-full = "<ramp-capacity>  <label-full>";
            format-full-foreground = "\${colors.cyan}";
          };

          "module/volume" = {
            type = "internal/pulseaudio";
            interval = 5;
            format-volume-margin = 1;
            format-muted-margin = 1;
            use-ui-max = false;
            format-volume = "<ramp-volume> <label-volume>";
            format-volume-foreground = "\${colors.pink}";
            format-muted = "<label-muted>";
            label-muted = "婢 %percentage%%";
            format-muted-foreground = "\${colors.comment}";
            ramp-volume-0 = "奄";
            ramp-volume-1 = "奔";
            ramp-volume-2 = "墳";
            click-right = "${pkgs.pavucontrol}/bin/pavucontrol &";
          };

          "global/wm" = {
            margin-top = 2;
            margin-bottom = 2;
          };
        };
        script = "polybar top &";
      };
    };
  };
}
