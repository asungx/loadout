{ inputs, system, ... } :
  let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
{
  thinkpad-x1 = nixosSystem {
    inherit pkgs system;
    # Not exactly sure what this does...be wary.
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/thinkpad-x1
      ../system/configuration.nix
    ];
  };
}
