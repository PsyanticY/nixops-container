{ nixopscontainer ? { outPath = ./.; revCount = 0; shortRev = "abcdef"; rev = "HEAD"; }
, nixpkgs ? <nixpkgs>
, officialRelease ? false
}:
let
  pkgs = import nixpkgs {};
  version =  "1.7" + (if officialRelease then "" else "pre${toString nixopscontainer.revCount}_${nixopscontainer.shortRev}");
in
  rec {
    build = pkgs.lib.genAttrs [ "x86_64-linux" "i686-linux" "x86_64-darwin" ] (system:
      with import nixpkgs { inherit system; };
      python2Packages.buildPythonApplication rec {
        name = "nixops-container";
        src = ./.;
        prePatch = ''
          for i in setup.py; do
            substituteInPlace $i --subst-var-by version ${version}
          done
        '';
        postInstall = ''
          mkdir -p $out/share/nix/nixops-container
          cp -av nix/* $out/share/nix/nixops-container
        '';
        meta.description = "NixOps NixOS Container backend for ${stdenv.system}";
      }
    );
  }


