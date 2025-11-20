{
  lib,
  stdenv,
  ipget,
}:
lib.fetchers.withNormalizedHash
  {
    hashTypes = [
      "sha1"
      "sha256"
      "sha512"
    ];
  }
  (
    {
      cid,
      name ? "ipfs-${cid}",
      ipgetOpts ? "",
      outputHash,
      outputHashAlgo,
      meta ? { },
      postFetch ? "",
      preferLocalBuild ? true,
    }:
    stdenv.mkDerivation {
      inherit name;
      builder = ./builder.sh;
      nativeBuildInputs = [ ipget ];

      # New-style output content requirements.
      inherit outputHash outputHashAlgo;
      outputHashMode = "recursive";

      inherit
        ipgetOpts
        postFetch
        cid
        meta
        ;

      inherit preferLocalBuild;
    }
  )
