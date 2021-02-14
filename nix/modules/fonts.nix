{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11-fonts
    fontconfig = {
      enable = true;
      dpi = 141;
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
      ibm-plex
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
}
