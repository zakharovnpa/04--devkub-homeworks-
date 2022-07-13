### Логи при выполнении сборки образов с помощью Docker-compose

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/zakharovnpa# docker-compose up --build
Sending build context to Docker daemon  112.2kB
Step 1/15 : FROM node:lts-buster as builder
 ---> b9f398d30e45
Step 2/15 : RUN mkdir /app
 ---> Using cache
 ---> f16fcbd21ee6
Step 3/15 : WORKDIR /app
 ---> Using cache
 ---> 6812598cb3ad
Step 4/15 : ADD package.json /app/package.json
 ---> Using cache
 ---> 6e4c1b5ae040
Step 5/15 : ADD package-lock.json /app/package-lock.json
 ---> Using cache
 ---> ecef30491f9a
Step 6/15 : RUN npm i
 ---> Using cache
 ---> a154e3d6e8c3
Step 7/15 : ADD . /app
 ---> Using cache
 ---> 77bfd76ef3e7
Step 8/15 : RUN npm run build && rm -rf /app/node_modules
 ---> Using cache
 ---> 9b9178191a65
Step 9/15 : FROM nginx:latest
 ---> 55f4b40fe486
Step 10/15 : ENV BASE_URL=http://b-pod:9000
 ---> Using cache
 ---> e49e73744255
Step 11/15 : RUN mkdir /app
 ---> Using cache
 ---> a7d919ef6b97
Step 12/15 : WORKDIR /app
 ---> Using cache
 ---> 8cdb681962b4
Step 13/15 : COPY --from=builder /app/ /app
 ---> Using cache
 ---> 4c633297da24
Step 14/15 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Using cache
 ---> 22e0130f4034
Step 15/15 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> Using cache
 ---> dc84bb688414
Successfully built dc84bb688414
Successfully tagged zakharovnpa_frontend:latest

```
```
Sending build context to Docker daemon  5.809kB
Step 1/9 : FROM python:3.9-buster
 ---> 999912f2c071
Step 2/9 : ENV DATABASE_URL=postgres://postgres:postgres@db:5432/news
 ---> Using cache
 ---> 056877d49c98
Step 3/9 : RUN mkdir /app && python -m pip install pipenv
 ---> Using cache
 ---> 585528af6188
Step 4/9 : WORKDIR /app
 ---> Using cache
 ---> 08d231da8d94
Step 5/9 : ADD Pipfile /app/Pipfile
 ---> Using cache
 ---> dd15e82f6759
Step 6/9 : ADD Pipfile.lock /app/Pipfile.lock
 ---> Using cache
 ---> 1b042e242d4e
Step 7/9 : RUN pipenv install
 ---> Using cache
 ---> 01e0930173c1
Step 8/9 : ADD main.py /app/main.py
 ---> Using cache
 ---> f70ad4c3ce94
Step 9/9 : CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000
 ---> Using cache
 ---> 5d97bf6ad02f
Successfully built 5d97bf6ad02f
Successfully tagged zakharovnpa_backend:latest
```
```
Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
[+] Running 4/4
 ⠿ Network zakharovnpa_default       Created                                                                                                                                                             0.1s
 ⠿ Container zakharovnpa-frontend-1  Created                                                                                                                                                             0.1s
 ⠿ Container zakharovnpa-db-1        Created                                                                                                                                                             0.1s
 ⠿ Container zakharovnpa-backend-1   Created                                                                                                                                                             0.1s
Attaching to zakharovnpa-backend-1, zakharovnpa-db-1, zakharovnpa-frontend-1

