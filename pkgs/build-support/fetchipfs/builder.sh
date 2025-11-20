set -o noglob

ipget -o "$out" "$cid"

runHook postFetch
set +o noglob
exit 0

