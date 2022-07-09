## Ход работ по запуску приложений в Docker

#### 

```
root@node3:~/postgres-project# docker image list
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```

```
root@node3:~/postgres-project# docker up zakharovnpa/k8s-database:05.07.22
docker: 'up' is not a docker command.
See 'docker --help'
```
#### Docker Help
```
root@node3:~/postgres-project# docker --help

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/root/.docker")
  -c, --context string     Name of the context to use to connect to the daemon (overrides DOCKER_HOST env var and default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/root/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/root/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/root/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  builder     Manage builds
  config      Manage Docker configs
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.

To get more help with docker, check out our guides at https://docs.docker.com/go/guides/
```
#### Скачивание образа из Docker registry
```
root@node3:~/postgres-project# docker pull zakharovnpa/k8s-database:05.07.22
05.07.22: Pulling from zakharovnpa/k8s-database
2408cc74d12b: Pull complete 
cde4337df78d: Pull complete 
55ba5f494780: Pull complete 
56f1718fcdf5: Pull complete 
728c5f526fa3: Pull complete 
afa1a4a2aaab: Pull complete 
30dca59672f8: Pull complete 
a4fd8a42494f: Pull complete 
Digest: sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5
Status: Downloaded newer image for zakharovnpa/k8s-database:05.07.22
docker.io/zakharovnpa/k8s-database:05.07.22
```

```
root@node3:~/postgres-project# docker image list
REPOSITORY                 TAG        IMAGE ID       CREATED       SIZE
zakharovnpa/k8s-database   05.07.22   2bb8cea1e0bb   2 weeks ago   213MB
```

```
root@node3:~/postgres-project# docker run -d zakharovnpa/k8s-database:05.07.22 
5c4d0ba5181bb709081411902731d8cdeb2789aec0b968494636af4010ff9d3f
```

```
root@node3:~/postgres-project# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS                      PORTS     NAMES
5c4d0ba5181b   zakharovnpa/k8s-database:05.07.22   "docker-entrypoint.s…"   13 seconds ago   Exited (1) 12 seconds ago             cranky_jackson
```
#### Запуск сборки контейнеров на основе файла Docker-compose.yaml

```yml
version: "3.7"

services:
  frontend:
    build: ./frontend
    ports:
      - 8000:80

  backend:
    build: ./backend
    links:
      - db
    ports:
      - 9000:9000

  db:
    image: postgres:13-alpine
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```

```
root@node3:~/postgres-project# docker-compose up --build
[+] Running 1/1
 ⠿ db Pulled                                                                                                                                                                                                                  2.1s
[+] Running 2/2
 ⠿ Network postgres-project_default  Created                                                                                                                                                                                  0.1s
 ⠿ Container postgres-project-db-1   Created                                                                                                                                                                                  0.2s
Attaching to postgres-project-db-1
postgres-project-db-1  | The files belonging to this database system will be owned by user "postgres".
postgres-project-db-1  | This user must also own the server process.
postgres-project-db-1  | 
postgres-project-db-1  | The database cluster will be initialized with locale "en_US.utf8".
postgres-project-db-1  | The default database encoding has accordingly been set to "UTF8".
postgres-project-db-1  | The default text search configuration will be set to "english".
postgres-project-db-1  | 
postgres-project-db-1  | Data page checksums are disabled.
postgres-project-db-1  | 
postgres-project-db-1  | fixing permissions on existing directory /var/lib/postgresql/data ... ok
postgres-project-db-1  | creating subdirectories ... ok
postgres-project-db-1  | selecting dynamic shared memory implementation ... posix
postgres-project-db-1  | selecting default max_connections ... 100
postgres-project-db-1  | selecting default shared_buffers ... 128MB
postgres-project-db-1  | selecting default time zone ... UTC
postgres-project-db-1  | creating configuration files ... ok
postgres-project-db-1  | running bootstrap script ... ok
postgres-project-db-1  | performing post-bootstrap initialization ... sh: locale: not found
postgres-project-db-1  | 2022-07-08 13:49:42.191 UTC [30] WARNING:  no usable system locales were found
postgres-project-db-1  | ok
postgres-project-db-1  | syncing data to disk ... initdb: warning: enabling "trust" authentication for local connections
postgres-project-db-1  | You can change this by editing pg_hba.conf or using the option -A, or
postgres-project-db-1  | --auth-local and --auth-host, the next time you run initdb.
postgres-project-db-1  | ok
postgres-project-db-1  | 
postgres-project-db-1  | 
postgres-project-db-1  | Success. You can now start the database server using:
postgres-project-db-1  | 
postgres-project-db-1  |     pg_ctl -D /var/lib/postgresql/data -l logfile start
postgres-project-db-1  | 
postgres-project-db-1  | waiting for server to start....2022-07-08 13:49:43.423 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
postgres-project-db-1  | 2022-07-08 13:49:43.426 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres-project-db-1  | 2022-07-08 13:49:43.438 UTC [37] LOG:  database system was shut down at 2022-07-08 13:49:42 UTC
postgres-project-db-1  | 2022-07-08 13:49:43.443 UTC [36] LOG:  database system is ready to accept connections
postgres-project-db-1  |  done
postgres-project-db-1  | server started
postgres-project-db-1  | CREATE DATABASE
postgres-project-db-1  | 
postgres-project-db-1  | 
postgres-project-db-1  | /usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*
postgres-project-db-1  | 
postgres-project-db-1  | waiting for server to shut down...2022-07-08 13:49:43.856 UTC [36] LOG:  received fast shutdown request
postgres-project-db-1  | .2022-07-08 13:49:43.859 UTC [36] LOG:  aborting any active transactions
postgres-project-db-1  | 2022-07-08 13:49:43.861 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
postgres-project-db-1  | 2022-07-08 13:49:43.862 UTC [38] LOG:  shutting down
postgres-project-db-1  | 2022-07-08 13:49:43.886 UTC [36] LOG:  database system is shut down
postgres-project-db-1  |  done
postgres-project-db-1  | server stopped
postgres-project-db-1  | 
postgres-project-db-1  | PostgreSQL init process complete; ready for start up.
postgres-project-db-1  | 
postgres-project-db-1  | 2022-07-08 13:49:43.983 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
postgres-project-db-1  | 2022-07-08 13:49:43.983 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
postgres-project-db-1  | 2022-07-08 13:49:43.984 UTC [1] LOG:  listening on IPv6 address "::", port 5432
postgres-project-db-1  | 2022-07-08 13:49:43.990 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres-project-db-1  | 2022-07-08 13:49:43.998 UTC [50] LOG:  database system was shut down at 2022-07-08 13:49:43 UTC
postgres-project-db-1  | 2022-07-08 13:49:44.004 UTC [1] LOG:  database system is ready to accept connections


^CGracefully stopping... (press Ctrl+C again to force)
[+] Running 1/1
 ⠿ Container postgres-project-db-1  Stopped                                                                                                                                                                                   0.3s
canceled
```

