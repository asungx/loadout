#!/usr/bin/env bash

# NixOS helper build script.

# Shows the output of every command
set +x

# Log an error.
err() {
    printf "${BRed}Error${NC}: $1\n" >&2
    exit 1
}

# Run a command that should never fail. If the command fails execution
# will immediately terminate with an error showing the failing
# command.
ensure() {
    if ! "$@"; then err "command failed: $*"; fi
}

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
    ensure rebuild_system
    ensure rebuild_home
}

test_system() {
    sudo nixos-rebuild test --flake .#thinkpad-x1
}

main() {
    case $1 in
        "home")
            rebuild_home;;
        "system")
            rebuild_system;;
        "test")
            test_system;;
        "vm")
            rebuild_vm;;
        "fresh")
            fresh_install;;
        *)
            echo 'Expected "home", "system", "vm", "fresh", "test".';;
    esac
}

main "$@" || exit 1
