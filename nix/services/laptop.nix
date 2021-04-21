{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ lm_sensors ];

  services = {
    xserver = {
      libinput = {
        enable = true;
        clickMethod = "clickfinger";
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };

    tlp = {
      enable = true;
      settings = {
        DISK_DEVICES = "sda";
        DISK_IOSCHED = "mq-deadline";
        START_CHARGE_THRESH_BAT0 = 65;
        STOP_CHARGE_THRESH_BAT0 = 95;

        # Intel CPU HWP hints
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        TPSMAPI_ENABLE = 0;
      };
    };
  };
}
