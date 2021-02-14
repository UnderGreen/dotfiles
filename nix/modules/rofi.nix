{ pkgs, ... }:

{
  home-manager.users.greenday = {
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      font = "Noto Sans 14";
      theme = ./rofi/dracula-theme.rasi;
    };
  };
}
