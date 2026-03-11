{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  emacs-nox,
}:
stdenvNoCC.mkDerivation {
  name = "lisp-format";

  src = fetchFromGitHub {
    repo = "lisp-format";
    owner = "eschulte";
    rev = "088c8f78ca41204b44f2636275517ac09a2de6a9";
    hash = "sha256-L2Wl+UWQSiJYvzctyXrMQNViZiZ6Q5vgek1PWkIaTn4=";
  };
  patchPhase = ''
    for f in test/*/.lisp-format; do
        # Due to cl/cl-lib issues the test otherwise fails to find symbols
        sed -i "s|-\*-$|-*-\n(require 'cl)\n|" "$f"
    done;
    patchShebangs --host .

    substituteInPlace lisp-format \
      --replace-fail 'exec emacs' 'exec ${emacs-nox}/bin/emacs'

    # Remove /dev/null: Useful when debugging test failures
    # add-tabs-default: This test is broken
    substituteInPlace Makefile \
      --replace-fail './check >/dev/null 2>/dev/null' './check' \
      --replace-fail 'add-tabs-default' '''
  '';
  dontBuild = true;
  doCheck = true;
  checkPhase = ''
    make check
  '';

  installPhase = ''
    mkdir -vp $out/bin
    cp -v lisp-format $out/bin
  '';

  meta = {
    description = "Tool to format lisp code. Designed to mimic clang-format";
    mainProgram = "lisp-format";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
