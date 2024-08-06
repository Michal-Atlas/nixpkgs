{ lib, python3Packages, fetchPypi, ... }:
with python3Packages; buildPythonPackage rec {
  pname = "waybackpack";
  version = "0.6.4";
  format = "pyproject";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-QySXOpaB3gzZMxupmLu7QEhkts36DuhSCre+s6HIjJo=";
  };
  build-system = [ setuptools ];
  dependencies = [ requests ];
  meta = {
    description = "cli tool that downloads the entire Wayback Machine archive for a given URL";
    license = lib.licenses.mit;
  };
}
