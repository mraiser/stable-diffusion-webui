with (import <nixpkgs> {});
let
  LLP = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
    gperftools
    libGL
    glib
    python311
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath LLP;
in  
stdenv.mkDerivation {
  name = "python-ai-env";
  buildInputs = LLP;
  src = null;
  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${R}/lib/R/lib:${LD_LIBRARY_PATH}
    export LD_PRELOAD=${pkgs.gperftools}/lib/libtcmalloc.so
  '';
}