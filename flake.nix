{
  description = "Nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config = {
              allowUnfree = true;
          };
      };
  in
  {
      nixosConfigurations = {
          zooker = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                  ./hosts/zooker
              ];
          };
      };
  };
}
