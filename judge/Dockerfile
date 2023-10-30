FROM node:20

SHELL [ "/bin/bash", "-c" ]
ENV SHELL=/bin/bash

# Set true if you are in China
ARG USE_MIRROR

# Set https://mirrors.bfsu.edu.cn/nix/latest/install if you are in China
ARG NIX_INSTALLER_URL=https://nixos.org/nix/install

# Set https://ghproxy.com/https://github.com/criyle/go-judge/releases/download/v1.6.10/executorserver_1.6.10_linux_amd64 if you are in China
ARG GO_JUDGE_URL=https://github.com/criyle/go-judge/releases/download/v1.6.10/executorserver_1.6.10_linux_amd64

# Set up environment
ADD ${NIX_INSTALLER_URL} /tmp/install_nix

RUN if [[ -n "$USE_MIRROR" ]] ; then \
    sh /tmp/install_nix --daemon --no-channel-add \
    ; else  \
    sh /tmp/install_nix --daemon \
    ; fi

ENV PATH="$PATH:/root/.nix-profile/bin"
ENV NIXPKGS_ALLOW_INSECURE=1

RUN if [[ -n "$USE_MIRROR" ]] ; then echo 'substituters = https://mirrors.bfsu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/' > /etc/nix/nix.conf ; fi
RUN if [[ -n "$USE_MIRROR" ]] ; then nix-channel --add https://mirrors.bfsu.edu.cn/nix-channels/nixpkgs-unstable nixpkgs ; fi

RUN nix-channel --update

RUN if [[ -z "$USE_MIRROR" ]] ; then yarn config set registry https://registry.npmmirror.com/ ; fi

# syntax=docker/dockerfile:1

# Build rootfs
WORKDIR /nix_build

COPY hydro-nix-channel .

RUN nix-build --attr judge

RUN ln -sf result /root/.nix-profile

# Init Judge
RUN mkdir -p /root/.hydro
ADD ./runtime/scripts/entrypoint.sh /root/entrypoint.sh
ADD ./runtime/scripts/run-sandbox.sh /root/run-sandbox.sh
ADD ./runtime/config/judge.yaml /tmp/.hydro/judge.yaml
ADD ./runtime/config/mount.yaml /tmp/.hydro/mount.yaml
RUN chmod +x /root/run-sandbox.sh
RUN chmod +x /root/entrypoint.sh

RUN yarn global add pm2 @hydrooj/hydrojudge
RUN wget ${GO_JUDGE_URL} -O /usr/bin/sandbox && \
    chmod +x /usr/bin/sandbox

ENTRYPOINT /root/entrypoint.sh
