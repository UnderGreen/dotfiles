{ pkgs, ... }:

{
  home-manager.users.greenday = {
    programs.go = {
      enable = true;
      package = pkgs.go_1_14;
      goPath = "go";
    };

    home.packages = with pkgs; [ gopls ];
  };
}
