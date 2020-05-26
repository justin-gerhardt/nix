{ pkgs ? import <nixpkgs> { }, stdenv }:

pkgs.symlinkJoin {
  name = "code";
  paths = [
    (pkgs.vscode-with-extensions.overrideAttrs (oldAttrs: rec {
      vscodeExtensions = with pkgs.vscode-extensions;
        [ ms-vscode.cpptools ms-python.python bbenoist.Nix ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
          publisher = "brettm12345";
          name = "nixfmt-vscode";
          version = "0.0.1";
          sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
        }];
    }))
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/code --prefix PATH ":" ${
      stdenv.lib.makeBinPath [ pkgs.nixfmt ]
    }
  '';
}

