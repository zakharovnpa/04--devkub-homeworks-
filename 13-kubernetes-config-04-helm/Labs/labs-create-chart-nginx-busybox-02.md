## ЛР-2. Шаблонизатор Helm

### 1. Подготовка рабочего пространства
* Устанавливаем Helm
* Устанавливаем nfs-server
* Устанавливаем mc
* Создаем namespace stage
* Создаем директорию проекта My-Procect/stage с пустыми файлами
* Создаем чарт My-chart
* Включаем автодополнение для Helm
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
helm completion bash > /etc/bash_completion.d/helm && \
apt install mc -y && \
apt install tree && \
kubectl create namespace stage && \
mkdir -p My-Procect/stage && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
helm create My-chart && \
ls -lha && \
cd My-chart && \
tree
```

### 2. Создание первого чарта

```
# Создание чарта first в папке charts
helm create first

# Сборка ресурсов из шаблона 
helm template first

# Linter
helm lint first
```
### 3. Деплой

```
# Release deploy
helm install demo-release charts/01-simple
kubectl get ns
kubectl get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}

# Upgrade release
helm upgrade demo-release charts/01-simple

# Upgrade or install release
helm upgrade --install demo-release charts/01-simple

# Uninstall release
helm uninstall demo-release

# Установка релиза в новый namespace с переопределением параметров
helm install new-release -f charts/01-simple/new-values2.yaml charts/01-simple
kubectl -n new get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}

# Просмотр пользовательских переменных
helm get values demo-release
helm get values new-release

# Список релизов
helm list

# Отладка
helm install --dry-run --debug aaa --set namespace=aaa charts/01-simple
```
### Logs
* Tab 1
```
Initialising Kubernetes... done

