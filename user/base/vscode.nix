{ stdenv, buildEnv }:
let
  nixpkgs = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/archive/871ca2455a75af983dafa16a01de3df09e15c497.tar.gz";
    sha256 = "0fyv7c8npba6j2yzh614p97xmwa9d3a3hshlknpmjvznwx8kh05w";
  };

  pkgs = import nixpkgs { config = {allowUnfree = true;}; };

  vscodeExtensions = with pkgs.vscode-extensions;
    [
      matklad.rust-analyzer
      ms-vscode.cpptools
      ms-python.python
      vadimcn.vscode-lldb
      bbenoist.Nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      {
        publisher = "be5invis";
        name = "toml";
        version = "0.5.1";
        sha256 = "1r1y6krqw5rrdhia9xbs3bx9gibd1ky4bm709231m9zvbqqwwq2j";
      }
      {
        publisher = "marus25";
        name = "cortex-debug";
        version = "0.3.7";
        sha256 = "0v1i7h0rz7r1xsbmz6xvczaiqg7i1a8c4kadb97ynpgaykbi26cd";
      }
      {
        publisher = "ms-vscode-remote";
        name = "remote-ssh";
        version = "0.55.0";
        sha256 = "1rzdz6539zbqsh3ikwmysz0587s1p5w72bqry17147s7hk513gn0";
      }

      {
        publisher = "spadin";
        name = "remote-x11";
        version = "1.4.1";
        sha256 = "1491asnddi6gd7z71dpgs3dk723l2llmhzhzkh2cb2szmh6g9r98";
      }
      {
        publisher = "spadin";
        name = "remote-x11-ssh";
        version = "1.4.0";
        sha256 = "1qsac6rz905jhpj3xmpzrk0fwifpqwbnrnivz66byhzjy41jdjr3";
      }

      {
        publisher = "13xforever";
        name = "language-x86-64-assembly";
        version = "2.3.0";
        sha256 = "0lfbkvpwmvrsfzpvf0p0g2nnq1qg5p173vd5m4idq90r2vzypwg1";
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

