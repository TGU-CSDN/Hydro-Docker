ARG USE_MIRROR

FROM node:20

SHELL [ "/bin/bash", "-c" ]
ENV SHELL=/bin/bash

ADD ./entrypoint.sh /root/entrypoint.sh

RUN if [[ -z "$USE_MIRROR" ]] ; then yarn config set registry https://registry.npmmirror.com/ ; fi

RUN yarn global add pm2 hydrooj @hydrooj/ui-default

RUN chmod +x /root/entrypoint.sh && \
    mkdir -p /root/.hydro

ENTRYPOINT /root/entrypoint.sh
