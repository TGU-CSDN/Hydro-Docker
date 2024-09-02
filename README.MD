# Hydro-Docker

> Docker Deployment Config of [Hydro-OJ](https://github.com/hydro-dev/Hydro)

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/TGU-CSDN/Hydro-Docker/build.yml?branch=main)

[English](./README.MD) / [中文](./README-ZH.MD)

## Usage

### Deployment

There are two ways to deploy the services. We highly recommend using the prebuilt Docker image if you have a server with an amd64 architecture.

Before you start, make sure you have Docker with Docker Compose installed.

#### Choice 1: Use Prebuilt Docker Images (Recommended)

⚠️ The precompiled image only supports environments with the amd64 architecture. If you wish to run it on other architectures, please refer to the section "Using Locally Compiled Images."

1. Download the example compose file (prebuilt version) and name it `docker-compose.yml`

    ```shell
    wget -c "https://raw.githubusercontent.com/TGU-CSDN/Hydro-Docker/main/docker-compose-prebuilt-full.yml" -O docker-compose.yml
    ```

    For users in China, you may encounter network problems when accessing [ghcr.io](https://ghcr.io). To solve this problem, we have prepared a compose file with mirrored acceleration. You can replace the above command with the following one:

    ```shell
    wget -c "https://raw.githubusercontent.com/TGU-CSDN/Hydro-Docker/main/docker-compose-prebuilt-full-china-mirrored.yml" -O docker-compose.yml
    ```

2. Start containers

    ```shell
    sudo docker compose up -d
    ```

#### Choice 2: Using Locally Compiled Images

1. Clone this repository
2. Start containers

    ```shell
    sudo docker compose up -d
    ```

    For Chinese users, you can use the compose file with mirror already set.

    ```shell
    sudo docker compose -f docker-compose-build-with-mirror.yml up -d
    ```

After the deployment, all containers should be created and running. You can simply run the command `sudo docker compose ps` to check it.

By default, the port 80 is listened. You can visit the system by opening `http://localhost`.

### Configuration

After containers start, there should be a folder named `data` located at the same level directory as your compose file.

The first installation will create a super admin user with the username `root` and password `rootroot`. You **MUST** change the password either through the Web UI or Hydro CLI.

After changing the password, you **MUST** update the config file at `./data/judge/judge.yaml` with the new password. Then you should restart the judge service:

```shell
sudo docker compose restart oj-judge
```

## License

[MIT License](./LICENSE)
