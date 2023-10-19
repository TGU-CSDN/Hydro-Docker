#!/bin/sh

set -ex

cd judge

if [[ -n $USE_MIRROR ]]; then
  docker build -t hydrooj/judge:latest  \
    --build-arg USE_MIRROR=true \
    --build-arg NIX_INSTALLER_URL=https://mirrors.bfsu.edu.cn/nix/latest/install \
    --build-arg GO_JUDGE_URL=https://ghproxy.com/https://github.com/criyle/go-judge/releases/download/v1.6.10/executorserver_1.6.10_linux_amd64 \
    .
else
  docker build -t hydrooj/judge:latest .
fi

cd ../backend

if [[ -n $USE_MIRROR ]]; then
  docker build -t hydrooj/backend:latest --build-arg USE_MIRROR=true .
else
  docker build -t hydrooj/backend:latest .
fi