{ lib
, stdenv
, newScope
, gnuradio # unwrapped gnuradio
}:

lib.makeScope newScope ( self:

let
  # Modeled after qt's
  mkDerivationWith = import ../development/gnuradio-modules/mkDerivation.nix {
    inherit stdenv;
    unwrapped = gnuradio;
  };
  mkDerivation = mkDerivationWith stdenv.mkDerivation;

  callPackage = self.newScope {
    inherit (gnuradio)
      # Packages that are potentially overriden and commonly
      boost
      uhd
    ;
    inherit mkDerivationWith mkDerivation;
  };

in {

  inherit callPackage mkDerivation mkDerivationWith;

  ### Packages

  inherit gnuradio;

  osmosdr = callPackage ../development/gnuradio-modules/osmosdr/default.nix { };

  ais = callPackage ../development/gnuradio-modules/ais/default.nix { };

  gsm = callPackage ../development/gnuradio-modules/gsm/default.nix { };

  nacl = callPackage ../development/gnuradio-modules/nacl/default.nix { };

  rds = callPackage ../development/gnuradio-modules/rds/default.nix { };

  limesdr = callPackage ../development/gnuradio-modules/limesdr/default.nix { };

})
