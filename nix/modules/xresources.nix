{ pkgs, ... }:

{
  home-manager.users.greenday = {
    xresources = {
      properties = {
        "Xft.dpi" = 141;
      };
      
      extraConfig = builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "xresources";
          rev = "bc0525c20209760c8fe50f45aedde265027a0dc0";
          sha256 = "3vo67r0B0nPwmpmpT/r9oZYYtRHaZOmRxDJeVFUhwcs=";
        } + "/Xresources"
      );
    };
  };
}
