{ pkgs, ... }: {
  home.packages = [
    pkgs.kicad
    (pkgs.makeDesktopItem {
      name = "KiCad";
      exec = "kicad";
      comment = "Electronic Design Automation suite";
      desktopName = "KiCad";
      genericName = "EDA Suite";
      categories = "Development;Electronics;";
      mimeType = "application/x-kicad-project;";
    })
  ];
}

