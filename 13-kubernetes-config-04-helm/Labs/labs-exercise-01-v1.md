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
### Технология сборки приложения.
1. Создание в папке templates шаблонов `helm create first`
2. Запуск сборки ресурсов из шаблона `helm template first`
  * после выполнения команды в терминале появятся содержимое файлов
```
-- first
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
```





### Логи

* Tab 1
```
controlplane $ pwd
/root/My-Procect/stage/chart01
controlplane $ 
controlplane $ helm create first
Creating first
controlplane $ 
```
```
controlplane $ helm template first
```
* serviceaccount.yaml
```yml
---
# Source: first/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
---
```
* service.yaml
```yml
# Source: first/templates/service.yaml
---
apiVersion: v1
kind: Service
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
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
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
---
```
* deployment.yaml
```yml
# Source: first/templates/deployment.yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: first
      app.kubernetes.io/instance: release-name
  template:
    metadata:
      labels:
        app.kubernetes.io/name: first
        app.kubernetes.io/instance: release-name
    spec:
      serviceAccountName: release-name-first
      securityContext:
        {}
      containers:
        - name: first
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
```
* test-connection.yaml
```yml
# Source: first/templates/tests/test-connection.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: "release-name-first-test-connection"
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
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
      args: ['release-name-first:80']
  restartPolicy: Never
---
```