controlplane $ date
Thu Jul 28 05:21:12 UTC 2022
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
> helm repo add stable https://charts.helm.sh/stable && \
> helm repo update && \
> helm install nfs-server stable/nfs-server-provisioner && \
> apt install nfs-common -y && \
> helm completion bash > /etc/bash_completion.d/helm && \
> apt install mc -y && \
> apt install tree && \
> kubectl create namespace stage && \
> mkdir -p My-Procect/stage && \
> cd My-Procect/stage && \
> touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
> helm create My-chart && \
> ls -lha && \
> cd My-chart && \
> tree
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   302k      0 --:--:-- --:--:-- --:--:--  302k
Downloading https://get.helm.sh/helm-v3.9.2-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Jul 28 04:40:35 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 195 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (534 kB/s) 
Selecting previously unselected package libtirpc-common.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1_all.deb ...
Unpacking libtirpc-common (1.2.5-1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1.1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1.1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1.1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
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
0 upgraded, 3 newly installed, 0 to remove and 195 not upgraded.
Need to get 1817 kB of archives.
After this operation, 7994 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libssh2-1 amd64 1.8.0-2.1build1 [75.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc-data all 3:4.8.24-2ubuntu1 [1265 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc amd64 3:4.8.24-2ubuntu1 [477 kB]
Fetched 1817 kB in 1s (1737 kB/s)
Selecting previously unselected package libssh2-1:amd64.
(Reading database ... 72226 files and directories currently installed.)
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
0 upgraded, 1 newly installed, 0 to remove and 195 not upgraded.
Need to get 43.0 kB of archives.
After this operation, 115 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 tree amd64 1.8.0-1 [43.0 kB]
Fetched 43.0 kB in 0s (349 kB/s)
Selecting previously unselected package tree.
(Reading database ... 72625 files and directories currently installed.)
Preparing to unpack .../tree_1.8.0-1_amd64.deb ...
Unpacking tree (1.8.0-1) ...
Setting up tree (1.8.0-1) ...
Processing triggers for man-db (2.9.1-1) ...
namespace/stage created
Creating My-chart
total 12K
drwxr-xr-x 3 root root 4.0K Jul 28 04:41 .
drwxr-xr-x 3 root root 4.0K Jul 28 04:41 ..
drwxr-xr-x 4 root root 4.0K Jul 28 04:41 My-chart
-rw-r--r-- 1 root root    0 Jul 28 04:41 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Jul 28 04:41 stage-pv.yaml
-rw-r--r-- 1 root root    0 Jul 28 04:41 stage-pvc.yaml
.
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   |-- hpa.yaml
|   |-- ingress.yaml
|   |-- service.yaml
|   |-- serviceaccount.yaml
|   `-- tests
|       `-- test-connection.yaml
`-- values.yaml

3 directories, 10 files
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm create chart-test-1
Creating chart-test-1
controlplane $ 
controlplane $ cd chart-test-1/
controlplane $ 
controlplane $ ls
Chart.yaml  charts  templates  values.yaml
controlplane $ 
controlplane $ rm -r templates/*
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/My-chart
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage
controlplane $ 
controlplane $ ls
My-chart  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ cd chart-test-2/
bash: cd: chart-test-2/: No such file or directory
controlplane $ 
controlplane $ helm create chart-test-2
Creating chart-test-2
controlplane $ 
controlplane $ ls
My-chart  chart-test-2  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ helm template chart-test-2 
---
# Source: chart-test-2/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: release-name-chart-test-2
  labels:
    helm.sh/chart: chart-test-2-0.1.0
    app.kubernetes.io/name: chart-test-2
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
---
# Source: chart-test-2/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: release-name-chart-test-2
  labels:
    helm.sh/chart: chart-test-2-0.1.0
    app.kubernetes.io/name: chart-test-2
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app.kubernetes.io/name: chart-test-2
    app.kubernetes.io/instance: release-name
---
# Source: chart-test-2/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-chart-test-2
  labels:
    helm.sh/chart: chart-test-2-0.1.0
    app.kubernetes.io/name: chart-test-2
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: chart-test-2
      app.kubernetes.io/instance: release-name
  template:
    metadata:
      labels:
        app.kubernetes.io/name: chart-test-2
        app.kubernetes.io/instance: release-name
    spec:
      serviceAccountName: release-name-chart-test-2
      securityContext:
        {}
      containers:
        - name: chart-test-2
          securityContext:
            {}
          image: "nginx:1.16.0"
          imagePullPolicy: IfNotPresent
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {}
---
# Source: chart-test-2/templates/tests/test-connection.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "release-name-chart-test-2-test-connection"
  labels:
    helm.sh/chart: chart-test-2-0.1.0
    app.kubernetes.io/name: chart-test-2
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['release-name-chart-test-2:80']
  restartPolicy: Never
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm lint chart-test-2
==> Linting chart-test-2
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm install chart-test-2 
Error: INSTALLATION FAILED: must either provide a name or specify --generate-name
controlplane $ 
controlplane $ helm install chart-test-2 chart-test-2 
NAME: chart-test-2
LAST DEPLOYED: Thu Jul 28 04:58:25 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=chart-test-2,app.kubernetes.io/instance=chart-test-2" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
chart-test-2-5cff676d76-dkh6c         1/1     Running   0          27s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
controlplane $ 
controlplane $ kubectl get ns 
NAME              STATUS   AGE
default           Active   80d
kube-node-lease   Active   80d
kube-public       Active   80d
kube-system       Active   80d
stage             Active   18m
controlplane $ 
controlplane $ kubectl get deployments.apps 
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
chart-test-2   1/1     1            1           49s
controlplane $ 
controlplane $ kubectl get deploy chart-test-2 -o jsonpath={.spec.template.spec.containers[0].image}
nginx:1.16.0controlplane $ 
controlplane $ 
controlplane $ helm get values chart-test-2 
USER-SUPPLIED VALUES:
null
controlplane $ 
controlplane $ ls
My-chart  chart-test-2  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ cd chart-test-2/
controlplane $ 
controlplane $ ls
Chart.yaml  charts  templates  values.yaml
controlplane $ 
controlplane $ 
```
