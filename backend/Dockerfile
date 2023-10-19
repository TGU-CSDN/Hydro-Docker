ARG USE_MIRROR

FROM node:20-alpine
ADD ./entrypoint.sh /root/entrypoint.sh
RUN if [[ -z "$USE_MIRROR" ]] ; then npm config set registry https://registry.npmmirror.com ; fi
RUN npm i -g pm2 hydrooj @hydrooj/ui-default
RUN chmod +x /root/entrypoint.sh && \
    mkdir -p /root/.hydro
ENTRYPOINT /root/entrypoint.sh