```
root@node3:~/postgres-project# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS                      PORTS     NAMES
8861eb1f0723   postgres:13-alpine                  "docker-entrypoint.s…"   44 minutes ago   Exited (0) 8 seconds ago              postgres-project-db-1
5c4d0ba5181b   zakharovnpa/k8s-database:05.07.22   "docker-entrypoint.s…"   45 minutes ago   Exited (1) 45 minutes ago             cranky_jackson
```

```
root@node3:~/postgres-project# docker stop 5c4d0ba5181b 8861eb1f0723
5c4d0ba5181b
8861eb1f0723
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS                      PORTS     NAMES
8861eb1f0723   postgres:13-alpine                  "docker-entrypoint.s…"   45 minutes ago   Exited (0) 43 seconds ago             postgres-project-db-1
5c4d0ba5181b   zakharovnpa/k8s-database:05.07.22   "docker-entrypoint.s…"   46 minutes ago   Exited (1) 46 minutes ago             cranky_jackson
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker rm 5c4d0ba5181b 8861eb1f0723
5c4d0ba5181b
8861eb1f0723
```

```
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```
root@node3:~/postgres-project# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```
root@node3:~/postgres-project# docker image list
REPOSITORY                 TAG         IMAGE ID       CREATED       SIZE
zakharovnpa/k8s-database   05.07.22    2bb8cea1e0bb   2 weeks ago   213MB
postgres                   13-alpine   2bb8cea1e0bb   2 weeks ago   213MB
```

```
root@node3:~/postgres-project# docker run --name=postgres-sql -p 5432:5432 -d postgres:13-alpine 
12b360ebd3060e88b0bbd0d4d449eacfa638277cb430eeb0257b178945e40d51
```

```
root@node3:~/postgres-project# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS                      PORTS     NAMES
12b360ebd306   postgres:13-alpine   "docker-entrypoint.s…"   16 minutes ago   Exited (1) 16 minutes ago             postgres-sql
```

```
root@node3:~/postgres-project# docker stop 12b360ebd306
12b360ebd306
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker rm 12b360ebd306
12b360ebd306
```

```
root@node3:~/postgres-project# docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@node3:~/postgres-project# 
root@node3:~/postgres-project# docker image list
REPOSITORY                 TAG         IMAGE ID       CREATED       SIZE
zakharovnpa/k8s-database   05.07.22    2bb8cea1e0bb   2 weeks ago   213MB
postgres                   13-alpine   2bb8cea1e0bb   2 weeks ago   213MB
```
#### Запуск контейнера с командой `sleep 3600`
```
root@node3:~/postgres-project# docker run --name=postgres-sql -p 5432:5432 -d postgres:13-alpine sleep 3600 
39c9442e540cdc33c91f55f0eba006fd5d4b22b9b407b503122f7a8834fe081f
```

```
root@node3:~/postgres-project# docker ps
CONTAINER ID   IMAGE                COMMAND                  CREATED         STATUS         PORTS                                       NAMES
39c9442e540c   postgres:13-alpine   "docker-entrypoint.s…"   5 seconds ago   Up 4 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres-sql
```

```
root@node3:~/postgres-project# Connection to 51.250.0.250 closed by remote host.
Connection to 51.250.0.250 closed.

```
