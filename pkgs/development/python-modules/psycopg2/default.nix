{ stdenv
, lib
, buildPythonPackage
, pythonOlder
, isPyPy
, fetchPypi
, postgresql
, openssl
, sphinxHook
, sphinx-better-theme
}:

buildPythonPackage rec {
  pname = "psycopg2";
  version = "2.9.5";
  outputs = [ "out" "doc" ];

  # Extension modules don't work well with PyPy. Use psycopg2cffi instead.
  # c.f. https://github.com/NixOS/nixpkgs/pull/104151#issuecomment-729750892
  disabled = pythonOlder "3.6" || isPyPy;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-pSRtLmg6ly4hh6hxS1ws+BVsBkYp+amxqHPBcw2eJFo=";
  };

  nativeBuildInputs = [
    postgresql
    sphinxHook
    sphinx-better-theme
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    openssl
  ];

  sphinxRoot = "doc/src";

  # requires setting up a postgresql database
  doCheck = false;

  pythonImportsCheck = [ "psycopg2" ];

  meta = with lib; {
    description = "PostgreSQL database adapter for the Python programming language";
    homepage = "https://www.psycopg.org";
    license = with licenses; [ lgpl3 zpl20 ];
    maintainers = with maintainers; [ ];
  };
}
