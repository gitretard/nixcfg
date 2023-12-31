{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = {self, nixpkgs, home-manager, ...}:
  let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
	  config.allowUnfree = true;	
  };
  lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      retard = lib.nixosSystem rec {
        inherit system;
        modules = [ 
          ./host/shittydesk.nix
          ./nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.retard = import ./home/home.nix ;
          }
        ];
      };
    };
  };
}