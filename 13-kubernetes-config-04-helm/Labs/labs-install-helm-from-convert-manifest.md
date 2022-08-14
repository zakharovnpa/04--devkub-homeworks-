## ЛР-5. Инсталляция из конвертрованных манфестов чарта Helm.
### Файлы

### Стартовый скрипт
```
date && \
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
helm completion bash > /etc/bash_completion.d/helm && \
apt install mc -y && \
apt install tree && \
apt install jsonnet && \
apt install python3-pip -y && \
pip install yaml2jsonnet
```
```
kubectl create namespace stage && \
kubectl create namespace app1 && \
kubectl create namespace app2
```
```
mkdir -p My-Project/stage && \
mkdir -p My-Project/app1 && \
mkdir -p My-Project/app2 && \
cd My-Project/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
cd ../app1 && \
touch app1-pv.yaml app1-pvc.yaml app1-front-back.yaml && \
cd ../app2 && \
touch app2-pv.yaml app2-pvc.yaml app2-front.yaml app2-back.yaml && \
cd ../stage && \
date && \
pwd
```
```
helm create fb-pod-app1 && \
cd fb-pod-app1 && \
rm values.yaml && \
touch values.yaml
```

```
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
" > values.yaml && \
cd templates && \
rm -r * && \
touch NOTES.txt deployment.yaml service.yaml && \


echo "--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to {{ .Values.namespace }} namespace. 
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------" > NOTES.txt
```

```
echo "
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": "{}",
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
" > deployment.yaml
```

```
echo "
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "{{ .Values.nodePort }}",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
" > service.yaml && \
cd .. && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
" > values.yaml && \
cd ..
```

```
helm template fb-pod-app1 && \
```

```
helm install fb-pod-app1 fb-pod-app1
```
* Стоп скрипт

### Логи

* Tab 1

