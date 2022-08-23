## ЛР-220823-1010. Подготовка к выполнению ДЗ. Создание структуры каталога приложения `fb-pod`. Создание файлов для Qbec, на основе которых будет деплоиться приложение

### 1. Создание структуры каталога приложения `fb-pod`
* Создаем проект
```
qbec init fb-pod
```
* Создалась структура каталогов
```
|-- components
|-- environments
|   |-- base.libsonnet
|   `-- default.libsonnet
|-- params.libsonnet
`-- qbec.yaml
```

#### Директория /fb-pod
##### Файл [qbec.yaml](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D1%84%D0%B0%D0%B9%D0%BB-qbecyaml-1)
##### Файл [params.libsonnet](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D1%84%D0%B0%D0%B9%D0%BB-paramslibsonnet-1)

#### Директория /components
В этой директории расположены файлы компоненты приложения
##### Файл [fb-pod.jsonnet](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D1%84%D0%B0%D0%B9%D0%BB-fb-podjsonnet-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D1%82%D1%8C-%D1%81%D0%B0%D0%BC%D0%BE%D1%81%D1%82%D0%BE%D1%8F%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE-1). Создать самостоятельно

> Согласно ДЗ необходимо создать файлы для нескольких компонентов приложения.

* Будут созданы файлы 
##### front.jsonnet
##### backend.jsonnet
##### serveice.jsonnet
##### endpoint.jsonnet



#### Директория /environments
В этой директории расположены бибилиотеки, участвующие в создани конфигурации приложения
##### Файл [base.libsonnet](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D1%84%D0%B0%D0%B9%D0%BB-baselibsonnet-1)
##### Файл [default.libsonnet](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D1%84%D0%B0%D0%B9%D0%BB-defaultlibsonnet-1)




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


### 2. Создание файлов для Qbec, на основе которых будет деплоиться приложение

#### Файл qbec.yaml
* Здесь мы создаем окружение (environments) под именем `default`, в namespace `default`. Адрес сервера K8S - 172.30.1.2:6443
* Пример qbec.yaml
```yml
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
#### Далее мы создаем окружение (environments) под именем `stage`, в namespace `stage` и под именем `prod`, в namespace `prod`. Адрес сервера K8S - 172.30.1.2:6443. Предварительно пространстваимен stage и prod должны существовать в кластере
##### Файл qbec.yaml
```yml
apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: fb-pod
spec:
  environments:
    default:
      defaultNamespace: default
      server: https://172.30.1.2:6443
  environments:
    stage:
      defaultNamespace: stage
      server: https://172.30.1.2:6443
  environments:
    prod:
      defaultNamespace: prod
      server: https://172.30.1.2:6443
  vars: {}
```
[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)

##### Файл params.libsonnet
* Пример файла из проекта `demo`
```
// this file returns the params for the current qbec environment
// этот файл возвращает параметры для текущей среды qbec

local env = std.extVar('qbec.io/env');
local paramsMap = import 'glob-import:environments/*.libsonnet';
local baseFile = if env == '_' then 'base' else env;
local key = 'environments/%s.libsonnet' % baseFile;

if std.objectHas(paramsMap, key)
then paramsMap[key]
else error 'no param file %s found for environment %s' % [key, env]
```
* Наш файл для проекта `fb-pod`
```

```


[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)


##### Файл fb-pod.jsonnet. Создать самостоятельно
* Пример файла `hello.jsonnet` из проекта `demo`
```

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
* Наш файл для проекта `fb-pod`
```

```
[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)


##### Файл base.libsonnet
В этом файле содержатся базовые параметры, которые будут переданы в конфигурацию, созданную безо всяких коррекций

* Пример файла из проекта `demo`
```

// this file has the baseline default parameters
// этот файл имеет базовые параметры по умолчанию

{
  components: {
    hello: {
      indexData: 'hello baseline\n',
      replicas: 1,
    },
  },
}
```
* Наш файл для проекта `fb-pod`
```

```
[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)


##### Файл default.libsonnet

Файл, содержит параметры, которые будут переопределены в конфигурации
* Пример файла из проекта `demo`
```
// this file has the param overrides for the default environment
// этот файл имеет переопределение параметров для среды по имени default

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
* Наш файл для проекта `fb-pod`
```

```
[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)

