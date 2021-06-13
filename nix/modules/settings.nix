{ config, lib, ... }:

with lib;

{
  options = {
    settings = {
      fontSize = mkOption {
        default = 12;
        type = types.int;
      };
    };
  };
}
