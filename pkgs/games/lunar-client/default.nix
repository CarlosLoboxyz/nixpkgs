{ appimageTools, lib, fetchurl, makeDesktopItem }:

let
  name = "lunar-client";
  version = "2.8.8";

  desktopItem = makeDesktopItem {
    name = "Lunar Client";
    exec = "lunar-client";
    icon = "lunarclient";
    comment = "Minecraft 1.7, 1.8, 1.12, 1.15, and 1.16 Client";
    desktopName = "Lunar Client";
    genericName = "Minecraft Client";
    categories = "Game;";
  };

  appimageContents = appimageTools.extract {
    inherit name src;
  };

  src = fetchurl {
    url = "https://launcherupdates.lunarclientcdn.com/Lunar%20Client-${version}.AppImage";
    name = "lunar-client.AppImage";
    sha256 = "sha256-zPu0rc/Qi6+EyHXeXRJfkPHKK6Hr1JsENBvLt8a9WBM=";
  };
in appimageTools.wrapType1 rec {
  inherit name src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
    cp -r ${appimageContents}/usr/share/icons/ $out/share/
  '';

  extraPkgs = pkgs: [ pkgs.libpulseaudio ];

  meta = with lib; {
    description = "Minecraft 1.7, 1.8, 1.12, 1.15, and 1.16 Client";
    homepage = "https://www.lunarclient.com/";
    license = with licenses; [ unfree ];
    maintainers = with maintainers; [ zyansheep Technical27 ];
    platforms = [ "x86_64-linux" ];
  };
}
