set -o noglob

ipget -o "$out" $ipgetOpts "$cid"

runHook postFetch
set +o noglob
exit 0

