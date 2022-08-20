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
wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
tar -zxvf qbec-linux-amd64.tar.gz && \
cp qbec jsonnet-qbec /usr/local/bin && \
cd /usr/local/bin/ && \
./qbec && \
cd && \
qbec init demo && cd demo && \
qbec show -O default

```
### Логи
* Tab 1

```
Initialising Kubernetes... done

controlplane $ wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz
--2022-08-20 17:36:44--  https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://objects.githubusercontent.com/github-production-release-asset-2e65be/171958050/6d5ee375-b1e8-47a2-b4dd-951305c1c91b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220820%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220820T173644Z&X-Amz-Expires=300&X-Amz-Signature=1c2217131cf54e9091dd8c2862027a3dbbe0ce1546c66c19aec1c6487b58608a&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=171958050&response-content-disposition=attachment%3B%20filename%3Dqbec-linux-amd64.tar.gz&response-content-type=application%2Foctet-stream [following]
--2022-08-20 17:36:44--  https://objects.githubusercontent.com/github-production-release-asset-2e65be/171958050/6d5ee375-b1e8-47a2-b4dd-951305c1c91b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220820%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220820T173644Z&X-Amz-Expires=300&X-Amz-Signature=1c2217131cf54e9091dd8c2862027a3dbbe0ce1546c66c19aec1c6487b58608a&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=171958050&response-content-disposition=attachment%3B%20filename%3Dqbec-linux-amd64.tar.gz&response-content-type=application%2Foctet-stream
Resolving objects.githubusercontent.com (objects.githubusercontent.com)... 185.199.110.133, 185.199.109.133, 185.199.111.133, ...
Connecting to objects.githubusercontent.com (objects.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 32480655 (31M) [application/octet-stream]
Saving to: 'qbec-linux-amd64.tar.gz'

qbec-linux-amd64.tar.gz                 100%[===============================================================================>]  30.98M  9.97MB/s    in 3.1s    

2022-08-20 17:36:48 (9.97 MB/s) - 'qbec-linux-amd64.tar.gz' saved [32480655/32480655]

controlplane $ 
controlplane $ ls -lha
total 32M
drwx------  5 root root 4.0K Aug 20 17:36 .
drwxr-xr-x 20 root root 4.0K Aug 20 17:36 ..
-rw-------  1 root root   10 Oct  8  2021 .bash_history
-rw-r--r--  1 root root 3.3K Aug 12 15:10 .bashrc
drwxr-xr-x  3 root root 4.0K Aug 12 15:08 .kube
-rw-r--r--  1 root root  161 Dec  5  2019 .profile
drwx------  2 root root 4.0K Aug 12 14:31 .ssh
drwxr-xr-x  6 root root 4.0K Aug 20 17:36 .theia
-rw-r--r--  1 root root  109 Aug 12 15:21 .vimrc
-rw-r--r--  1 root root  165 Aug 20 17:36 .wget-hsts
lrwxrwxrwx  1 root root    1 Aug 12 14:34 filesystem -> /
-rw-r--r--  1 root root  31M Mar  5 23:32 qbec-linux-amd64.tar.gz
controlplane $ 
controlplane $ tar -zxvf qbec-linux-amd64.tar.gzCHANGELOG.md
LICENSE
README.md
licenselint.sh
qbec
jsonnet-qbec
controlplane $ 
controlplane $ env                                      
SHELL=/bin/bash
PWD=/root
LOGNAME=kc-internal
HOME=/root
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
SSH_CONNECTION=10.48.0.28 47494 172.30.1.2 22
LESSCLOSE=/usr/bin/lesspipe %s %s
TERM=xterm-256color
LESSOPEN=| /usr/bin/lesspipe %s
USER=kc-internal
SHLVL=3
PS1=\h $ 
SSH_CLIENT=10.48.0.28 47494 22
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/snap/bin:/usr/local/go/bin:/snap/bin
MAIL=/var/mail/kc-internal
DEBIAN_FRONTEND=noninteractive
OLDPWD=/opt
_=/usr/bin/env
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cp qbec qbec-linux-amd64.tar.gz /usr/local/bin
controlplane $ 
controlplane $ type qbec
qbec is /usr/local/bin/qbec
controlplane $ 
controlplane $ cd /usr/local/bin/
controlplane $ 
controlplane $ ./qbec

qbec provides a set of commands to manage kubernetes objects on multiple clusters.

Usage:
  qbec [command]

Available Commands:
  alpha       experimental qbec commands
  apply       apply one or more components to a Kubernetes cluster
  completion  Output shell completion for bash
  component   component lists and diffs
  delete      delete one or more components from a Kubernetes cluster
  diff        diff one or more components against objects in a Kubernetes cluster
  env         environment lists and details
  eval        evaluate the supplied file optionally under a qbec environment
  fmt         format files
  help        Help about any command
  init        initialize a qbec app
  param       parameter lists and diffs
  show        show output in YAML or JSON format for one or more components
  validate    validate one or more components against the spec of a kubernetes cluster
  version     print program version

Flags:
      --app-tag string                  build tag to create suffixed objects, indicates GC scope
      --colors                          colorize output (set automatically if not specified)
  -E, --env-file string                 use additional environment file not declared in qbec.yaml
      --eval-concurrency int            concurrency with which to evaluate components
      --force:k8s-context string        force K8s context with supplied value. Special values are __incluster__ and __current__ for in-cluster and current contexts respectively. Defaulted from QBEC_FORCE_K8S_CONTEXT
      --force:k8s-namespace string      override default namespace for environment with supplied value. The special value __current__ can be used to extract the value in the kube config. Defaulted from QBEC_FORCE_K8S_NAMESPACE
  -h, --help                            help for qbec
      --k8s:as string                   Username to impersonate for the operation
      --k8s:as-group stringArray        Group to impersonate for the operation, this flag can be repeated to specify multiple groups.
      --k8s:as-uid string               UID to impersonate for the operation
      --k8s:client-burst int            Burst to use for K8s client, 0 for default
      --k8s:client-certificate string   Path to a client certificate file for TLS
      --k8s:client-key string           Path to a client key file for TLS
      --k8s:client-qps int              QPS to use for K8s client, 0 for default
      --k8s:kubeconfig string           Path to a kubeconfig file. Alternative to env var $KUBECONFIG.
      --k8s:list-page-size int          Maximum number of responses per page to return for a list call. 0 for no limit (default 1000)
      --k8s:password string             Password for basic authentication to the API server
      --k8s:request-timeout string      The length of time to wait before giving up on a single server request. Non-zero values should contain a corresponding time unit (e.g. 1s, 2m, 3h). A value of zero means don't timeout requests. (default "0")
      --k8s:token string                Bearer token for authentication to the API server
      --k8s:username string             Username for basic authentication to the API server
      --pprof:cpu string                filename to write CPU profile
      --pprof:memory string             filename to write memory profile
      --root string                     root directory of repo (from QBEC_ROOT or auto-detect)
      --strict-vars                     require declared variables to be specified, do not allow undeclared variables
  -v, --verbose int                     verbosity level
      --vm:data-source stringArray      additional data sources in URL format
      --vm:ext-code stringArray         external code: <var>=[val], if <val> is omitted, get from environment var <var>
      --vm:ext-code-file stringArray    external code from file: <var>=<filename>
  -V, --vm:ext-str stringArray          external string: <var>=[val], if <val> is omitted, get from environment var <var>
      --vm:ext-str-file stringArray     external string from file: <var>=<filename>
      --vm:ext-str-list stringArray     file containing lines of the form <var>[=<val>]
      --vm:jpath stringArray            additional jsonnet library path
      --vm:tla-code stringArray         top-level code: <var>=[val], if <val> is omitted, get from environment var <var>
      --vm:tla-code-file stringArray    top-level code from file: <var>=<filename>
  -A, --vm:tla-str stringArray          top-level string: <var>=[val], if <val> is omitted, get from environment var <var>
      --vm:tla-str-file stringArray     top-level string from file: <var>=<filename>
      --vm:tla-str-list stringArray     file containing lines of the form <var>[=<val>]
      --yes                             do not prompt for confirmation. The default value can be overridden by setting QBEC_YES=true

Use "qbec [command] --help" for more information about a command.

Use "qbec options" for a list of global options available to all commands.
controlplane $ 
controlplane $ 
controlplane $ qbec init
✘ a single app name argument must be supplied
controlplane $ 
controlplane $ qbec init demo
using server URL "https://172.30.1.2:6443" and default namespace "default" for the default environment
wrote demo/params.libsonnet
wrote demo/environments/base.libsonnet
wrote demo/environments/default.libsonnet
wrote demo/qbec.yaml
controlplane $ 
controlplane $ pwd
/usr/local/bin
controlplane $ 
controlplane $ ls -lha
total 82M
drwxr-xr-x  3 root root 4.0K Aug 20 17:43 .
drwxr-xr-x 11 root root 4.0K Aug 12 14:34 ..
drwxr-xr-x  4 root root 4.0K Aug 20 17:43 demo
-rwxr-xr-x  1 root root  51M Aug 20 17:39 qbec
-rw-r--r--  1 root root  31M Aug 20 17:39 qbec-linux-amd64.tar.gz
controlplane $ 
controlplane $ qbec show -O default
✘ unable to find source root at or above /usr/local/bin
controlplane $ 
controlplane $ cd 
controlplane $ 
controlplane $ pwd
/root
controlplane $ 
controlplane $ ls
CHANGELOG.md  LICENSE  README.md  filesystem  jsonnet-qbec  licenselint.sh  qbec  qbec-linux-amd64.tar.gz
controlplane $ 
controlplane $ cp jsonnet-qbec /usr/local/bin
controlplane $ 
controlplane $ cd /usr/local/bin/
controlplane $ 
controlplane $ qbec show -O default
✘ unable to find source root at or above /usr/local/bin
controlplane $ 
controlplane $ 
controlplane $ ^C
controlplane $ 
controlplane $ 
controlplane $ pwd
/usr/local/bin
controlplane $ 
controlplane $ cd 
controlplane $ 
controlplane $ ls    
CHANGELOG.md  LICENSE  README.md  filesystem  jsonnet-qbec  licenselint.sh  qbec  qbec-linux-amd64.tar.gz
controlplane $ 
controlplane $ qbec init test
using server URL "https://172.30.1.2:6443" and default namespace "default" for the default environment
wrote test/params.libsonnet
wrote test/environments/base.libsonnet
wrote test/environments/default.libsonnet
wrote test/qbec.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 115M
drwx------  6 root root   4.0K Aug 20 18:00 .
drwxr-xr-x 20 root root   4.0K Aug 20 17:36 ..
-rw-------  1 root root     10 Oct  8  2021 .bash_history
-rw-r--r--  1 root root   3.3K Aug 12 15:10 .bashrc
drwxr-xr-x  3 root root   4.0K Aug 12 15:08 .kube
-rw-r--r--  1 root root    161 Dec  5  2019 .profile
drwx------  2 root root   4.0K Aug 12 14:31 .ssh
drwxr-xr-x  6 root root   4.0K Aug 20 17:36 .theia
-rw-r--r--  1 root root    109 Aug 12 15:21 .vimrc
-rw-r--r--  1 root root    165 Aug 20 17:36 .wget-hsts
-rw-r--r--  1 1001 docker  22K Mar  5 23:26 CHANGELOG.md
-rw-r--r--  1 1001 docker  12K Mar  5 23:26 LICENSE
-rw-r--r--  1 1001 docker 1.5K Mar  5 23:26 README.md
lrwxrwxrwx  1 root root      1 Aug 12 14:34 filesystem -> /
-rwxr-xr-x  1 1001 docker  34M Mar  5 23:32 jsonnet-qbec
-rwxr-xr-x  1 1001 docker  177 Mar  5 23:26 licenselint.sh
-rwxr-xr-x  1 1001 docker  51M Mar  5 23:30 qbec
-rw-r--r--  1 root root    31M Mar  5 23:32 qbec-linux-amd64.tar.gz
drwxr-xr-x  4 root root   4.0K Aug 20 18:00 test
controlplane $ 
controlplane $ qbec show -O default
✘ unable to find source root at or above /root
controlplane $ 
controlplane $ qbec show -O test   
✘ unable to find source root at or above /root
controlplane $ 
controlplane $ cd test/
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 4 root root 4.0K Aug 20 18:00 .
drwx------ 6 root root 4.0K Aug 20 18:00 ..
drwxr-xr-x 2 root root 4.0K Aug 20 18:00 components
drwxr-xr-x 2 root root 4.0K Aug 20 18:00 environments
-rw-r--r-- 1 root root  397 Aug 20 18:00 params.libsonnet
-rw-r--r-- 1 root root  178 Aug 20 18:00 qbec.yaml
controlplane $ 
controlplane $ qbec show -O default
0 components evaluated in 0s
COMPONENT                      KIND                           NAME                                     NAMESPACE
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
```
