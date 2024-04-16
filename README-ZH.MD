# Hydro-Docker

> Docker 配置文件，用于部署 [Hydro-OJ](https://github.com/hydro-dev/Hydro)

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/TGU-CSDN/Hydro-Docker/build.yml?branch=main)

[English](./README.MD) / [中文](./README-ZH.MD)

## 使用方式

### 部署

有两种方式可以用于部署镜像。如果你的服务器架构为 arm64，推荐使用预编译的 Docker 镜像。

在开始前，请确保你正确安装了 Docker 和 Docker Compose。

#### 选项 1: 使用预编译的 Docker 镜像 （推荐）

⚠️ 预编译的 Docker 镜像只支持 arm64 架构。如果你的服务器是其他架构，请参考下一节“使用本地编译的镜像”。

1. 下载 compose 文件（预编译版本），将其命名为 `docker-compose.yml`

    ```shell
    wget -c "https://raw.githubusercontent.com/TGU-CSDN/Hydro-Docker/main/docker-compose-prebuilt-full.yml" -O docker-compose.yml
    ```

    对于中国大陆的用户，在访问 [ghcr.io](https://ghcr.io) 时可能会遇到网络问题。请考虑使用镜像源，例如 [DaoCloud](https://github.com/DaoCloud/public-image-mirror)。

2. 启动容器

    ```shell
    sudo docker compose up -d
    ```

#### 选项 2: 使用本地编译的镜像

1. 克隆这个 Git 项目
2. 启动容器

    ```shell
    sudo docker compose up -d
    ```

    对于中国大陆的用户，可以使用配置了镜像加速的 compose 文件：

    ```shell
    sudo docker compose -f docker-compose-build-with-mirror.yml up -d
    ```

在部署之后，所有容器应该正常启动并运行。你可以使用命令 `sudo docker compose ps` 来检查容器的运行情况。

默认情况下，容器会监听 80 端口。你可以通过 `http://localhost` 来访问 OJ。

### 配置

容器启动后，会在 compose 文件的同级目录下自动创建一个 `data` 目录。

首次安装时，程序会自动创建一个超级管理员用户（用户名 `root` / 密码 `rootroot`）。 你**必须**通过 Web UI 或 Hydro CLI 修改默认密码。

在修改密码后，**必须**使用新的密码更新评测服务的配置文件 `./data/judge/judge.yaml`。之后需要重启评测服务：

```shell
sudo docker compose restart oj-judge
```

## 授权许可

[MIT License](./LICENSE)
