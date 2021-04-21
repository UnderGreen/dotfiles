{ pkgs, ... }:

{
  home-manager.users.greenday = {
    services = {
      picom = {
        enable = true;
        backend = "glx";
        fade = true;
        fadeDelta = 1;
        vSync = true;
        package = pkgs.picom;
        blur = true;
        experimentalBackends = true;
        extraOptions = ''
          glx-no-rebind-pixmap = true;
          glx-no-stencil = true;
          xrender-sync-fence = true;
        '';
      };
    };
  };
}
