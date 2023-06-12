{ inputs, system, ... } :
  let
    inherit (inputs.home-manager.lib) homeManagerConfiguration;

    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    imports = [
      ../home/home.nix
    ];
  in
{
  asungx = homeManagerConfiguration {
    inherit pkgs;
    modules = [{ inherit imports; }];
  };
}
