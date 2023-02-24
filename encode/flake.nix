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
		pkgs = import nixpkgs { system = "x86_64-linux"; };
	in {
	packages.x86_64-linux.default =
		pkgs.stdenv.mkDerivation {
			name = "encode-sic";
			meta = {
				license = pkgs.lib.licenses.agpl3Plus;
				description = "A utility to convert regular text into SIC format";
			};
			src = ./src;
			buildInputs = [
				pkgs.ghc
			];
			buildPhase = "ghc Main.hs -o encode-sic";
			installPhase = "mkdir -p $out/bin; install -t $out/bin encode-sic";
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