```
```
zakharovnpa-frontend-1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
zakharovnpa-frontend-1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
zakharovnpa-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
zakharovnpa-frontend-1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
zakharovnpa-frontend-1  | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
zakharovnpa-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
zakharovnpa-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
zakharovnpa-frontend-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
zakharovnpa-db-1        | The files belonging to this database system will be owned by user "postgres".
zakharovnpa-db-1        | This user must also own the server process.
zakharovnpa-db-1        | 
zakharovnpa-db-1        | The database cluster will be initialized with locale "en_US.utf8".
zakharovnpa-db-1        | The default database encoding has accordingly been set to "UTF8".
zakharovnpa-db-1        | The default text search configuration will be set to "english".
zakharovnpa-db-1        | 
zakharovnpa-db-1        | Data page checksums are disabled.
zakharovnpa-db-1        | 
zakharovnpa-db-1        | fixing permissions on existing directory /var/lib/postgresql/data ... ok
zakharovnpa-db-1        | creating subdirectories ... ok
zakharovnpa-db-1        | selecting dynamic shared memory implementation ... posix
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: using the "epoll" event method
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: nginx/1.23.0
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: OS: Linux 5.13.0-52-generic
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker processes
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 30
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 31
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 32
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 33
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 34
zakharovnpa-frontend-1  | 2022/07/13 07:44:45 [notice] 1#1: start worker process 35
zakharovnpa-db-1        | selecting default max_connections ... 100
zakharovnpa-db-1        | selecting default shared_buffers ... 128MB
zakharovnpa-db-1        | selecting default time zone ... UTC
zakharovnpa-db-1        | creating configuration files ... ok
zakharovnpa-db-1        | running bootstrap script ... ok
zakharovnpa-db-1        | performing post-bootstrap initialization ... sh: locale: not found
zakharovnpa-db-1        | 2022-07-13 07:44:46.447 UTC [30] WARNING:  no usable system locales were found
zakharovnpa-db-1        | ok
zakharovnpa-db-1        | syncing data to disk ... initdb: warning: enabling "trust" authentication for local connections
zakharovnpa-db-1        | You can change this by editing pg_hba.conf or using the option -A, or
zakharovnpa-db-1        | --auth-local and --auth-host, the next time you run initdb.
zakharovnpa-db-1        | ok
zakharovnpa-db-1        | 
zakharovnpa-db-1        | 
zakharovnpa-db-1        | Success. You can now start the database server using:
zakharovnpa-db-1        | 
zakharovnpa-db-1        |     pg_ctl -D /var/lib/postgresql/data -l logfile start
zakharovnpa-db-1        | 
zakharovnpa-db-1        | waiting for server to start....2022-07-13 07:44:47.529 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
zakharovnpa-db-1        | 2022-07-13 07:44:47.531 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
zakharovnpa-db-1        | 2022-07-13 07:44:47.535 UTC [37] LOG:  database system was shut down at 2022-07-13 07:44:47 UTC
zakharovnpa-db-1        | 2022-07-13 07:44:47.541 UTC [36] LOG:  database system is ready to accept connections
zakharovnpa-db-1        |  done
zakharovnpa-db-1        | server started
zakharovnpa-db-1        | CREATE DATABASE
zakharovnpa-db-1        | 
zakharovnpa-db-1        | 
zakharovnpa-db-1        | /usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*
zakharovnpa-db-1        | 
zakharovnpa-db-1        | waiting for server to shut down...2022-07-13 07:44:47.748 UTC [36] LOG:  received fast shutdown request
zakharovnpa-db-1        | .2022-07-13 07:44:47.749 UTC [36] LOG:  aborting any active transactions
zakharovnpa-db-1        | 2022-07-13 07:44:47.752 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
zakharovnpa-db-1        | 2022-07-13 07:44:47.752 UTC [38] LOG:  shutting down
zakharovnpa-db-1        | 2022-07-13 07:44:47.762 UTC [36] LOG:  database system is shut down
zakharovnpa-db-1        |  done
zakharovnpa-db-1        | server stopped
zakharovnpa-db-1        | 
zakharovnpa-db-1        | PostgreSQL init process complete; ready for start up.
zakharovnpa-db-1        | 
zakharovnpa-db-1        | 2022-07-13 07:44:47.880 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
zakharovnpa-db-1        | 2022-07-13 07:44:47.881 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
zakharovnpa-db-1        | 2022-07-13 07:44:47.881 UTC [1] LOG:  listening on IPv6 address "::", port 5432
zakharovnpa-db-1        | 2022-07-13 07:44:47.882 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
zakharovnpa-db-1        | 2022-07-13 07:44:47.886 UTC [50] LOG:  database system was shut down at 2022-07-13 07:44:47 UTC
zakharovnpa-db-1        | 2022-07-13 07:44:47.891 UTC [1] LOG:  database system is ready to accept connections
zakharovnpa-backend-1   | INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
zakharovnpa-backend-1   | INFO:     Started reloader process [7] using statreload
zakharovnpa-backend-1   | INFO:     Started server process [9]
zakharovnpa-backend-1   | INFO:     Waiting for application startup.
zakharovnpa-backend-1   | INFO:     Application startup complete.
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:42 +0000] "GET / HTTP/1.1" 200 448 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:42 +0000] "GET /build/main.css HTTP/1.1" 200 2515 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:42 +0000] "GET /build/main.js HTTP/1.1" 200 3231 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-backend-1   | INFO:     172.19.0.1:45332 - "GET /api/news/ HTTP/1.1" 200 OK
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:42 +0000] "GET /static/image.png HTTP/1.1" 200 11771 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:42 +0000] "GET /favicon.ico HTTP/1.1" 200 448 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:45:57 +0000] "GET /detail/2/ HTTP/1.1" 200 344 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-backend-1   | INFO:     172.19.0.1:45334 - "GET /api/news/1/ HTTP/1.1" 307 Temporary Redirect
zakharovnpa-backend-1   | INFO:     172.19.0.1:45334 - "GET /api/news/1 HTTP/1.1" 200 OK
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:46:04 +0000] "GET /detail/3/ HTTP/1.1" 200 344 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-backend-1   | INFO:     172.19.0.1:45336 - "GET /api/news/1/ HTTP/1.1" 307 Temporary Redirect
zakharovnpa-backend-1   | INFO:     172.19.0.1:45336 - "GET /api/news/1 HTTP/1.1" 200 OK
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:46:10 +0000] "GET /detail/25/ HTTP/1.1" 200 344 "http://127.0.0.1:8000/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" "-"
zakharovnpa-backend-1   | INFO:     172.19.0.1:45338 - "GET /api/news/1/ HTTP/1.1" 307 Temporary Redirect
zakharovnpa-backend-1   | INFO:     172.19.0.1:45338 - "GET /api/news/1 HTTP/1.1" 200 OK
zakharovnpa-frontend-1  | 172.19.0.1 - - [13/Jul/2022:07:47:20 +0000] "GET / HTTP/1.1" 200 448 "-" "curl/7.68.0" "-"
zakharovnpa-backend-1   | INFO:     172.19.0.1:45340 - "GET / HTTP/1.1" 404 Not Found
zakharovnpa-db-1        | 2022-07-13 07:49:19.668 UTC [75] LOG:  invalid length of startup packet
zakharovnpa-db-1        | 2022-07-13 08:01:03.767 UTC [1] LOG:  received fast shutdown request
zakharovnpa-db-1        | 2022-07-13 08:01:03.768 UTC [1] LOG:  aborting any active transactions
zakharovnpa-db-1        | 2022-07-13 08:01:03.769 UTC [57] FATAL:  terminating connection due to administrator command
zakharovnpa-db-1        | 2022-07-13 08:01:03.770 UTC [1] LOG:  background worker "logical replication launcher" (PID 56) exited with exit code 1
zakharovnpa-db-1        | 2022-07-13 08:01:03.772 UTC [51] LOG:  shutting down
zakharovnpa-db-1        | 2022-07-13 08:01:03.782 UTC [1] LOG:  database system is shut down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 3 (SIGQUIT) received, shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 31#31: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 30#30: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 31#31: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 30#30: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 34#34: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 35#35: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 34#34: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 35#35: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 31#31: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 30#30: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 34#34: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 35#35: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 33#33: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 33#33: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 32#32: gracefully shutting down
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 33#33: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 32#32: exiting
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 32#32: exit
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 17 (SIGCHLD) received from 34
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 34 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 29 (SIGIO) received
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 17 (SIGCHLD) received from 32
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 30 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 32 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 33 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 35 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 29 (SIGIO) received
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 17 (SIGCHLD) received from 33
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: signal 17 (SIGCHLD) received from 31
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: worker process 31 exited with code 0
zakharovnpa-frontend-1  | 2022/07/13 08:01:03 [notice] 1#1: exit
zakharovnpa-db-1 exited with code 0
zakharovnpa-frontend-1 exited with code 0
zakharovnpa-backend-1 exited with code 137

```
