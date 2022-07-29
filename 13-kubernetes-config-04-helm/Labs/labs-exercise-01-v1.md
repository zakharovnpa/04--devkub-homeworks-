## Задание 1: подготовить helm чарт для приложения. Вариант 1

### 1. Подготовка рабочего пространства
* Устанавливаем Helm
* Включаем автодополнение для Helm
* Добавляем репозиторий чартов stable
* Добавляем репозиторий чартов prometheus-community
* Устанавливаем nfs-server
* Устанавливаем mc
* Создаем namespace stage
* Создаем namespace app1
* Создаем namespace app2
* Создаем директорию проекта My-Procect/stage с пустыми файлами
* Создаем чарт chart01
* Деплоим alertmanager
* Деплоим nginx-ingress

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
kubectl create namespace stage && \
kubectl create namespace app1 && \
kubectl create namespace app2 && \
mkdir -p My-Procect/stage && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
helm create chart01 && \
ls -lha && \
cd chart01 && \
tree && \
cd charts && \
helm pull prometheus-community/alertmanager && \
helm pull stable/nginx-ingress && \
tar -zxvf alertmanager-0.19.0.tgz && \
tar -xvzf nginx-ingress-1.41.3.tgz && \
cd alertmanager && \
helm install alertmanager prometheus-community/alertmanager && \
cd ../nginx-ingress && \
helm install nginx-ingress stable/nginx-ingress && \
clear && \
kubectl get po && \
date && \
pwd
```

### 2. Команды
* Создание первого чарта
```
helm repo list
```
* Создание чарта first в папке charts
```
helm create first
```
* Сборка ресурсов из шаблона 
```
helm template first
```
* Linter
```
helm lint first
```
* Деплой Release deploy
```
helm install demo-release charts/01-simple
kubectl get ns
```
* Версия образа
```
kubectl get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}
```
* Обновление приложения после изменения версии. Upgrade release
```
helm upgrade demo-release charts/01-simple
```
* Обновление с установкой. Upgrade or install release
```
helm upgrade --install demo-release charts/01-simple
```
* Удаление релиза. Uninstall release
```
helm uninstall demo-release
```
* Установка релиза в новый namespace с переопределением параметров
```
helm install new-release -f charts/01-simple/new-values2.yaml charts/01-simple
kubectl -n new get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}
```
* Просмотр пользовательских переменных
```
helm get values demo-release
helm get values new-release
```
* Список релизов
```
helm list
```
* Отладка
```
helm install --dry-run --debug aaa --set namespace=aaa charts/01-simple
```
