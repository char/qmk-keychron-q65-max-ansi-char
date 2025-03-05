# qmk-keychron-q65-max-ansi-char

Firmware keymap for a Keychron Q65 Max ANSI with rotary encoder

## Setup

1. You want the `wireless_playground` branch of Keychron's QMK fork.
2. `nix shell nixpkgs#qmk` to get the qmk cli (and requisite compilers)
3. Clone this repo into `qmk/keyboards/keychron/q65_max/ansi_encoder/keymaps/char`
4. `qmk compile` to compile, `sudo qmk flash` to flash.
