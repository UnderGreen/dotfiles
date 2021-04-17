{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,ctrl:nocaps,terminate:ctrl_alt_bksp";

    videoDrivers = [ "nvidia" ];

    displayManager = {
      defaultSession = "none+bspwm";
      lightdm = {
        enable = true;
      };
    };
    windowManager.bspwm = {
      enable = true;
    };
  };
}
