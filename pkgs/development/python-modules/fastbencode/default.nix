{ lib
, buildPythonPackage
, fetchPypi
, python
, pythonOlder
, cython
}:

buildPythonPackage rec {
  pname = "fastbencode";
  version = "0.0.16";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-MBEOb+5BCKWCpbwiOCTxG+1yeVbOnMQGmtfc/efcJ+0=";
  };

  nativeBuildInputs = [
    cython
  ];

  pythonImportsCheck = [
    "fastbencode"
  ];

  checkPhase = ''
    ${python.interpreter} -m unittest fastbencode.tests.test_suite
  '';

  meta = with lib; {
    description = "Fast implementation of bencode";
    homepage = "https://github.com/breezy-team/fastbencode";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ marsam ];
  };
}
