##  Ход создания образов приложений Frontend, Backand, DataBase.

#### 1. Из директории взяты конфигурации для созданияобразов

#### 2. Запуск создания образов
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker-compose build
Sending build context to Docker daemon  112.2kB
Step 1/14 : FROM node:lts-buster as builder
lts-buster: Pulling from library/node
ea267e4631a9: Pull complete 
8a014c921489: Pull complete 
293ff1be7001: Pull complete 
4e42533e7311: Pull complete 
e56e70ed0dfb: Pull complete 
43ccf1ebdd00: Pull complete 
06925feb028d: Pull complete 
403a3da90881: Pull complete 
8aa2a751e29b: Pull complete 
Digest: sha256:a13d2d2aec7f0dae18a52ca4d38b592e45a45cc4456ffab82e5ff10d8a53d042
Status: Downloaded newer image for node:lts-buster
 ---> b9f398d30e45
Step 2/14 : RUN mkdir /app
 ---> Running in c89d25977e10
 ---> f16fcbd21ee6
Step 3/14 : WORKDIR /app
 ---> Running in 558b524fe484
 ---> 6812598cb3ad
Step 4/14 : ADD package.json /app/package.json
 ---> 6e4c1b5ae040
Step 5/14 : ADD package-lock.json /app/package-lock.json
 ---> ecef30491f9a
Step 6/14 : RUN npm i
 ---> Running in 06ff8b6e448b
 
 Красным цветом ###################################################### Красным цветом
