{

description = "A utility to print SIC formated text correctly";

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
    ghc = pkgs.haskellPackages.ghcWithPackages
      (a: with a; [
        ansi-terminal
      ]);
  in {
  packages.x86_64-linux.default =
    pkgs.stdenv.mkDerivation {
      name = "cat-sic";
      meta = {
        license = pkgs.lib.licenses.agpl3Plus;
        description = "A utility to print SIC formated text correctly";
      };
      src = ./src;
      buildInputs = [
        ghc
      ];
      buildPhase = "ghc Main.hs -o cat-sic";
      installPhase = "mkdir -p $out/bin; install -t $out/bin cat-sic";
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
