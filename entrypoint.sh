#!/usr/bin/env bash

set -x

ariang_js_path=/AriaNg/js/aria-ng*.js



if [ -n "$RPC_SECRET" ]; then

    if [ -n "$EMBED_RPC_SECRET" ]; then
        echo "Embedding RPC secret into ariang Web UI"
        RPC_SECRET_BASE64=$(echo -n "${RPC_SECRET}" | base64 -w 0)
        sed -i 's,secret:"[^"]*",secret:"'"${RPC_SECRET_BASE64}"'",g' "$ariang_js_path"
    fi
fi

if [ -n "$ARIA2RPCPORT" ]; then
    echo "Changing rpc request port to $ARIA2RPCPORT"
    sed -i "s/6800/${ARIA2RPCPORT}/g" "$ariang_js_path"
fi

exec "/darkhttpd" "/AriaNg" $@
