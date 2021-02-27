{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pythonDeps = pkgs.python39.withPackages (p: with p; [ flask ]);
    in {

      devShell."${system}" = with pkgs;
        mkShell { buildInputs = [ pythonDeps ]; };

      defaultPackage."${system}" = with pkgs;
      writeScriptBin "launch-ctf" ''
        ls -hal
        ${bubblewrap}/bin/bwrap \
        --symlink ${./app.py} /app.py \
        --ro-bind FLAG /FLAG \
        --ro-bind /nix/store /nix/store \
        -- ${pythonDeps}/bin/flask run
      '';
    };
}
