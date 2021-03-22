{ pkgs, ... }:

{
  home-manager.users.greenday = {
    home.stateVersion = "21.03";
    home.packages = with pkgs; [
      bat
      brightnessctl
      cdrtools
      fd
      google-chrome
      google-cloud-sdk
      gnumake
      i3lock-color
      keepassxc
      lxappearance
      multimarkdown
      nixfmt
      pavucontrol
      python3Minimal
      ripgrep
      slack
      sqlite
      tdesktop
      terraform
      terraform-provider-libvirt
    ];
  };
}
