# syntax=docker/dockerfile:1

FROM node:20

SHELL [ "/bin/bash", "-c" ]
ENV SHELL=/bin/bash

# Set true if you are in China
ARG USE_MIRROR

# Set https://mirrors.bfsu.edu.cn/nix/latest/install if you are in China
ARG NIX_INSTALLER_URL=https://nixos.org/nix/install

# Set up environment
ADD ./runtime/config/nix /tmp/nix_config
ADD ${NIX_INSTALLER_URL} /tmp/install_nix

RUN if [[ -n "$USE_MIRROR" ]] ; then \
    sh /tmp/install_nix --daemon --no-channel-add \
    ; else  \
    sh /tmp/install_nix --daemon \
    ; fi

ENV PATH="$PATH:/root/.nix-profile/bin"
ENV NIXPKGS_ALLOW_INSECURE=1

RUN if [[ -n "$USE_MIRROR" ]] ; then mv /tmp/nix_config/nix.cn.conf /etc/nix/nix.conf ; else mv /tmp/nix_config/nix.conf /etc/nix/nix.conf ; fi
RUN if [[ -n "$USE_MIRROR" ]] ; then nix-channel --add https://mirrors.bfsu.edu.cn/nix-channels/nixpkgs-unstable nixpkgs ; fi

RUN nix-channel --add https://nix-channel.hydro.ac/ hydro

RUN nix-channel --update

RUN if [[ -n "$USE_MIRROR" ]] ; then yarn config set registry https://registry.npmmirror.com/ ; fi

# Build rootfs
WORKDIR /nix_build
RUN nix build --file /tmp/nix_config/judge-env.nix

# Init Judge
RUN mkdir -p /root/.hydro
ADD ./runtime/scripts/entrypoint.sh /root/entrypoint.sh
ADD ./runtime/config/judge.yaml /tmp/.hydro/judge.yaml
ADD ./runtime/config/mount.yaml /tmp/.hydro/mount.yaml
ADD ./runtime/config/pm2.json /root/pm2.json
RUN chmod +x /root/entrypoint.sh

RUN yarn global add pm2 @hydrooj/hydrojudge

ENTRYPOINT /root/entrypoint.sh
