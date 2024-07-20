{ stdenv
, lib
, fetchFromGitHub
, wrapGAppsHook4
, meson
, libadwaita
, gjs
, gtk4
, desktop-file-utils
, ninja
, glib
, graphene
, pango
, harfbuzz
, gdk-pixbuf
, libsoup_3
, ...
}:
stdenv.mkDerivation rec {
  pname = "libellus";
  version = "1.0.5";
  src = fetchFromGitHub {
    repo = "Libellus";
    owner = "qwertzuiopy";
    rev = "v${version}";
    hash = "sha256-y7nEZillssOKB8FdG+U/5yqpU2NQg9afxpp2DoPx3IE=";
  };
  patches = [ ./set-gjs-entrypoint.patch ];
  nativeBuildInputs = [
    meson
    desktop-file-utils
    ninja
    wrapGAppsHook4
    gjs
  ];
  GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" [
    glib.out
    gtk4
    graphene
    pango.out
    harfbuzz
    gdk-pixbuf
    libadwaita
    libsoup_3
  ];
  postInstall = ''
    mv $out/bin/de.hummdudel.Libellus $out/bin/libellus
  '';
}
