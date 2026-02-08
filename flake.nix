{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      qmk-keychron = pkgs.fetchFromGitHub {
        owner = "Keychron";
        repo = "qmk_firmware";
        rev = "6f5058f7d04f29762bb97de262922259e525f4d4";
        sha256 = "sha256-EJGSEwImSuUq733JEqu781Sy+xV+5oG4a3PRK9Leco4=";
        fetchSubmodules = true;
        leaveDotGit = true;
      };

    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "keychron-q65-max-firmware";
        version = "1.0";

        src = qmk-keychron;

        nativeBuildInputs = (with pkgs; [
          qmk
          git
          gnused
        ]) ++ (with pkgs.python3Packages; [
          # for some reason we need these for qmk compile to work ?
          appdirs
          argcomplete
          colorama
          dotty-dict
          hjson
          jsonschema
          milc
          pillow
          pygments
          pyserial
          pyusb
        ]);

        postUnpack = ''
          mkdir -p $sourceRoot/keyboards/keychron/q65_max/ansi_encoder/keymaps/char
          cp -r ${./.}/* $sourceRoot/keyboards/keychron/q65_max/ansi_encoder/keymaps/char/
        '';

        patchPhase = ''
          sed -i 's/^\(\s*default_layer_set\)/\/\/ \1/' keyboards/keychron/q65_max/q65_max.c
          sed -i '/^bool dip_switch_update_user/,/^}/d' keyboards/keychron/common/factory_test.c
        '';

        buildPhase = ''
          export QMK_HOME=$PWD
          export HOME=$TMPDIR
          qmk compile -kb keychron/q65_max/ansi_encoder -km char
        '';

        installPhase = ''
          mkdir -p $out
          cp .build/keychron_q65_max_ansi_encoder_char.bin $out/
        '';
      };
    };
}
