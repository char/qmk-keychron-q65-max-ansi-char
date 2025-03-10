# qmk-keychron-q65-max-ansi-char

Firmware keymap for a Keychron Q65 Max ANSI with rotary encoder

## Setup

1. You want the `wireless_playground` branch of Keychron's QMK fork.
2. Comment out the default_layer_set in dip_switch_update_kb in q65_max.c
3. `nix shell nixpkgs#qmk` to get the qmk cli (and requisite compilers)
4. Clone this repo into `qmk/keyboards/keychron/q65_max/ansi_encoder/keymaps/char`
5. `qmk compile` to compile, `sudo qmk flash` to flash.
