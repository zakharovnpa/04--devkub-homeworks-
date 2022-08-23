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
##### Файл qbec.yaml
##### Файл params.libsonnet

#### Директория /components
##### Файл base.libsonnet
##### Файл default.libsonnet

#### Директория /environments
##### Файл 



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
Далее мы создаем окружение (environments) под именем `stage`, в namespace `stage` и под именем `prod`, в namespace `prod`. Адрес сервера K8S - 172.30.1.2:6443. Предварительно пространстваимен stage и prod должны существовать в кластере
* Наш qbec.yaml для fb-pod
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
