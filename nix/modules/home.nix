{ pkgs, ... }:

{
  home-manager.users.greenday = {
    home.stateVersion = "21.03";
    home.packages = with pkgs; [
      bat
      brightnessctl
      fd
      google-chrome
      google-cloud-sdk
      gnumake
      i3lock-color
      lxappearance
      keepassxc
      nixfmt
      python3Minimal
      ripgrep
      slack
      sqlite
      tdesktop
    ];
  };
}
