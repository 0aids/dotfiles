{
  description = "Nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    in
    {
      nixosConfigurations = {
        zooker = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
              inherit zen-browser;
              pkgs = pkgs;
          };
          modules = [
            ./hosts/zooker
          ];
        };
      };
    };
}
