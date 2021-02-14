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
            modules-left = "logo i3";
            modules-right = "battery date";
            tray-position = "right";
          };

          "module/i3" = { type = "internal/i3"; };

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
        };
        script = "polybar top &";
      };
    };
  };
}
