# Entrypoint file.

{ config, pkgs, ... } :

{
  imports = [
    ./user
    ./system
  ];
}
