{ pkgs ? import <nixpkgs> { }, stdenv }:

 pkgs.symlinkJoin {
   name = "code";
   paths = [
    (pkgs.vscode-with-extensions.override ({
      vscodeExtensions = with pkgs.vscode-extensions;
        [ ms-vscode.cpptools ms-python.python bbenoist.Nix ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            publisher = "brettm12345";
            name = "nixfmt-vscode";
            version = "0.0.1";
            sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
          }
          {
            publisher = "ritwickdey";
            name = "liveserver";
            version = "5.6.1";
            sha256 = "077arf3hsn1yb8xdhlrax5gf93ljww78irv4gm8ffmsqvcr1kws0";
          }

        ];
    }))
   ];
   buildInputs = [ pkgs.makeWrapper ];
   postBuild = ''
     wrapProgram $out/bin/code --prefix PATH ":" ${
       stdenv.lib.makeBinPath [ pkgs.nixfmt ]
     }
   '';
 }

