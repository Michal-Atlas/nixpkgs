{ lib
, asn1crypto
, buildPythonPackage
, fetchFromGitHub
, setuptools
, passlib
, pytest-mock
, pytestCheckHook
, pythonOlder
, versioningit
}:

buildPythonPackage rec {
  pname = "scramp";
  version = "1.4.3";
  format = "pyproject";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "tlocke";
    repo = "scramp";
    rev = version;
    sha256 = "sha256-BKZam2zLS/SK6rqiUkoeFpQ0bO4pU8CKVNhOM1fv10Y=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    asn1crypto
  ];

  checkInputs = [
    passlib
    pytest-mock
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'dynamic = ["version"]' 'version = "${version}"'
  '';

  pythonImportsCheck = [ "scramp" ];

  meta = with lib; {
    description = "Implementation of the SCRAM authentication protocol";
    homepage = "https://github.com/tlocke/scramp";
    license = licenses.mit;
    maintainers = with maintainers; [ jonringer ];
  };
}
