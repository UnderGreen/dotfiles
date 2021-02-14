{
  home-manager.users.greenday = {
    programs.git = {
      enable = true;
      userName = "Sergei Antipov";
      userEmail = "greendayonfire@gmail.com";
      lfs.enable = true;
      aliases = { "st" = "status"; };
      signing = {
        key = "B167B87787407B3A";
        signByDefault = true;
      };
      extraConfig = {
        github = { user = "UnderGreen"; };
      };
    };
  };
}