npm WARN old lockfile 
npm WARN old lockfile The package-lock.json file was created with an old version of npm,
npm WARN old lockfile so supplemental metadata must be fetched from the registry.
npm WARN old lockfile 
npm WARN old lockfile This is a one-time fix-up, please be patient...
npm WARN old lockfile 
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
npm WARN deprecated stable@0.1.8: Modern JS already guarantees Array#sort() is a stable sort, so this library is deprecated. See the compatibility table on MDN: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort#browser_compatibility
npm WARN deprecated source-map-url@0.4.1: See https://github.com/lydell/source-map-url#deprecated
npm WARN deprecated uuid@3.4.0: Please upgrade  to version 7 or higher.  Older versions may use Math.random() in certain circumstances, which is known to be problematic.  See https://v8.dev/blog/math-random for details.
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
npm WARN deprecated source-map-resolve@0.5.3: See https://github.com/lydell/source-map-resolve#deprecated
npm WARN deprecated querystring@0.2.0: The querystring API is considered Legacy. new code should use the URLSearchParams API instead.
npm WARN deprecated svgo@1.3.2: This SVGO version is no longer supported. Upgrade to v2.x.x.
npm WARN deprecated @babel/polyfill@7.12.1: 🚨 This package has been deprecated in favor of separate inclusion of a polyfill and regenerator-runtime (when needed). See the @babel/polyfill docs (https://babeljs.io/docs/en/babel-polyfill) for more information.
npm WARN deprecated chokidar@2.1.8: Chokidar 2 does not receive security updates since 2019. Upgrade to chokidar 3 with 15x fewer dependencies
npm WARN deprecated chokidar@2.1.8: Chokidar 2 does not receive security updates since 2019. Upgrade to chokidar 3 with 15x fewer dependencies
npm WARN deprecated core-js@2.6.12: core-js@<3.23.3 is no longer maintained and not recommended for usage due to the number of issues. Because of the V8 engine whims, feature detection in old core-js versions could cause a slowdown up to 100x even if nothing is polyfilled. Some versions have web compatibility issues. Please, upgrade your dependencies to the actual version of core-js.
Красным цветом ###################################################### Красным цветом


added 1013 packages, and audited 1014 packages in 50s

64 packages are looking for funding
  run `npm fund` for details

31 vulnerabilities (6 moderate, 22 high, 3 critical)

To address issues that do not require attention, run:
  npm audit fix

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.

Красным цветом ###################################################### Красным цветом
npm notice 
npm notice New minor version of npm available! 8.11.0 -> 8.13.2
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.13.2>
npm notice Run `npm install -g npm@8.13.2` to update!
npm notice 
Красным цветом ###################################################### Красным цветом



 ---> a154e3d6e8c3
Step 7/14 : ADD . /app
 ---> d34cfbeb458c
Step 8/14 : RUN npm run build && rm -rf /app/node_modules
 ---> Running in a155ec88c495

> devops-testapp@1.0.0 build
> cross-env NODE_ENV=production webpack --config webpack.config.js --mode production

ℹ Compiling Production build progress


Красным цветом ###################################################### Красным цветом
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db

Why you should do it regularly:
https://github.com/browserslist/browserslist#browsers-data-updating
Красным цветом ###################################################### Красным цветом


✔ Production build progress: Compiled successfully in 2.56s
Hash: ec3f8bf57db6746b49f5
Version: webpack 4.46.0
Time: 2567ms
Built at: 07/04/2022 12:30:31 PM
   Asset      Size  Chunks             Chunk Names
main.css  2.46 KiB       0  [emitted]  main
 main.js  3.16 KiB       0  [emitted]  main
Entrypoint main = main.css main.js
[0] ./styles/index.less 39 bytes {0} [built]
[1] ./js/index.js + 1 modules 3.78 KiB {0} [built]
    | ./js/index.js 3.73 KiB [built]
    | ./js/config.js 43 bytes [built]
    + 2 hidden modules
Child mini-css-extract-plugin node_modules/css-loader/dist/cjs.js!node_modules/postcss-loader/src/index.js??ref--6-2!node_modules/group-css-media-queries-loader/lib/index.js!node_modules/less-loader/dist/cjs.js!styles/index.less:
    Entrypoint mini-css-extract-plugin = *
    [1] ./node_modules/css-loader/dist/cjs.js!./node_modules/postcss-loader/src??ref--6-2!./node_modules/group-css-media-queries-loader/lib!./node_modules/less-loader/dist/cjs.js!./styles/index.less 1.3 KiB {0} [built]
    [2] ./node_modules/css-loader/dist/cjs.js!./styles/normalize.css 6.59 KiB {0} [built]
        + 1 hidden module
 ---> d173cf56ce49
Step 9/14 : FROM nginx:latest
latest: Pulling from library/nginx
b85a868b505f: Pull complete 
f4407ba1f103: Pull complete 
4a7307612456: Pull complete 
935cecace2a0: Pull complete 
8f46223e4234: Pull complete 
fe0ef4c895f5: Pull complete 
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Downloaded newer image for nginx:latest
 ---> 55f4b40fe486
Step 10/14 : RUN mkdir /app
 ---> Running in 33af72a5054d
 ---> eb2495b33cd2
Step 11/14 : WORKDIR /app
 ---> Running in d39b87253b2a
 ---> dd332f3a8cec
Step 12/14 : COPY --from=builder /app/ /app
 ---> 08637bdea5b3
Step 13/14 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Running in e51cd16c5a70
 ---> 9b657fa64ab2
Step 14/14 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> 5438a0c5806b
Successfully built 5438a0c5806b
Successfully tagged 13-kubernetes-config_frontend:latest
Sending build context to Docker daemon  5.793kB
Step 1/8 : FROM python:3.9-buster
3.9-buster: Pulling from library/python
ea267e4631a9: Already exists 
8a014c921489: Already exists 
293ff1be7001: Already exists 
4e42533e7311: Already exists 
e56e70ed0dfb: Already exists 
1ae6d32f2fda: Pull complete 
cc870a2934f0: Pull complete 
6f1bab779019: Pull complete 
a17c142d18bb: Pull complete 
Digest: sha256:2018f2f7d166f370bd70d7d003c3672da718f2bca8161a2085ef0da550e47659
Status: Downloaded newer image for python:3.9-buster
 ---> 999912f2c071
Step 2/8 : RUN mkdir /app && python -m pip install pipenv
 ---> Running in 09694e8361b3
Collecting pipenv
  Downloading pipenv-2022.6.7-py2.py3-none-any.whl (3.9 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.9/3.9 MB 7.3 MB/s eta 0:00:00
Requirement already satisfied: setuptools>=36.2.1 in /usr/local/lib/python3.9/site-packages (from pipenv) (58.1.0)
Collecting certifi
  Downloading certifi-2022.6.15-py3-none-any.whl (160 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 160.2/160.2 KB 8.0 MB/s eta 0:00:00
Collecting virtualenv-clone>=0.2.5
  Downloading virtualenv_clone-0.5.7-py3-none-any.whl (6.6 kB)
Requirement already satisfied: pip>=22.0.4 in /usr/local/lib/python3.9/site-packages (from pipenv) (22.0.4)
Collecting virtualenv
  Downloading virtualenv-20.15.1-py2.py3-none-any.whl (10.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 10.1/10.1 MB 9.3 MB/s eta 0:00:00
Collecting filelock<4,>=3.2
  Downloading filelock-3.7.1-py3-none-any.whl (10 kB)
Collecting distlib<1,>=0.3.1
  Downloading distlib-0.3.4-py2.py3-none-any.whl (461 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 461.2/461.2 KB 8.9 MB/s eta 0:00:00
Collecting platformdirs<3,>=2
  Downloading platformdirs-2.5.2-py3-none-any.whl (14 kB)
Collecting six<2,>=1.9.0
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Installing collected packages: distlib, virtualenv-clone, six, platformdirs, filelock, certifi, virtualenv, pipenv
Successfully installed certifi-2022.6.15 distlib-0.3.4 filelock-3.7.1 pipenv-2022.6.7 platformdirs-2.5.2 six-1.16.0 virtualenv-20.15.1 virtualenv-clone-0.5.7

Красным цветом ###################################################### Красным цветом
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
WARNING: You are using pip version 22.0.4; however, version 22.1.2 is available.
You should consider upgrading via the '/usr/local/bin/python -m pip install --upgrade pip' command.
Красным цветом ###################################################### Красным цветом


 ---> 9d2f43cfe6c6
Step 3/8 : WORKDIR /app
 ---> Running in d7a9eac90dd0
 ---> c32c3aa2b2f7
Step 4/8 : ADD Pipfile /app/Pipfile
 ---> b7ea0062acb5
Step 5/8 : ADD Pipfile.lock /app/Pipfile.lock
 ---> ff051eb06a75
Step 6/8 : RUN pipenv install
 ---> Running in 70bfa6e9d73b

Красным цветом ###################################################### Красным цветом
Creating a virtualenv for this project...
Pipfile: /app/Pipfile
Using /usr/local/bin/python3.9 (3.9.13) to create virtualenv...
⠹ Creating virtual environment...created virtual environment CPython3.9.13.final.0-64 in 820ms
  creator CPython3Posix(dest=/root/.local/share/virtualenvs/app-4PlAip0Q, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==22.1.2, setuptools==62.6.0, wheel==0.37.1
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

✔ Successfully created virtual environment! 
Virtualenv location: /root/.local/share/virtualenvs/app-4PlAip0Q
Installing dependencies from Pipfile.lock (e9059d)...
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 11/11 — 00:00:19
Красным цветом ###################################################### Красным цветом
  
  
To activate this project's virtualenv, run pipenv shell.
Alternatively, run a command inside the virtualenv with pipenv run.
 ---> d8b4b490bb86
Step 7/8 : ADD main.py /app/main.py
 ---> 82eab8a2296b
Step 8/8 : CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000
 ---> Running in 3f26df1fdde9
 ---> bf58e470d5a5
Successfully built bf58e470d5a5
Successfully tagged 13-kubernetes-config_backend:latest

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them

```
#### 3. Создались образы
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker image list
REPOSITORY                                                          TAG               IMAGE ID       CREATED         SIZE
13-kubernetes-config_backend                                        latest            bf58e470d5a5   8 minutes ago   1.07GB
13-kubernetes-config_frontend                                       latest            5438a0c5806b   9 minutes ago   142MB
<none>                                                              <none>            d173cf56ce49   9 minutes ago   1.06GB
python                                                              3.9-buster        999912f2c071   11 days ago     889MB
node                                                                lts-buster        b9f398d30e45   11 days ago     907MB
nginx                                                               latest            55f4b40fe486   11 days ago     142MB
```
#### 4. Запуск контейнеров
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker-compose up
[+] Running 9/9
 ⠿ db Pulled                                                                                                                                                                                            20.5s
   ⠿ 2408cc74d12b Already exists                                                                                                                                                                         0.0s
   ⠿ cde4337df78d Pull complete                                                                                                                                                                          1.3s
   ⠿ 55ba5f494780 Pull complete                                                                                                                                                                          1.4s
   ⠿ 56f1718fcdf5 Pull complete                                                                                                                                                                         16.6s
   ⠿ 728c5f526fa3 Pull complete                                                                                                                                                                         16.7s
   ⠿ afa1a4a2aaab Pull complete                                                                                                                                                                         16.8s
   ⠿ 30dca59672f8 Pull complete                                                                                                                                                                         16.9s
   ⠿ a4fd8a42494f Pull complete                                                                                                                                                                         17.0s
[+] Running 4/4
 ⠿ Network 13-kubernetes-config_default       Created                                                                                                                                                    0.1s
 ⠿ Container 13-kubernetes-config-frontend-1  Created                                                                                                                                                    0.9s
 ⠿ Container 13-kubernetes-config-db-1        Created                                                                                                                                                    0.9s
 ⠿ Container 13-kubernetes-config-backend-1   Created                                                                                                                                                    0.0s
Attaching to 13-kubernetes-config-backend-1, 13-kubernetes-config-db-1, 13-kubernetes-config-frontend-1
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
13-kubernetes-config-frontend-1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
13-kubernetes-config-db-1        | The files belonging to this database system will be owned by user "postgres".
13-kubernetes-config-db-1        | This user must also own the server process.
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | The database cluster will be initialized with locale "en_US.utf8".
13-kubernetes-config-db-1        | The default database encoding has accordingly been set to "UTF8".
13-kubernetes-config-db-1        | The default text search configuration will be set to "english".
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | Data page checksums are disabled.
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | fixing permissions on existing directory /var/lib/postgresql/data ... ok
13-kubernetes-config-frontend-1  | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
13-kubernetes-config-db-1        | creating subdirectories ... ok
13-kubernetes-config-db-1        | selecting dynamic shared memory implementation ... posix
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
13-kubernetes-config-frontend-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: using the "epoll" event method
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: nginx/1.23.0
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: OS: Linux 5.13.0-52-generic
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker processes
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 30
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 31
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 32
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 33
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 34
13-kubernetes-config-frontend-1  | 2022/07/04 14:55:12 [notice] 1#1: start worker process 35
13-kubernetes-config-db-1        | selecting default max_connections ... 100
13-kubernetes-config-db-1        | selecting default shared_buffers ... 128MB
13-kubernetes-config-db-1        | selecting default time zone ... UTC
13-kubernetes-config-db-1        | creating configuration files ... ok
13-kubernetes-config-db-1        | running bootstrap script ... ok
13-kubernetes-config-db-1        | performing post-bootstrap initialization ... sh: locale: not found
13-kubernetes-config-db-1        | 2022-07-04 14:55:13.415 UTC [31] WARNING:  no usable system locales were found
13-kubernetes-config-db-1        | ok
13-kubernetes-config-db-1        | syncing data to disk ... ok
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | Success. You can now start the database server using:
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        |     pg_ctl -D /var/lib/postgresql/data -l logfile start
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | initdb: warning: enabling "trust" authentication for local connections
13-kubernetes-config-db-1        | You can change this by editing pg_hba.conf or using the option -A, or
13-kubernetes-config-db-1        | --auth-local and --auth-host, the next time you run initdb.
13-kubernetes-config-db-1        | waiting for server to start....2022-07-04 14:55:14.274 UTC [37] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.276 UTC [37] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.279 UTC [38] LOG:  database system was shut down at 2022-07-04 14:55:14 UTC
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.284 UTC [37] LOG:  database system is ready to accept connections
13-kubernetes-config-backend-1   | INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
13-kubernetes-config-backend-1   | INFO:     Started reloader process [7] using statreload
13-kubernetes-config-db-1        |  done
13-kubernetes-config-db-1        | server started
13-kubernetes-config-db-1        | CREATE DATABASE
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | /usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | waiting for server to shut down....2022-07-04 14:55:14.479 UTC [37] LOG:  received fast shutdown request
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.480 UTC [37] LOG:  aborting any active transactions
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.482 UTC [37] LOG:  background worker "logical replication launcher" (PID 44) exited with exit code 1
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.484 UTC [39] LOG:  shutting down
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.498 UTC [37] LOG:  database system is shut down
13-kubernetes-config-db-1        |  done
13-kubernetes-config-db-1        | server stopped
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | PostgreSQL init process complete; ready for start up.
13-kubernetes-config-db-1        | 
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.611 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.611 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.611 UTC [1] LOG:  listening on IPv6 address "::", port 5432
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.613 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.616 UTC [51] LOG:  database system was shut down at 2022-07-04 14:55:14 UTC
13-kubernetes-config-db-1        | 2022-07-04 14:55:14.620 UTC [1] LOG:  database system is ready to accept connections
13-kubernetes-config-backend-1   | INFO:     Started server process [9]
13-kubernetes-config-backend-1   | INFO:     Waiting for application startup.
13-kubernetes-config-backend-1   | INFO:     Application startup complete.

```
#### 5. Работающие контейнеры
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS          PORTS                                       NAMES
fb15dec28c02   13-kubernetes-config_backend    "/bin/sh -c 'pipenv …"   17 seconds ago   Up 16 seconds   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp   13-kubernetes-config-backend-1
c63c6599c926   postgres:13-alpine              "docker-entrypoint.s…"   17 seconds ago   Up 16 seconds   5432/tcp                                    13-kubernetes-config-db-1
eea4effe3b25   13-kubernetes-config_frontend   "/docker-entrypoint.…"   3 minutes ago    Up 16 seconds   0.0.0.0:8000->80/tcp, :::8000->80/tcp       13-kubernetes-config-frontend-1
```
#### 6. Создаем образы по отдельности на основани своих Dockerfile
1. Dockerfile длля Frontend
```
FROM node:lts-buster as builder

RUN mkdir /app

WORKDIR /app

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

RUN npm i

ADD . /app

RUN npm run build && rm -rf /app/node_modules

FROM nginx:latest

RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/ /app

RUN mv /app/markup/* /app && rm -rf /app/markup

ADD demo.conf /etc/nginx/conf.d/default.conf

```
* Создание образа из ранее приготовленного отбраза. Процесс очяень быстрый
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/frontend# docker build -t zakharovnpa/k8s-frontend:05.07.22 .
Sending build context to Docker daemon  430.6kB
Step 1/14 : FROM node:lts-buster as builder
 ---> b9f398d30e45
Step 2/14 : RUN mkdir /app
 ---> Using cache
 ---> f16fcbd21ee6
Step 3/14 : WORKDIR /app
 ---> Using cache
 ---> 6812598cb3ad
Step 4/14 : ADD package.json /app/package.json
 ---> Using cache
 ---> 6e4c1b5ae040
Step 5/14 : ADD package-lock.json /app/package-lock.json
 ---> Using cache
 ---> ecef30491f9a
Step 6/14 : RUN npm i
 ---> Using cache
 ---> a154e3d6e8c3
Step 7/14 : ADD . /app
 ---> Using cache
 ---> d34cfbeb458c
Step 8/14 : RUN npm run build && rm -rf /app/node_modules
 ---> Using cache
 ---> d173cf56ce49
Step 9/14 : FROM nginx:latest
 ---> 55f4b40fe486
Step 10/14 : RUN mkdir /app
 ---> Using cache
 ---> eb2495b33cd2
Step 11/14 : WORKDIR /app
 ---> Using cache
 ---> dd332f3a8cec
Step 12/14 : COPY --from=builder /app/ /app
 ---> Using cache
 ---> 08637bdea5b3
Step 13/14 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Using cache
 ---> 9b657fa64ab2
Step 14/14 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> Using cache
 ---> 5438a0c5806b
Successfully built 5438a0c5806b
Successfully tagged zakharovnpa/k8s-frontend:05.07.22

```
2. Dockerfile длля Backend
```
FROM python:3.9-buster

RUN mkdir /app && python -m pip install pipenv

WORKDIR /app

ADD Pipfile /app/Pipfile
ADD Pipfile.lock /app/Pipfile.lock

RUN pipenv install

ADD main.py /app/main.py

CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000

```
* Создание образа из ранее приготовленного отбраза. Процесс очяень быстрый
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/backend# docker build -t zakharovnpa/k8s-backend:05.07.22 .
Sending build context to Docker daemon  20.48kB
Step 1/8 : FROM python:3.9-buster
 ---> 999912f2c071
Step 2/8 : RUN mkdir /app && python -m pip install pipenv
 ---> Using cache
 ---> 9d2f43cfe6c6
Step 3/8 : WORKDIR /app
 ---> Using cache
 ---> c32c3aa2b2f7
Step 4/8 : ADD Pipfile /app/Pipfile
 ---> Using cache
 ---> b7ea0062acb5
Step 5/8 : ADD Pipfile.lock /app/Pipfile.lock
 ---> Using cache
 ---> ff051eb06a75
Step 6/8 : RUN pipenv install
 ---> Using cache
 ---> d8b4b490bb86
Step 7/8 : ADD main.py /app/main.py
 ---> Using cache
 ---> 82eab8a2296b
Step 8/8 : CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000
 ---> Using cache
 ---> bf58e470d5a5
Successfully built bf58e470d5a5
Successfully tagged zakharovnpa/k8s-backend:05.07.22
```
