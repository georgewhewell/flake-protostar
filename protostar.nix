{ source
, poetry2nix
, pkgs
}:

pkgs.poetry2nix.mkPoetryApplication {
  name = "protostar";
  python = pkgs.python39;
  projectDir = source;

  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
    altgraph = super.altgraph.overridePythonAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ super.setuptools ];
    });

    argparse = super.argparse.overridePythonAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ super.setuptools ];
    });

    pyinstaller = super.pyinstaller.overridePythonAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ pkgs.zlib ];
    });

    pyinstaller-hooks-contrib = super.pyinstaller-hooks-contrib.overridePythonAttrs (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [
          super.setuptools
        ];
      }
    );

    crypto-cpp-py = super.crypto-cpp-py.overridePythonAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ super.setuptools pkgs.cairo super.pip super.pipBuildHook pkgs.gtest ];
      dontUseCmakeConfigure = true;
      nativeBuildInputs = [ pkgs.cmake ];
      postPatch = ''
        patchShebangs ./build_extension.sh
        sed -i '/FetchContent_MakeAvailable/d' crypto-cpp/CMakeLists.txt
        # mkdir dist
      '';
      buildPhase = ''
        pipBuildPhase
      '';

    });

    starknet-devnet = super.starknet-devnet.overridePythonAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ super.poetry-core ];
    });

    starknet-py = super.starknet-py.overridePythonAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ super.setuptools ];
    });

    web3 = super.web3.overridePythonAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ super.setuptools ];
    });
  });

  postPatch = ''
    sed -i '/argparse/d' pyproject.toml
  '';

  postInstall = ''
    mkdir -p $out/bin
    echo "#!/usr/bin/env python" > $out/bin/protostar
    cat binary_entrypoint.py >> $out/bin/protostar
    chmod +x $out/bin/protostar
  '';
}
