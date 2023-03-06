#!/usr/bin/env bash


ariang_js_path=/AriaNg/js/aria-ng*.js



if [ -n "$RPC_SECRET" ]; then
    echo "Embedding RPC secret into ariang Web UI"
    RPC_SECRET_BASE64=$(echo -n "${RPC_SECRET}" | base64 -w 0)
    sed -i 's,secret:"[^"]*",secret:"'"${RPC_SECRET_BASE64}"'",g' $ariang_js_path

fi


if [ -n "$ARIA2_RPC_HOST" ]; then
    echo "Changing rpc request port to $ARIA2_RPC_HOST"
    sed -i 's,rpcHost:"[^"]*",rpcHost:"'"${ARIA2_RPC_HOST}"'",g' $ariang_js_path
fi

if [ -n "$ARIA2_RPC_PORT" ]; then
    echo "Changing rpc request port to $ARIA2_RPC_PORT"
    sed -i "s/6800/${ARIA2_RPC_PORT}/g" $ariang_js_path
fi

exec "/darkhttpd" "/AriaNg" $@
