{

description = "A utility to convert regular text into SIC format";

inputs = {
  nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "release-22.11";
  };
};

outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
  packages.x86_64-linux.default =
    pkgs.stdenv.mkDerivation {
      name = "format-sic";
      meta = {
        license = pkgs.lib.licenses.agpl3Plus;
        description = "A utility to convert regular text into SIC format";
      };
      src = ./src;
      buildInputs = [
        pkgs.ghc
      ];
      buildPhase = "ghc Main.hs -o format-sic";
      installPhase = "mkdir -p $out/bin; install -t $out/bin format-sic";
    };

  devShells.x86_64-linux.default = with pkgs;
    mkShell {
      packages = [
        ghcid
        hlint
      ];
      buildInputs = [
        ghc
      ];
    };
  };

}