```
controlplane $ date && \
> curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
> helm repo add stable https://charts.helm.sh/stable && \
> helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
> helm repo update && \
> helm install nfs-server stable/nfs-server-provisioner && \
> apt install nfs-common -y && \
> helm completion bash > /etc/bash_completion.d/helm && \
> apt install mc -y && \
> apt install tree && \
> apt install jsonnet && \
> apt install python3-pip -y && \
> pip install yaml2jsonnet
Sun Aug 14 17:34:17 UTC 2022
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  89248      0 --:--:-- --:--:-- --:--:-- 88539
Downloading https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
"stable" has been added to your repositories
"prometheus-community" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sun Aug 14 17:34:23 2022
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
0 upgraded, 6 newly installed, 0 to remove and 166 not upgraded.
Need to get 405 kB of archives.
After this operation, 1519 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtirpc-common all 1.2.5-1ubuntu0.1 [7712 B]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtirpc3 amd64 1.2.5-1ubuntu0.1 [77.9 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 405 kB in 0s (1826 kB/s)
Selecting previously unselected package libtirpc-common.
(Reading database ... 72561 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1ubuntu0.1_all.deb ...
Unpacking libtirpc-common (1.2.5-1ubuntu0.1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1ubuntu0.1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1ubuntu0.1) ...
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
Setting up libtirpc-common (1.2.5-1ubuntu0.1) ...
Setting up keyutils (1.6-6ubuntu1.1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1ubuntu0.1) ...
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
  arj catdvi | texlive-binaries dbview djvulibre-bin epub-utils genisoimage gv imagemagick libaspell-dev links | w3m | lynx odt2txt poppler-utils
  python python-boto python-tz xpdf | pdf-viewer zip
The following NEW packages will be installed:
  libssh2-1 mc mc-data
0 upgraded, 3 newly installed, 0 to remove and 166 not upgraded.
Need to get 1817 kB of archives.
After this operation, 7994 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libssh2-1 amd64 1.8.0-2.1build1 [75.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc-data all 3:4.8.24-2ubuntu1 [1265 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc amd64 3:4.8.24-2ubuntu1 [477 kB]
Fetched 1817 kB in 1s (1710 kB/s)
Selecting previously unselected package libssh2-1:amd64.
(Reading database ... 72690 files and directories currently installed.)
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
Fetched 43.0 kB in 0s (386 kB/s)
Selecting previously unselected package tree.
(Reading database ... 73089 files and directories currently installed.)
Preparing to unpack .../tree_1.8.0-1_amd64.deb ...
Unpacking tree (1.8.0-1) ...
Setting up tree (1.8.0-1) ...
Processing triggers for man-db (2.9.1-1) ...
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  jsonnet
0 upgraded, 1 newly installed, 0 to remove and 166 not upgraded.
Need to get 378 kB of archives.
After this operation, 1964 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 jsonnet amd64 0.15.0+ds-1build1 [378 kB]
Fetched 378 kB in 0s (2034 kB/s)
Selecting previously unselected package jsonnet.
(Reading database ... 73096 files and directories currently installed.)
Preparing to unpack .../jsonnet_0.15.0+ds-1build1_amd64.deb ...
Unpacking jsonnet (0.15.0+ds-1build1) ...
Setting up jsonnet (0.15.0+ds-1build1) ...
Reading package lists... Done
Building dependency tree       
Reading state information... Done
python3-pip is already the newest version (20.0.2-5ubuntu1.6).
0 upgraded, 0 newly installed, 0 to remove and 166 not upgraded.
Collecting yaml2jsonnet
  Downloading yaml2jsonnet-1.0.1-py3-none-any.whl (19 kB)
Collecting ruamel.yaml<0.17.0,>=0.16.10
  Downloading ruamel.yaml-0.16.13-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 10.1 MB/s 
Collecting ruamel.yaml.clib>=0.1.2; platform_python_implementation == "CPython" and python_version < "3.10"
  Downloading ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
     |████████████████████████████████| 570 kB 69.8 MB/s 
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, yaml2jsonnet
Successfully installed ruamel.yaml-0.16.13 ruamel.yaml.clib-0.2.6 yaml2jsonnet-1.0.1
controlplane $ 
controlplane $ 
controlplane $ kubectl create namespace stage && \
> kubectl create namespace app1 && \
> kubectl create namespace app2
namespace/stage created
namespace/app1 created
namespace/app2 created
controlplane $ 
controlplane $ 
controlplane $ mkdir -p My-Project/stage && \
> mkdir -p My-Project/app1 && \
> mkdir -p My-Project/app2 && \
> cd My-Project/stage && \
> touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
> cd ../app1 && \
> touch app1-pv.yaml app1-pvc.yaml app1-front-back.yaml && \
> cd ../app2 && \
> touch app2-pv.yaml app2-pvc.yaml app2-front.yaml app2-back.yaml && \
> cd ../stage && \
> date && \
> pwd
Sun Aug 14 17:35:29 UTC 2022
/root/My-Project/stage
controlplane $ 
controlplane $ 
controlplane $ helm create fb-pod-app1 && \
> cd fb-pod-app1 && \
> rm values.yaml && \
> touch values.yaml
Creating fb-pod-app1
controlplane $ 
controlplane $ 
controlplane
controlplane $ ls -l
total 12
-rw-r--r-- 1 root root 1147 Aug 14 17:35 Chart.yaml
drwxr-xr-x 2 root root 4096 Aug 14 17:35 charts
drwxr-xr-x 3 root root 4096 Aug 14 17:35 templates
-rw-r--r-- 1 root root    0 Aug 14 17:35 values.yaml
controlplane $ 
controlplane $ mc

controlplane $ echo "
> # Default values for fb-pod.
> # This is a YAML-formatted file.
> # Declare variables to be passed into your templates.
> 
> replicaCount: "1"
> 
> name: fb-pod-app1
> 
> namespace: app1
> 
> image:
>   repository: zakharovnpa
>   name_front: k8s-frontend
>   name_back: k8s-backend
>   tag: "05.07.22"
> nodePort: 30080
> " > values.yaml && \
> cd templates && \
> rm -r * && \
> touch NOTES.txt deployment.yaml service.yaml && \
> 
> 
> echo "--------------------------------------------------------- 
> 
> Content of NOTES.txt appears after deploy.
> 
> Deployed to {{ .Values.namespace }} namespace. 
> nodePort is port= {{ .Values.nodePort }}.
> Application name={{ .Values.name }}.
> Image tag: {{ .Values.image.tag }}.
> ReplicaCount: {{ .Values.replicaCount }}.
> 
> ---------------------------------------------------------" > NOTES.txt
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ echo "
> {
>    "apiVersion": "apps/v1",
>    "kind": "Deployment",
>    "metadata": {
>       "labels": {
>          "app": "fb-app"
>       },
>       "name": "{{ .Values.name }}",
>       "namespace": "{{ .Values.namespace }}"
>    },
>    "spec": {
>       "replicas": "{{ .Values.replicaCount }}",
>       "selector": {
>          "matchLabels": {
>             "app": "fb-app"
>          }
>       },
>       "template": {
>          "metadata": {
>             "labels": {
>                "app": "fb-app"
>             }
>          },
>          "spec": {
>             "containers": [
>                {
>                   "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
>                   "imagePullPolicy": "IfNotPresent",
>                   "name": "frontend",
>                   "ports": [
>                      {
>                         "containerPort": 80
>                      }
>                   ],
>                   "volumeMounts": [
>                      {
>                         "mountPath": "/static",
>                         "name": "my-volume"
>                      }
>                   ]
>                },
>                {
>                   "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
>                   "imagePullPolicy": "IfNotPresent",
>                   "name": "backend",
>                   "volumeMounts": [
>                      {
>                         "mountPath": "/tmp/cache",
>                         "name": "my-volume"
>                      }
>                   ]
>                }
>             ],
>             "volumes": [
>                {
>                   "emptyDir": "{}",
>                   "name": "my-volume"
>                }
>             ]
>          }
>       }
>    }
> }
> " > deployment.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ echo "
> {
>    "apiVersion": "v1",
>    "kind": "Service",
>    "metadata": {
>       "labels": {
>          "app": "fb"
>       },
>       "name": "{{ .Values.name }}",
>       "namespace": "{{ .Values.namespace }}"
>    },
>    "spec": {
>       "ports": [
>          {
>             "nodePort": "{{ .Values.nodePort }}",
>             "port": 80
>          }
>       ],
>       "selector": {
>          "app": "fb-pod"
>       },
>       "type": "NodePort"
>    }
> }
> " > service.yaml && \
> cd .. && \
> echo "
> # Default values for fb-pod.
> # This is a YAML-formatted file.
> # Declare variables to be passed into your templates.
> 
> replicaCount: "1"
> 
> name: fb-pod-app1
> 
> namespace: app1
> 
> image:
>   repository: zakharovnpa
>   name_front: k8s-frontend
>   name_back: k8s-backend
>   tag: "05.07.22"
> nodePort: 30080
> " > values.yaml && \
> cd ..
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ mc

controlplane $ helm template fb-pod-app1     
---
# Source: fb-pod-app1/templates/service.yaml
{
   apiVersion: v1,
   kind: Service,
   metadata: {
      labels: {
         app: fb
      },
      name: fb-pod-app1,
      namespace: app1
   },
   spec: {
      ports: [
         {
            nodePort: 30080,
            port: 80
         }
      ],
      selector: {
         app: fb-pod
      },
      type: NodePort
   }
}
---
# Source: fb-pod-app1/templates/deployment.yaml
{
   apiVersion: apps/v1,
   kind: Deployment,
   metadata: {
      labels: {
         app: fb-app
      },
      name: fb-pod-app1,
      namespace: app1
   },
   spec: {
      replicas: 1,
      selector: {
         matchLabels: {
            app: fb-app
         }
      },
      template: {
         metadata: {
            labels: {
               app: fb-app
            }
         },
         spec: {
            containers: [
               {
                  image: zakharovnpa/k8s-frontend:05.07.22,
                  imagePullPolicy: IfNotPresent,
                  name: frontend,
                  ports: [
                     {
                        containerPort: 80
                     }
                  ],
                  volumeMounts: [
                     {
                        mountPath: /static,
                        name: my-volume
                     }
                  ]
               },
               {
                  image: zakharovnpa/k8s-backend:05.07.22,
                  imagePullPolicy: IfNotPresent,
                  name: backend,
                  volumeMounts: [
                     {
                        mountPath: /tmp/cache,
                        name: my-volume
                     }
                  ]
               }
            ],
            volumes: [
               {
                  emptyDir: {},
                  name: my-volume
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubrctl in app1 get pod
kubrctl: command not found
controlplane $ kubectl in app1 get pod
error: unknown command "in" for "kubectl"

Did you mean this?
        run
        cp
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get pod
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
No resources found in app1 namespace.
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1
NAME: fb-pod-app1
LAST DEPLOYED: Sun Aug 14 17:46:04 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   0/1     1            0           15s
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS              RESTARTS   AGE
fb-pod-app1-6464948946-f62hx   0/2     ContainerCreating   0          21s
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-f62hx   2/2     Running   0          44s
controlplane $ 
controlplane $ 
```

* Продолжение скрпта (не участвует в ЛР)
```
cp -r fb-pod-app1 fb-pod-app2 && \
cp -r fb-pod-app1 fb-pod-app3 && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "12.07.22"
nodePort: 30081
" > fb-pod-app2/values.yaml && \



echo "
apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "13.07.22"
" > fb-pod-app3/Chart.yaml && \


echo "
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.07.22"
" > fb-pod-app2/Chart.yaml && \



echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "13.07.22"
nodePort: 30082
" > fb-pod-app3/values.yaml && \


kubectl -n app1 get po && \
echo "kubectl -n app1 get po"
```
