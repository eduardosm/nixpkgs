{ stdenv
, unwrapped
}:

mkDerivation:

args:

# Check if it's supposed to not get built for the current gnuradio version
if (builtins.hasAttr "disabled" args) && (builtins.elem unwrapped.versionAttr.major args.disabled) then
let name = args.name or "${args.pname}-${args.version}"; in
throw "Package ${name} is incompatible with GNURadio ${unwrapped.versionAttr.major}"
else

let
  args_ = {
    enableParallelBuilding = args.enableParallelBuilding or true;
    nativeBuildInputs = (args.nativeBuildInputs or []);
    # We add gnuradio itself by default
    buildInputs = (args.buildInputs or []) ++ [ unwrapped ];
  };
in mkDerivation (args // args_)
