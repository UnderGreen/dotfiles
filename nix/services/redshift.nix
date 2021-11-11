{
  home-manager.users.greenday.services = {
    redshift = {
      enable = true;
      latitude = "44";
      longitude = "-79";
      temperature.day = 6000;
      temperature.night = 3500;
    };
  };
}
