{
  home-manager.users.greenday = {
    programs.alacritty = {
      enable = true;
      settings = {
        env = { TERM = "xterm-256color"; };
        background_opacity = 0.95;
        font.size = 12;
        colors = import ./alacritty/dracula.nix;
      };
    };
  };
}
