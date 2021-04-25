{ pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/golang.nix
    ./programs/zsh.nix
  ];
  
  home-manager.users.greenday = {
    home.stateVersion = "20.09";
    home.packages = with pkgs; [
      cdrkit
      fd
      google-cloud-sdk
      gnumake
      ripgrep
      sqlite
      terraform
      terraform-provider-libvirt
    ];
  };
}
