{
  description = "UnderGreen's machines configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur-no-pkgs.url = "github:nix-community/NUR/master";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.endurance = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./machines/endurance/configuration.nix)
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        inputs.nixpkgs.nixosModules.notDetected
        inputs.sops-nix.nixosModules.sops
      ];
      specialArgs = { inherit inputs; };
    };

    endurance = self.nixosConfigurations.endurance.config.system.build.toplevel;
  };
}
