#!/usr/bin/env bash

# NixOS helper build script.

# Shows the output of every command
set +x

activateHM() {
    result/activate
}

rebuild_home() {
    nix build .#homeConfigurations.asungx.activationPackage
    activateHM
}

rebuild_system() {
    sudo nixos-rebuild switch --flake .#thinkpad-x1
}

rebuild_vm() {
    sudo nixos-rebuild build-vm --flake .#thinkpad-x1
}

fresh_install() {
    rebuild_system
    rebuild_home
}

main() {
    case $1 in
        "home")
            rebuild_home;;
        "system")
            rebuild_system;;
        "vm")
            rebuild_vm;;
        "fresh")
            fresh_install;;
        *)
            echo 'Expected "home", "system", "vm", "fresh".';;
    esac
}

main "$@" || exit 1
