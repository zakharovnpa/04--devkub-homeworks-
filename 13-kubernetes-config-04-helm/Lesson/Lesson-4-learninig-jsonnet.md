## Материалы по изучению Jsonnet

### Проект Grafana Tanka
#### 1. [Графана Танка. Гибкая, многократно используемая и лаконичная конфигурация для Kubernetes](https://tanka.dev/)
> Grafana Tanka — это надежная утилита для настройки вашего кластера Kubernetes , работающая на уникальном языке Jsonnet.
#### 2. [Обзор языка](https://tanka.dev/jsonnet/overview)
> [Jsonnet](https://jsonnet.org/) — это язык шаблонов данных, который Tanka использует для выражения того, что должно быть развернуто в вашем кластере Kubernetes. 
> Понимание Jsonnet имеет решающее значение для эффективного использования Tanka.

> На этой странице рассматривается сам язык Jsonnet. Дополнительные сведения о том, как использовать Jsonnet с Kubernetes, [см . в руководстве](https://tanka.dev/tutorial/jsonnet) . 
> Существует также [официальное руководство по Jsonnet](https://jsonnet.org/learning/tutorial.html), в котором представлен более подробный обзор возможностей языка.

#### 3. [Использование Jsonnet](https://tanka.dev/tutorial/jsonnet)
> Самая мощная часть Tanka — это язык шаблонов данных Jsonnet . Jsonnet — это надмножество JSON, в которое добавлены переменные, функции, исправления (глубокое слияние), арифметика, условные операторы и многое другое.

> Он имеет много общего с более реальными языками программирования, такими как JavaScript, чем с языками разметки, тем не менее он предназначен специально для представления данных и конфигурации. В отличие от JSON (и YAML) это язык, предназначенный для людей, а не для компьютеров.


### Стартовый скрипт

```
apt install mc -y && apt install tree && \
mkdir -p My-Project && cd My-Project && \
wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
tar -zxvf qbec-linux-amd64.tar.gz && \
cp qbec jsonnet-qbec /usr/local/bin && \
qbec init demo && cd demo && \
qbec show -O default && \
cd .. && tree && cat README.md

```
```
cd /usr/local/bin/ && \
./qbec && \
cd && \
```

### Логи
* Tab 1

```
Initialising Kubernetes... done

controlplane $ apt install mc -y && apt install tree && \
> mkdir -p My-Project && cd My-Project && \
> wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
> tar -zxvf qbec-linux-amd64.tar.gz && \
> cp qbec jsonnet-qbec /usr/local/bin && \
> qbec init demo && cd demo && \
> qbec show -O default && \
> cd .. && tree && cat README.md
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libssh2-1 mc-data
Suggested packages:
  arj catdvi | texlive-binaries dbview djvulibre-bin epub-utils genisoimage gv imagemagick libaspell-dev links | w3m | lynx odt2txt poppler-utils python
  python-boto python-tz xpdf | pdf-viewer zip
The following NEW packages will be installed:
  libssh2-1 mc mc-data
0 upgraded, 3 newly installed, 0 to remove and 166 not upgraded.
Need to get 1817 kB of archives.
After this operation, 7994 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libssh2-1 amd64 1.8.0-2.1build1 [75.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc-data all 3:4.8.24-2ubuntu1 [1265 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc amd64 3:4.8.24-2ubuntu1 [477 kB]
Fetched 1817 kB in 1s (1684 kB/s)
Selecting previously unselected package libssh2-1:amd64.
(Reading database ... 72561 files and directories currently installed.)
Preparing to unpack .../libssh2-1_1.8.0-2.1build1_amd64.deb ...
Unpacking libssh2-1:amd64 (1.8.0-2.1build1) ...
Selecting previously unselected package mc-data.
Preparing to unpack .../mc-data_3%3a4.8.24-2ubuntu1_all.deb ...
Unpacking mc-data (3:4.8.24-2ubuntu1) ...
Selecting previously unselected package mc.
Preparing to unpack .../mc_3%3a4.8.24-2ubuntu1_amd64.deb ...
Unpacking mc (3:4.8.24-2ubuntu1) ...
Setting up mc-data (3:4.8.24-2ubuntu1) ...
Setting up libssh2-1:amd64 (1.8.0-2.1build1) ...
Setting up mc (3:4.8.24-2ubuntu1) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for mime-support (3.64ubuntu1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  tree
0 upgraded, 1 newly installed, 0 to remove and 166 not upgraded.
Need to get 43.0 kB of archives.
After this operation, 115 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 tree amd64 1.8.0-1 [43.0 kB]
Fetched 43.0 kB in 0s (105 kB/s)
Selecting previously unselected package tree.
(Reading database ... 72960 files and directories currently installed.)
Preparing to unpack .../tree_1.8.0-1_amd64.deb ...
Unpacking tree (1.8.0-1) ...
Setting up tree (1.8.0-1) ...
Processing triggers for man-db (2.9.1-1) ...
--2022-08-20 18:17:37--  https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz
Resolving github.com (github.com)... 140.82.121.4
Connecting to github.com (github.com)|140.82.121.4|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://objects.githubusercontent.com/github-production-release-asset-2e65be/171958050/6d5ee375-b1e8-47a2-b4dd-951305c1c91b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220820%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220820T181737Z&X-Amz-Expires=300&X-Amz-Signature=3f75d7b7b1d1ced18cc820bc9164e9e9b7cd7440c219617835eeb63855c444f7&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=171958050&response-content-disposition=attachment%3B%20filename%3Dqbec-linux-amd64.tar.gz&response-content-type=application%2Foctet-stream [following]
--2022-08-20 18:17:37--  https://objects.githubusercontent.com/github-production-release-asset-2e65be/171958050/6d5ee375-b1e8-47a2-b4dd-951305c1c91b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220820%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220820T181737Z&X-Amz-Expires=300&X-Amz-Signature=3f75d7b7b1d1ced18cc820bc9164e9e9b7cd7440c219617835eeb63855c444f7&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=171958050&response-content-disposition=attachment%3B%20filename%3Dqbec-linux-amd64.tar.gz&response-content-type=application%2Foctet-stream
Resolving objects.githubusercontent.com (objects.githubusercontent.com)... 185.199.108.133, 185.199.109.133, 185.199.110.133, ...
Connecting to objects.githubusercontent.com (objects.githubusercontent.com)|185.199.108.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 32480655 (31M) [application/octet-stream]
Saving to: 'qbec-linux-amd64.tar.gz'

qbec-linux-amd64.tar.gz                 100%[===============================================================================>]  30.98M  98.1MB/s    in 0.3s    

2022-08-20 18:17:38 (98.1 MB/s) - 'qbec-linux-amd64.tar.gz' saved [32480655/32480655]

CHANGELOG.md
LICENSE
README.md
licenselint.sh
qbec
jsonnet-qbec
using server URL "https://172.30.1.2:6443" and default namespace "default" for the default environment
wrote demo/params.libsonnet
wrote demo/environments/base.libsonnet
wrote demo/environments/default.libsonnet
wrote demo/qbec.yaml
0 components evaluated in 0s
COMPONENT                      KIND                           NAME                                     NAMESPACE
.
|-- CHANGELOG.md
|-- LICENSE
|-- README.md
|-- demo
|   |-- components
|   |-- environments
|   |   |-- base.libsonnet
|   |   `-- default.libsonnet
|   |-- params.libsonnet
|   `-- qbec.yaml
|-- jsonnet-qbec
|-- licenselint.sh
|-- qbec
`-- qbec-linux-amd64.tar.gz

3 directories, 11 files
```

```
![qbec](site/static/images/qbec-logo-black.svg)

[![Github build status](https://github.com/splunk/qbec/workflows/build/badge.svg)](https://github.com/splunk/qbec/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/splunk/qbec)](https://goreportcard.com/report/github.com/splunk/qbec)
[![codecov](https://codecov.io/gh/splunk/qbec/branch/main/graph/badge.svg)](https://codecov.io/gh/splunk/qbec)
[![GolangCI](https://golangci.com/badges/github.com/splunk/qbec.svg)](https://golangci.com/r/github.com/splunk/qbec)


[![Build Stats](https://buildstats.info/github/chart/splunk/qbec?branch=main)](https://buildstats.info/github/chart/splunk/qbec?branch=main)


Qbec (pronounced like the [Canadian province](https://en.wikipedia.org/wiki/Quebec)) is a CLI tool that 
allows you to create Kubernetes objects on multiple Kubernetes clusters or namespaces configured correctly for 
the target environment in question.

It is based on [jsonnet](https://jsonnet.org) and is similar to other tools in the same space like 
[kubecfg](https://github.com/ksonnet/kubecfg) and [ksonnet](https://ksonnet.io/). 

For more info, [read the docs](https://qbec.io/)

### Installing

Use a prebuilt binary [from the releases page](https://github.com/splunk/qbec/releases) for your operating system.

On MacOS, you can install qbec using homebrew:

    $ brew tap splunk/tap 
    $ brew install qbec


### Building from source


    git clone git@github.com:splunk/qbec
    cd qbec
    make install  # installs lint tools etc.
    make

controlplane $ 
```
