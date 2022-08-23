## KH-220823-0740. Подготовка к выполнению ДЗ. Создание стартового скрипта. Установка Qbec. В кластере K8s разворачивание тестовго приложения. Изучение директорий приложения в Qbec 

- [KH-220823-0740. Подготовка к выполнению ДЗ. Создание стартового скрипта. Установка Qbec. В кластере K8s разворачивание тестовго приложения. Изучение директорий приложения в Qbec ](/13-kubernetes-config-05-qbec/Labs/labs-220823-0740-install-qbec-and-deploy-testing-apps.md)

### Стартовый скрипт
* Описание работы скрипта:
  * Установка служебных программ MC, Tree
  * Создание директории для проектов My-Project
  * Скачивание архива с ПО Qbec, разворачивание
  * Инициализация тестового приложения
  * Просмотр содержимого каталога приложени
  * 



```sh
apt install mc -y && apt install tree && \
mkdir -p My-Project && cd My-Project && \
wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
tar -zxvf qbec-linux-amd64.tar.gz && \
cp qbec jsonnet-qbec /usr/local/bin && \
qbec init demo --with-example && cd demo && \
qbec show -O default && \
cd .. && tree && cat README.md

```
### Установка Qbec
Установка была выполнена в стартовом скрипте:
```sh
wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
tar -zxvf qbec-linux-amd64.tar.gz && \
cp qbec jsonnet-qbec /usr/local/bin && \
qbec init demo --with-example && \
type qbec && whereis qbec
```
* Установлен Qbec
```ps
controlplane $ type qbec
qbec is hashed (/usr/local/bin/qbec)
controlplane $ 
controlplane $ whereis qbec
qbec: /usr/local/bin/qbec
```

### В кластере K8s разворачивание тестовго приложения.

### Изучение директорий приложения в Qbec

```
COMPONENT                      KIND                           NAME                                     NAMESPACE
hello                          ConfigMap                      demo-config                              
hello                          Deployment                     demo-deploy                              
.
```
##### Директория /root/My-Project
```
controlplane $ pwd
/root/My-Project
controlplane $ 
controlplane $ tree
.
|-- CHANGELOG.md
|-- LICENSE
|-- README.md
|-- demo
|   |-- components
|   |   `-- hello.jsonnet
|   |-- environments
|   |   |-- base.libsonnet
|   |   `-- default.libsonnet
|   |-- params.libsonnet
|   `-- qbec.yaml
|-- jsonnet-qbec
|-- licenselint.sh
|-- qbec
`-- qbec-linux-amd64.tar.gz

3 directories, 12 files
```
##### demo/components/hello.jsonnet 
```js

local p = import '../params.libsonnet';
local params = p.components.hello;

[
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: 'demo-config',
    },
    data: {
      'index.html': params.indexData,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'demo-deploy',
      labels: {
        app: 'demo-deploy',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'demo-deploy',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'demo-deploy',
          },
        },
        spec: {
          containers: [
            {
              name: 'main',
              image: 'nginx:stable',
              imagePullPolicy: 'Always',
              volumeMounts: [
                {
                  name: 'web',
                  mountPath: '/usr/share/nginx/html',
                },
              ],
            },
          ],
          volumes: [
            {
              name: 'web',
              configMap: {
                name: 'demo-config',
              },
            },
          ],
        },
      },
    },
  },
]
```
##### demo/params.libsonnet         
```js
// this file returns the params for the current qbec environment
local env = std.extVar('qbec.io/env');
local paramsMap = import 'glob-import:environments/*.libsonnet';
local baseFile = if env == '_' then 'base' else env;
local key = 'environments/%s.libsonnet' % baseFile;

if std.objectHas(paramsMap, key)
then paramsMap[key]
else error 'no param file %s found for environment %s' % [key, env]
```
##### cat demo/qbec.yaml    
```js
apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: demo
spec:
  environments:
    default:
      defaultNamespace: default
      server: https://172.30.1.2:6443
  vars: {}
```
##### demo/qbec.yaml     
```js
apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: demo
spec:
  environments:
    default:
      defaultNamespace: default
      server: https://172.30.1.2:6443
  vars: {}
```

##### demo/environments/base.libsonnet 
```

// this file has the baseline default parameters
{
  components: {
    hello: {
      indexData: 'hello baseline\n',
      replicas: 1,
    },
  },
}
```
##### demo/environments/default.libsonnet 
```js
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    hello +: {
      indexData: 'hello default\n',
      replicas: 2,
    },
  }
}
```
#### Диагностика вместе с Qbec
```
controlplane $ qbec env list
✘ unable to find source root at or above /root/My-Project
controlplane $ 
controlplane $ pwd
/root/My-Project
controlplane $ 
controlplane $ cd demo/
controlplane $ 
controlplane $ pwd
/root/My-Project/demo
controlplane $ 
controlplane $ qbec env list
default
```
##### qbec show _
```
1 components evaluated in 2ms
---
apiVersion: v1
data:
  index.html: |
    hello baseline
kind: ConfigMap
metadata:
  annotations:
    qbec.io/component: hello
  labels:
    qbec.io/application: demo
    qbec.io/environment: _
  name: demo-config

---
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    qbec.io/component: hello
  labels:
    app: demo-deploy
    qbec.io/application: demo
    qbec.io/environment: _
  name: demo-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-deploy
  template:
    metadata:
      labels:
        app: demo-deploy
    spec:
      containers:
      - image: nginx:stable
        imagePullPolicy: Always
        name: main
        volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: web
      volumes:
      - configMap:
          name: demo-config
        name: web
```
##### qbec show default
```
1 components evaluated in 2ms
---
apiVersion: v1
data:
  index.html: |
    hello default
kind: ConfigMap
metadata:
  annotations:
    qbec.io/component: hello
  labels:
    qbec.io/application: demo
    qbec.io/environment: default
  name: demo-config

---
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    qbec.io/component: hello
  labels:
    app: demo-deploy
    qbec.io/application: demo
    qbec.io/environment: default
  name: demo-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-deploy
  template:
    metadata:
      labels:
        app: demo-deploy
    spec:
      containers:
      - image: nginx:stable
        imagePullPolicy: Always
        name: main
        volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: web
      volumes:
      - configMap:
          name: demo-config
        name: web
 ```
 ##### qbec param list _
 ```
COMPONENT                      NAME                           VALUE
hello                          indexData                      "hello baseline\n"
hello                          replicas                       1
```
##### qbec param list default
```
COMPONENT                      NAME                           VALUE
hello                          indexData                      "hello default\n"
hello                          replicas                       2
```
##### qbec param diff default
```
--- baseline
+++ environment: default
@@ -2,2 +2,2 @@
-hello                          indexData                      "hello baseline\n"
-hello                          replicas                       1
+hello                          indexData                      "hello default\n"
+hello                          replicas                       2
```
