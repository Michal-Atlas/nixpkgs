{ lib, fetchPypi, buildPythonPackage, hatchling }:

buildPythonPackage rec {
  pname = "colorama";
  version = "0.4.6";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-CGlfXLftbgUxogVyaXKXJzxHuMrlpj/8bW7VwgG+bkQ=";
  };

  # No tests in archive
  doCheck = false;

  nativeBuildInputs = [
    hatchling
  ];

  pythonImportsCheck = [ "colorama" ];

  meta = with lib; {
    description = "Cross-platform colored terminal text";
    homepage = "https://github.com/tartley/colorama";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}

