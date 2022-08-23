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
##### Файл [qbec.yaml](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B0%D0%BB%D0%B5%D0%B5-%D0%BC%D1%8B-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%B5%D0%BC-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5-environments-%D0%BF%D0%BE%D0%B4-%D0%B8%D0%BC%D0%B5%D0%BD%D0%B5%D0%BC-stage-%D0%B2-namespace-stage-%D0%B8-%D0%BF%D0%BE%D0%B4-%D0%B8%D0%BC%D0%B5%D0%BD%D0%B5%D0%BC-prod-%D0%B2-namespace-prod-%D0%B0%D0%B4%D1%80%D0%B5%D1%81-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0-k8s---17230126443-%D0%BF%D1%80%D0%B5%D0%B4%D0%B2%D0%B0%D1%80%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE-%D0%BF%D1%80%D0%BE%D1%81%D1%82%D1%80%D0%B0%D0%BD%D1%81%D1%82%D0%B2%D0%B0%D0%B8%D0%BC%D0%B5%D0%BD-stage-%D0%B8-prod-%D0%B4%D0%BE%D0%BB%D0%B6%D0%BD%D1%8B-%D1%81%D1%83%D1%89%D0%B5%D1%81%D1%82%D0%B2%D0%BE%D0%B2%D0%B0%D1%82%D1%8C-%D0%B2-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B5)
##### Файл params.libsonnet

#### Директория /components
##### Файл fb-pod.jsonnet. Создать самостоятельно

#### Директория /environments
##### Файл base.libsonnet
##### Файл default.libsonnet




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
[Назад к описанию директории](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-05-qbec/Labs/labs-220823-1010-create-directory-for-qbec-and-create-file-apps-for-deploy.md#%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D1%8F-fb-pod)
