{ pkgs, ... }:

{
  home-manager.users.greenday = {
    programs = {
      dircolors = {
        enable = true;
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };

    services = {
      picom = {
        enable = true;
        backend = "glx";
        vSync = true;
        package = pkgs.picom;
        blur = true;
        extraOptions = ''
          glx-no-rebind-pixmap = true;
          glx-no-stencil = true;
          xrender-sync-fence = false;
        '';
      };
    };
  };
}
