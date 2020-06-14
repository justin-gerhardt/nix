{ pkgs ? import <nixpkgs> { }, stdenv, buildEnv }:
let

  vscodeExtensions = with pkgs.vscode-extensions;
    [matklad.rust-analyzer ms-vscode.cpptools ms-python.python bbenoist.Nix ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        publisher = "brettm12345";
        name = "nixfmt-vscode";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      {
        publisher = "webfreak";
        name = "debug";
        version = "0.25.0";
        sha256 = "0qm2jgkj17a0ca5z21xbqzfjpi0hzxw4h8y2hm8c4kk2bnw02sh1";
      }
      {
        publisher = "ritwickdey";
        name = "liveserver";
        version = "5.6.1";
        sha256 = "077arf3hsn1yb8xdhlrax5gf93ljww78irv4gm8ffmsqvcr1kws0";
      }
      {
        publisher = "lextudio";
        name = "restructuredtext";
        version = "128.0.0";
        sha256 = "16cs2bqhmkx2prdnkm6fy3qg1xqiyy445wr4l8y2ls9c61ax2cjm";
      }
      {
        publisher = "njpwerner";
        name = "autodocstring";
        version = "0.5.2";
        sha256 = "1gmcri5mklg2wnayi9zccgr34bx828srzwb3dmnzqirj6jsybv72";
      }
      {
        publisher = "arrterian";
        name = "nix-env-selector";
        version = "0.1.2";
        sha256 = "1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
      }
      {
        publisher = "ms-vscode";
        name = "node-debug2";
        version = "1.42.2";
        sha256 = "151w3nqqxjk58xnyckii9dcglk59z4g8ii3vyz6xbbvdrilmms8l";
      }

    ];

in pkgs.symlinkJoin {
  name = "code";
  paths = [
    (pkgs.vscode-with-extensions.override ({
      vscodeExtensions = vscodeExtensions;
    }))
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/code --prefix PATH ":" ${
      stdenv.lib.makeBinPath [ pkgs.nixfmt ]
    }
  '';
}

