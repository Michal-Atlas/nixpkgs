{ lib, buildPythonPackage, fetchPypi, protobuf, grpcio, setuptools }:

buildPythonPackage rec {
  pname = "grpcio-tools";
  version = "1.48.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-iQKgNXCFVc3b1htUZ86hJ0hDYt7MUt4D8GGhpSD+kM0=";
  };

  postPatch = ''
    substituteInPlace setup.py \
    --replace 'protobuf>=3.12.0, < 4.0dev' 'protobuf'
  '';

  outputs = [ "out" "dev" ];

  enableParallelBuilding = true;

  propagatedBuildInputs = [ protobuf grpcio setuptools ];

  # no tests in the package
  doCheck = false;

  pythonImportsCheck = [ "grpc_tools" ];

  meta = with lib; {
    description = "Protobuf code generator for gRPC";
    license = licenses.asl20;
    homepage = "https://grpc.io/grpc/python/";
    maintainers = with maintainers; [ ];
  };
}
