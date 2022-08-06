## ЛР-1. Задание 3(*): Работа с Jsonnet. Преобразование файлов yaml в jsonnet. Деплой файлов jsonnet в Kubernetes. Вариант 1

### Задача: 
1. создать файлы `.jsonnet` для создания из них файлов манифестов для деплойментов, сервсов и прочее. 
2. сохранить эти файлы в формате `yaml`. 
3. на сонове этих файлов создать чарты Helm

#### 1. создать файлы `.jsonnet` для создания из них файлов манифестов для деплойментов, сервсов и прочее.


Используем инструмент преобразования фалов манифестов Kubernetes в файлы jsonnet.

[Conversion Tool](https://jsonnet.org/articles/kubernetes.html)

Не разобрался что это за инструмент.

Но есть [Онлайн конвертер](https://www.json2yaml.com/convert-yaml-to-json)

* Результат работы конвертера
* kube.yaml
```yml
kind: ReplicationController
apiVersion: v1
metadata:
  name: spark-master-controller
spec:
  replicas: 1
  selector:
    component: spark-master
  template:
    metadata:
      labels:
        component: spark-master
    spec:
      containers:
        - name: spark-master
          image: k8s.gcr.io/spark:1.5.2_v1
          command: ["/start-master"]
          ports:
            - containerPort: 7077
            - containerPort: 8080
          resources:
            requests:
              cpu: 100m
```

* kube.json
```json
{
  "kind": "ReplicationController",
  "apiVersion": "v1",
  "metadata": {
    "name": "spark-master-controller"
  },
  "spec": {
    "replicas": 1,
    "selector": {
      "component": "spark-master"
    },
    "template": {
      "metadata": {
        "labels": {
          "component": "spark-master"
        }
      },
      "spec": {
        "containers": [
          {
            "name": "spark-master",
            "image": "k8s.gcr.io/spark:1.5.2_v1",
            "command": [
              "/start-master"
            ],
            "ports": [
              {
                "containerPort": 7077
              },
              {
                "containerPort": 8080
              }
            ],
            "resources": {
              "requests": {
                "cpu": "100m"
              }
            }
          }
        ]
      }
    }
  }
}

```
* Конвертируем в формат json файл [fb-pod.yaml](/13-kubernetes-config-02-mounts/Files/fb-pod.yaml)
* Результат [fb-pod.json]()
* 
```json
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "fb-pod",
    "namespace": "stage"
  },
  "spec": {
    "replicas": 1,
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
            "image": "zakharovnpa/k8s-frontend:05.07.22",
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
            "image": "zakharovnpa/k8s-backend:05.07.22",
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
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
```
##### Инструменты для конвертирования:
- [yaml2jsonnet](https://github.com/waisbrot/yaml2jsonnet)
* Установка
```
apt install jsonnet

apt install python3-pip -y

pip install yaml2jsonnet

```
* Команда преобразования. 
> В файле `trivial.yaml` для корректного преобразования должен быть описан только один объект Kubernetes, 
например, Deployment, Pod, Service (не несколько в одном файле). Иначе будут ошибки при перобразовании.

```
yaml2jsonnet trivial.yaml | jsonnetfmt - -o trivial.jsonnet
```
* Создаем из этого файла файл для jsonnet
*  [fb-pod.jsonnet](13-kubernetes-config-04-helm/Files/fb-pod.jsonnet)

```json
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: 'fb-pod',
    namespace: 'stage',
  },
  spec: {
    replicas: 1,
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: 'zakharovnpa/k8s-frontend:05.07.22',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: 'zakharovnpa/k8s-backend:05.07.22',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: {
            },
          },
        ],
      },
    },
  },
}
```
##### Далее из jsonnet создаем yaml
```
jsonnet pod.jsonnet > 2-pod.yaml
```
##### Далее добавляем атрибуты файлов yaml. Открытие файла --- и закрытие файла ... 
* 2-pod.yaml
```yaml
---
{
   "apiVersion": "v1",
   "kind": "Pod",
   "metadata": {
      "labels": {
         "app": "nginx"
      },
      "name": "nginx",
      "namespace": "default"
   },
   "spec": {
      "containers": [
         {
            "image": "nginx:1.20",
            "imagePullPolicy": "IfNotPresent",
            "name": "nginx"
         }
      ]
   }
}
...
```
##### Деплоим файл 2-pod.yaml

```
controlplane $ kubectl apply -f 2-pod.yaml 
pod/nginx created
controlplane $ 
controlplane $ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   89d
controlplane $ 
```
##### Вывод: 
1. Из манифеста можно создать шаблон jsonnet с помощью yaml2jsonnet
2. Из шаблона jsonnet можно сделать файл yaml и задепдлоить его


#### Логи ЛР-1

* Tab 1

```
Initialising Kubernetes... done

controlplane $ 
controlplane $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  jsonnet
0 upgraded, 1 newly installed, 0 to remove and 197 not upgraded.
Need to get 378 kB of archives.
After this operation, 1964 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 jsonnet amd64 0.15.0+ds-1build1 [378 kB]
Fetched 378 kB in 1s (536 kB/s)
Selecting previously unselected package jsonnet.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../jsonnet_0.15.0+ds-1build1_amd64.deb ...
Unpacking jsonnet (0.15.0+ds-1build1) ...
Setting up jsonnet (0.15.0+ds-1build1) ...
controlplane $ 
controlplane $ 
controlplane $ apt install python3-pip -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libexpat1 libexpat1-dev libpython3-dev libpython3.8 libpython3.8-dev libpython3.8-minimal
  libpython3.8-stdlib python-pip-whl python3-dev python3-wheel python3.8 python3.8-dev
  python3.8-minimal
Suggested packages:
  python3.8-venv python3.8-doc binfmt-support
The following NEW packages will be installed:
  libexpat1-dev libpython3-dev libpython3.8-dev python-pip-whl python3-dev python3-pip python3-wheel
  python3.8-dev
The following packages will be upgraded:
  libexpat1 libpython3.8 libpython3.8-minimal libpython3.8-stdlib python3.8 python3.8-minimal
6 upgraded, 8 newly installed, 0 to remove and 191 not upgraded.
Need to get 13.0 MB of archives.
After this operation, 25.0 MB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8 amd64 3.8.10-0ubuntu1~20.04.5 [387 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8 amd64 3.8.10-0ubuntu1~20.04.5 [1625 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-stdlib amd64 3.8.10-0ubuntu1~20.04.5 [1675 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8-minimal amd64 3.8.10-0ubuntu1~20.04.5 [1905 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-minimal amd64 3.8.10-0ubuntu1~20.04.5 [717 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libexpat1 amd64 2.2.9-1ubuntu0.4 [74.4 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libexpat1-dev amd64 2.2.9-1ubuntu0.4 [117 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-dev amd64 3.8.10-0ubuntu1~20.04.5 [3951 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal/main amd64 libpython3-dev amd64 3.8.2-0ubuntu2 [7236 B]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 python-pip-whl all 20.0.2-5ubuntu1.6 [1805 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8-dev amd64 3.8.10-0ubuntu1~20.04.5 [514 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/main amd64 python3-dev amd64 3.8.2-0ubuntu2 [1212 B]
Get:13 http://archive.ubuntu.com/ubuntu focal/universe amd64 python3-wheel all 0.34.2-1 [23.8 kB]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 python3-pip all 20.0.2-5ubuntu1.6 [231 kB]
Fetched 13.0 MB in 0s (32.3 MB/s) 
(Reading database ... 72165 files and directories currently installed.)
Preparing to unpack .../00-python3.8_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../01-libpython3.8_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../02-libpython3.8-stdlib_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-stdlib:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../03-python3.8-minimal_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8-minimal (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../04-libpython3.8-minimal_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-minimal:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../05-libexpat1_2.2.9-1ubuntu0.4_amd64.deb ...
Unpacking libexpat1:amd64 (2.2.9-1ubuntu0.4) over (2.2.9-1build1) ...
Selecting previously unselected package libexpat1-dev:amd64.
Preparing to unpack .../06-libexpat1-dev_2.2.9-1ubuntu0.4_amd64.deb ...
Unpacking libexpat1-dev:amd64 (2.2.9-1ubuntu0.4) ...
Selecting previously unselected package libpython3.8-dev:amd64.
Preparing to unpack .../07-libpython3.8-dev_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-dev:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Selecting previously unselected package libpython3-dev:amd64.
Preparing to unpack .../08-libpython3-dev_3.8.2-0ubuntu2_amd64.deb ...
Unpacking libpython3-dev:amd64 (3.8.2-0ubuntu2) ...
Selecting previously unselected package python-pip-whl.
Preparing to unpack .../09-python-pip-whl_20.0.2-5ubuntu1.6_all.deb ...
Unpacking python-pip-whl (20.0.2-5ubuntu1.6) ...
Selecting previously unselected package python3.8-dev.
Preparing to unpack .../10-python3.8-dev_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8-dev (3.8.10-0ubuntu1~20.04.5) ...
Selecting previously unselected package python3-dev.
Preparing to unpack .../11-python3-dev_3.8.2-0ubuntu2_amd64.deb ...
Unpacking python3-dev (3.8.2-0ubuntu2) ...
Selecting previously unselected package python3-wheel.
Preparing to unpack .../12-python3-wheel_0.34.2-1_all.deb ...
Unpacking python3-wheel (0.34.2-1) ...
Selecting previously unselected package python3-pip.
Preparing to unpack .../13-python3-pip_20.0.2-5ubuntu1.6_all.deb ...
Unpacking python3-pip (20.0.2-5ubuntu1.6) ...
Setting up libexpat1:amd64 (2.2.9-1ubuntu0.4) ...
Setting up libpython3.8-minimal:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3-wheel (0.34.2-1) ...
Setting up libexpat1-dev:amd64 (2.2.9-1ubuntu0.4) ...
Setting up python3.8-minimal (3.8.10-0ubuntu1~20.04.5) ...
Setting up python-pip-whl (20.0.2-5ubuntu1.6) ...
Setting up libpython3.8-stdlib:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3.8 (3.8.10-0ubuntu1~20.04.5) ...
Setting up libpython3.8:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3-pip (20.0.2-5ubuntu1.6) ...
Setting up libpython3.8-dev:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3.8-dev (3.8.10-0ubuntu1~20.04.5) ...
Setting up libpython3-dev:amd64 (3.8.2-0ubuntu2) ...
Setting up python3-dev (3.8.2-0ubuntu2) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for mime-support (3.64ubuntu1) ...
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pip install yaml2jsonnet
Collecting yaml2jsonnet
  Downloading yaml2jsonnet-1.0.1-py3-none-any.whl (19 kB)
Collecting ruamel.yaml<0.17.0,>=0.16.10
  Downloading ruamel.yaml-0.16.13-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 10.5 MB/s 
Collecting ruamel.yaml.clib>=0.1.2; platform_python_implementation == "CPython" and python_version < "3.10"
  Downloading ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
     |████████████████████████████████| 570 kB 68.5 MB/s 
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, yaml2jsonnet
Successfully installed ruamel.yaml-0.16.13 ruamel.yaml.clib-0.2.6 yaml2jsonnet-1.0.1
controlplane $ 
controlplane $ 
controlplane $ vi pod.yaml
controlplane $ 
controlplane $ ls -l
total 4
lrwxrwxrwx 1 root root   1 May  2 10:23 filesystem -> /
-rw-r--r-- 1 root root 188 Aug  6 13:57 pod.yaml
controlplane $  
controlplane $ 
controlplane $ yaml2jsonnet pod.yaml | jsonnetfmt - -o pod.jsonnet
controlplane $ 
controlplane $ cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: nginx
  name: nginx
  namespace: default
spec:
  containers:
  - image: nginx:1.20
    imagePullPolicy: IfNotPresent
    name: nginx

controlplane $ 
controlplane $ 
controlplane $ cat pod.jsonnet 
{
  apiVersion: 'v1',
  kind: 'Pod',
  metadata: {
    labels: {
      app: 'nginx',
    },
    name: 'nginx',
    namespace: 'default',
  },
  spec: {
    containers: [
      {
        image: 'nginx:1.20',
        imagePullPolicy: 'IfNotPresent',
        name: 'nginx',  //
      },
    ],
  },
}
controlplane $ 
controlplane $ 
controlplane $ jsonnet -y pod.jsonnet 
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ jsonnet pod.jsonnet 
{
   "apiVersion": "v1",
   "kind": "Pod",
   "metadata": {
      "labels": {
         "app": "nginx"
      },
      "name": "nginx",
      "namespace": "default"
   },
   "spec": {
      "containers": [
         {
            "image": "nginx:1.20",
            "imagePullPolicy": "IfNotPresent",
            "name": "nginx"
         }
      ]
   }
}
controlplane $ 
controlplane $ 
controlplane $ jsonnet pod.jsonnet > 2-pod.yaml
controlplane $ 
controlplane $ vi 2-pod.yaml 
controlplane $ 
controlplane $ kubectl apply -f 2-pod.yaml 
pod/nginx created
controlplane $ 
controlplane $ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   89d
controlplane $ 
controlplane $ 
controlplane $ ls -l
total 12
-rw-r--r-- 1 root root 359 Aug  6 14:01 2-pod.yaml
lrwxrwxrwx 1 root root   1 May  2 10:23 filesystem -> /
-rw-r--r-- 1 root root 298 Aug  6 13:59 pod.jsonnet
-rw-r--r-- 1 root root 188 Aug  6 13:57 pod.yaml
controlplane $ 
controlplane $
controlplane $ cat 2-pod.yaml 
---
{
   "apiVersion": "v1",
   "kind": "Pod",
   "metadata": {
      "labels": {
         "app": "nginx"
      },
      "name": "nginx",
      "namespace": "default"
   },
   "spec": {
      "containers": [
         {
            "image": "nginx:1.20",
            "imagePullPolicy": "IfNotPresent",
            "name": "nginx"
         }
      ]
   }
}
...
controlplane $ 
```
```
controlplane $ 
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ kubectl delete -f 2-pod.yaml 
pod "nginx" deleted
controlplane $ 
controlplane $ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   89d
controlplane $ 
controlplane $ kubectl apply -f f           
fb-pod.yaml  filesystem/  
controlplane $ kubectl apply -f fb-pod.yaml 
Error from server (NotFound): error when creating "fb-pod.yaml": namespaces "stage" not found
controlplane $ kubectl create ns stage
namespace/stage created
controlplane $ 
controlplane $ kubectl apply -f fb-pod.yaml 
deployment.apps/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-wx74w   0/2     ContainerCreating   0          25s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-wx74w   2/2     Running   0          35s
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.yaml 

---
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "fb-pod",
    "namespace": "stage"
  },
  "spec": {
    "replicas": 1,
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
            "image": "zakharovnpa/k8s-frontend:05.07.22",
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
            "image": "zakharovnpa/k8s-backend:05.07.22",
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
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
...
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           3m23s
controlplane $ 
controlplane $ kubectl delete -f fb-pod.yaml 
deployment.apps "fb-pod" deleted
controlplane $ 
controlplane $ kubectl -n stage get deployments.apps 
No resources found in stage namespace.
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-wx74w   2/2     Terminating   0          3m59s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-wx74w   2/2     Terminating   0          4m12s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
No resources found in stage namespace.
controlplane $ 
controlplane $ vi fb-pod.yaml 
controlplane $ 
controlplane $ kubectl apply -f fb-pod.yaml 
deployment.apps/fb-pod created
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-h6c6s   2/2     Running   0          9s
controlplane $ 
controlplane $ 
controlplane $ 

```

* Tab 1
```
ubuntu $ 
ubuntu $ date
Sat Aug  6 12:30:20 UTC 2022
ubuntu $ 
ubuntu $ pip install yaml2jsonnet

Command 'pip' not found, but can be installed with:

apt install python3-pip

ubuntu $ apt install python3-pip
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libexpat1 libexpat1-dev libpython3-dev libpython3.8 libpython3.8-dev libpython3.8-minimal
  libpython3.8-stdlib python-pip-whl python3-dev python3-wheel python3.8 python3.8-dev
  python3.8-minimal
Suggested packages:
  python3.8-venv python3.8-doc binfmt-support
The following NEW packages will be installed:
  libexpat1-dev libpython3-dev libpython3.8-dev python-pip-whl python3-dev python3-pip python3-wheel
  python3.8-dev
The following packages will be upgraded:
  libexpat1 libpython3.8 libpython3.8-minimal libpython3.8-stdlib python3.8 python3.8-minimal
6 upgraded, 8 newly installed, 0 to remove and 187 not upgraded.
Need to get 13.0 MB of archives.
After this operation, 25.0 MB of additional disk space will be used.
Do you want to continue? [Y/n] н
Abort.
ubuntu $ 
ubuntu $ apt install python3-pip -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libexpat1 libexpat1-dev libpython3-dev libpython3.8 libpython3.8-dev libpython3.8-minimal
  libpython3.8-stdlib python-pip-whl python3-dev python3-wheel python3.8 python3.8-dev
  python3.8-minimal
Suggested packages:
  python3.8-venv python3.8-doc binfmt-support
The following NEW packages will be installed:
  libexpat1-dev libpython3-dev libpython3.8-dev python-pip-whl python3-dev python3-pip python3-wheel
  python3.8-dev
The following packages will be upgraded:
  libexpat1 libpython3.8 libpython3.8-minimal libpython3.8-stdlib python3.8 python3.8-minimal
6 upgraded, 8 newly installed, 0 to remove and 187 not upgraded.
Need to get 13.0 MB of archives.
After this operation, 25.0 MB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libexpat1 amd64 2.2.9-1ubuntu0.4 [74.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8 amd64 3.8.10-0ubuntu1~20.04.5 [1625 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8 amd64 3.8.10-0ubuntu1~20.04.5 [387 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-stdlib amd64 3.8.10-0ubuntu1~20.04.5 [1675 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8-minimal amd64 3.8.10-0ubuntu1~20.04.5 [1905 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-minimal amd64 3.8.10-0ubuntu1~20.04.5 [717 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libexpat1-dev amd64 2.2.9-1ubuntu0.4 [117 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpython3.8-dev amd64 3.8.10-0ubuntu1~20.04.5 [3951 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal/main amd64 libpython3-dev amd64 3.8.2-0ubuntu2 [7236 B]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 python-pip-whl all 20.0.2-5ubuntu1.6 [1805 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 python3.8-dev amd64 3.8.10-0ubuntu1~20.04.5 [514 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/main amd64 python3-dev amd64 3.8.2-0ubuntu2 [1212 B]
Get:13 http://archive.ubuntu.com/ubuntu focal/universe amd64 python3-wheel all 0.34.2-1 [23.8 kB]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 python3-pip all 20.0.2-5ubuntu1.6 [231 kB]
Fetched 13.0 MB in 1s (8880 kB/s) 
(Reading database ... 71961 files and directories currently installed.)
Preparing to unpack .../00-libexpat1_2.2.9-1ubuntu0.4_amd64.deb ...
Unpacking libexpat1:amd64 (2.2.9-1ubuntu0.4) over (2.2.9-1build1) ...
Preparing to unpack .../01-libpython3.8_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../02-python3.8_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../03-libpython3.8-stdlib_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-stdlib:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../04-python3.8-minimal_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8-minimal (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Preparing to unpack .../05-libpython3.8-minimal_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-minimal:amd64 (3.8.10-0ubuntu1~20.04.5) over (3.8.10-0ubuntu1~20.04.1) ...
Selecting previously unselected package libexpat1-dev:amd64.
Preparing to unpack .../06-libexpat1-dev_2.2.9-1ubuntu0.4_amd64.deb ...
Unpacking libexpat1-dev:amd64 (2.2.9-1ubuntu0.4) ...
Selecting previously unselected package libpython3.8-dev:amd64.
Preparing to unpack .../07-libpython3.8-dev_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking libpython3.8-dev:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Selecting previously unselected package libpython3-dev:amd64.
Preparing to unpack .../08-libpython3-dev_3.8.2-0ubuntu2_amd64.deb ...
Unpacking libpython3-dev:amd64 (3.8.2-0ubuntu2) ...
Selecting previously unselected package python-pip-whl.
Preparing to unpack .../09-python-pip-whl_20.0.2-5ubuntu1.6_all.deb ...
Unpacking python-pip-whl (20.0.2-5ubuntu1.6) ...
Selecting previously unselected package python3.8-dev.
Preparing to unpack .../10-python3.8-dev_3.8.10-0ubuntu1~20.04.5_amd64.deb ...
Unpacking python3.8-dev (3.8.10-0ubuntu1~20.04.5) ...
Selecting previously unselected package python3-dev.
Preparing to unpack .../11-python3-dev_3.8.2-0ubuntu2_amd64.deb ...
Unpacking python3-dev (3.8.2-0ubuntu2) ...
Selecting previously unselected package python3-wheel.
Preparing to unpack .../12-python3-wheel_0.34.2-1_all.deb ...
Unpacking python3-wheel (0.34.2-1) ...
Selecting previously unselected package python3-pip.
Preparing to unpack .../13-python3-pip_20.0.2-5ubuntu1.6_all.deb ...
Unpacking python3-pip (20.0.2-5ubuntu1.6) ...
Setting up libexpat1:amd64 (2.2.9-1ubuntu0.4) ...
Setting up libpython3.8-minimal:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3-wheel (0.34.2-1) ...
Setting up libexpat1-dev:amd64 (2.2.9-1ubuntu0.4) ...
Setting up python3.8-minimal (3.8.10-0ubuntu1~20.04.5) ...
Setting up python-pip-whl (20.0.2-5ubuntu1.6) ...
Setting up libpython3.8-stdlib:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3.8 (3.8.10-0ubuntu1~20.04.5) ...
Setting up libpython3.8:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3-pip (20.0.2-5ubuntu1.6) ...
Setting up libpython3.8-dev:amd64 (3.8.10-0ubuntu1~20.04.5) ...
Setting up python3.8-dev (3.8.10-0ubuntu1~20.04.5) ...
Setting up libpython3-dev:amd64 (3.8.2-0ubuntu2) ...
Setting up python3-dev (3.8.2-0ubuntu2) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for mime-support (3.64ubuntu1) ...
ubuntu $ 
ubuntu $ 
ubuntu $ pip install yaml2jsonnet
Collecting yaml2jsonnet
  Downloading yaml2jsonnet-1.0.1-py3-none-any.whl (19 kB)
Collecting ruamel.yaml<0.17.0,>=0.16.10
  Downloading ruamel.yaml-0.16.13-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 10.5 MB/s 
Collecting ruamel.yaml.clib>=0.1.2; platform_python_implementation == "CPython" and python_version < "3.10"
  Downloading ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
     |████████████████████████████████| 570 kB 75.7 MB/s 
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, yaml2jsonnet
Successfully installed ruamel.yaml-0.16.13 ruamel.yaml.clib-0.2.6 yaml2jsonnet-1.0.1
ubuntu $ 
ubuntu $ yaml2jsonnet --version
usage: yaml2jsonnet [-h] [-o OUT] [-c DOCUMENT_COMMENTS] [-v] yaml
yaml2jsonnet: error: the following arguments are required: yaml
ubuntu $ yaml2jsonnet -v       
usage: yaml2jsonnet [-h] [-o OUT] [-c DOCUMENT_COMMENTS] [-v] yaml
yaml2jsonnet: error: the following arguments are required: yaml
ubuntu $ 
ubuntu $ 
ubuntu $ vi 157.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet 157.yaml | jsonnetfmt - -o 157.jsonnet

Command 'jsonnetfmt' not found, but can be installed with:

apt install jsonnet

ubuntu $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  jsonnet
0 upgraded, 1 newly installed, 0 to remove and 187 not upgraded.
Need to get 378 kB of archives.
After this operation, 1964 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 jsonnet amd64 0.15.0+ds-1build1 [378 kB]
Fetched 378 kB in 0s (1991 kB/s)
Selecting previously unselected package jsonnet.
(Reading database ... 72423 files and directories currently installed.)
Preparing to unpack .../jsonnet_0.15.0+ds-1build1_amd64.deb ...
Unpacking jsonnet (0.15.0+ds-1build1) ...
Setting up jsonnet (0.15.0+ds-1build1) ...
ubuntu $ 
ubuntu $ 
ubuntu $ yaml2jsonnet 157.yaml | jsonnetfmt - -o 157.jsonnet
ubuntu $ 
ubuntu $ ls -
ls: cannot access '-': No such file or directory
ubuntu $ 
ubuntu $ ls -l
total 8
-rw-r--r-- 1 root root 65 Aug  6 12:36 157.jsonnet
-rw-r--r-- 1 root root 45 Aug  6 12:34 157.yaml
lrwxrwxrwx 1 root root  1 May  2 10:23 filesystem -> /
ubuntu $ 
ubuntu $ cat 157.yaml 
---
# simple example
- hello: world
  one: 1
ubuntu $ 
ubuntu $ cat 157.jsonnet 
[
  // simple example
  {
    hello: 'world',
    one: 1,
  },
]
ubuntu $ 
ubuntu $ 
ubuntu $ vi fb-pod.yaml
ubuntu $ 
ubuntu $ 
ubuntu $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 284, in _stream
    raise MultipleDocumentsError(self, event)
yaml2jsonnet.jsonnet_renderer.MultipleDocumentsError: Expecting a single document but got multiple: Last event was DocumentStartEvent(), the state was _stream, the queue was [(StreamStartEvent,_start)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
ubuntu $ 
ubuntu $ 
ubuntu $ vi fb-pod.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 284, in _stream
    raise MultipleDocumentsError(self, event)
yaml2jsonnet.jsonnet_renderer.MultipleDocumentsError: Expecting a single document but got multiple: Last event was DocumentStartEvent(), the state was _stream, the queue was [(StreamStartEvent,_start)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
ubuntu $ 
ubuntu $ 
ubuntu $ jsonnetfmt fb-pod.yaml - -o fb-pod.jsonnet
ERROR: only one filename is allowed

ubuntu $ jsonnetfmt fb-pod.yaml -o fb-pod.jsonnet
STATIC ERROR: fb-pod.yaml:3:11: did not expect: ":"
ubuntu $ 
ubuntu $ yaml2jsonnet 157.yaml | jsonnetfmt - -o 157.jsonnet
ubuntu $ 
ubuntu $ jsonnetfmt 157.yaml -o 157.jsonnet
STATIC ERROR: 157.yaml:3:8: did not expect: ":"
ubuntu $ 
ubuntu $ jsonnetfmt - 157.yaml -o 157.jsonnet
ERROR: only one filename is allowed

ubuntu $ 
ubuntu $ yaml2jsonnet 157.yaml | cat                        
[
// simple example
{
hello:'world',one:1,},
]ubuntu $ 
ubuntu $ cat 157.yaml 
---
# simple example
- hello: world
  one: 1
ubuntu $ 
ubuntu $ cat 157.jsonnet 
[
  // simple example
  {
    hello: 'world',
    one: 1,
  },
]
ubuntu $ 
ubuntu $ vim fb-pod.yaml 
ubuntu $ 
ubuntu $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
ubuntu $ 
ubuntu $ cat fb-pod.jsonnet 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: 'fb-pod',
    namespace: 'stage',
  },
  spec: {
    replicas: 1,
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: 'zakharovnpa/k8s-frontend:05.07.22',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: 'zakharovnpa/k8s-backend:05.07.22',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: {
            },
          },
        ],
      },
    },
  },
}
ubuntu $ 
ubuntu $ 
ubuntu $ 
ubuntu $ vi service.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet service.yaml | jsonnetfmt - -o service.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 357, in _mapping_key
    raise UnhandledEventError(self, event)
yaml2jsonnet.jsonnet_renderer.UnhandledEventError: Event was not handled by the current state: Last event was MappingStartEvent(anchor=None, tag=None, implicit=True, flow_style=True), the state was _mapping_key, the queue was [(StreamStartEvent,_start), (DocumentStartEvent,_stream), (MappingStartEvent,_document), (MappingStartEvent,_mapping_key), (MappingStartEvent,_mapping_key)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
ubuntu $ 
ubuntu $ vi service.yaml
ubuntu $ 
ubuntu $ vi service.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet service.yaml | jsonnetfmt - -o service.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 357, in _mapping_key
    raise UnhandledEventError(self, event)
yaml2jsonnet.jsonnet_renderer.UnhandledEventError: Event was not handled by the current state: Last event was MappingStartEvent(anchor=None, tag=None, implicit=True, flow_style=True), the state was _mapping_key, the queue was [(StreamStartEvent,_start), (DocumentStartEvent,_stream), (MappingStartEvent,_document), (MappingStartEvent,_mapping_key), (MappingStartEvent,_mapping_key)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
ubuntu $ 
ubuntu $ vi service.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet service.yaml | jsonnetfmt - -o service.jsonnet
ubuntu $ 
ubuntu $ cat service.jsonnet 
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
    labels: {
      app: 'fb',
    },
  },
  spec: {
    type: 'NodePort',
    ports: [
      {
        port: 80,
        nodePort: '{{ .Values.nodePort }}',
      },
    ],
    selector: {
      app: 'fb-pod',
    },
  },
}
ubuntu $ 
ubuntu $ vi service.yaml
ubuntu $ 
ubuntu $ yaml2jsonnet service.yaml | jsonnetfmt - -o 2-service.jsonnet
ubuntu $ 
ubuntu $ cat 2-service.jsonnet 
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
    labels: {
      app: 'fb',
    },
  },
  spec: {
    type: 'NodePort',
    ports: [
      {
        port: 80,
        nodePort: '{{ .Values.nodePort }}',
      },
    ],
    selector: {
      app: 'fb-pod',
    },
  },
}
ubuntu $ 
ubuntu $ 
ubuntu $ 
```
