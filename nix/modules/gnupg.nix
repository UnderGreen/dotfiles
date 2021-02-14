{
  home-manager.users.greenday = {
    services = {
      gpg-agent = {
        enable = true;
        defaultCacheTtl = 3600;
        defaultCacheTtlSsh = 3600;
        enableSshSupport = true;
        pinentryFlavor = "gnome3";
      };
    };
  };
}
