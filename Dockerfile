FROM p3terx/ariang:latest AS base

FROM alpine:latest

RUN apk add --no-cache bash

COPY --from=base /darkhttpd /darkhttpd
COPY --from=base /AriaNg /AriaNg

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]