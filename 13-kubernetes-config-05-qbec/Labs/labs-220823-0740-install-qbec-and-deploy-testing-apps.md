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
