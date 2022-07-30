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
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
./get_helm.sh
```

```ps
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
mkdir -p My-Project/stage && \
cd My-Project/stage && \
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
helm create fb-pod
```
* Сборка ресурсов из шаблона 
```
helm template fb-pod
```
* Linter
```
helm lint fb-pod
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

### Задание: 
Используя манифесты разработанного приложения frontend,backend, database
создать шаблоны для упаковки в чарт составных частей приложений.

В результате получить файлы:
  * values.yaml
  * NOTES.txt
  * deployment.yaml
  * service.yaml
  * Chart.yaml
  * 
    
### Процесс заполнения шаблона
* Источник - манифест `fb-pod.yaml`
```yml
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: stage
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
```

* Приемник - файл шаблона `deployment.yaml`
```yml
---
{{- $svcClusterPort := .Values.service.clusterPort -}}
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "alertmanager.fullname" . }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
{{- if .Values.statefulSet.annotations }}
  annotations:
    {{ toYaml .Values.statefulSet.annotations | nindent 4 }}
{{- end }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "alertmanager.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "alertmanager.fullname" . }}-headless
  template:
    metadata:
      labels:
        {{- include "alertmanager.selectorLabels" . | nindent 8 }}
{{- if .Values.podLabels }}
        {{ toYaml .Values.podLabels | nindent 8 }}
{{- end }}
      annotations:
      {{- if not .Values.configmapReload.enabled }}
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
      {{- end }}
{{- if .Values.podAnnotations }}
        {{- toYaml .Values.podAnnotations | nindent 8 }}
{{- end }}
    spec:
    {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      serviceAccountName: {{ include "alertmanager.serviceAccountName" . }}
    {{- with .Values.dnsConfig }}
      dnsConfig:
        {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.topologySpreadConstraints }}
      topologySpreadConstraints: {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        {{- if and (.Values.configmapReload.enabled) (.Values.config) }}
        - name: {{ .Chart.Name }}-{{ .Values.configmapReload.name }}
          image: "{{ .Values.configmapReload.image.repository }}:{{ .Values.configmapReload.image.tag }}"
          imagePullPolicy: "{{ .Values.configmapReload.image.pullPolicy }}"
          args:
            - --volume-dir=/etc/alertmanager
            - --webhook-url=http://127.0.0.1:{{ .Values.service.port }}/-/reload
          resources:
            {{- toYaml .Values.configmapReload.resources | nindent 12 }}
          {{- if .Values.configmapReload.containerPort }}
          ports:
            - containerPort: {{ .Values.configmapReload.containerPort }}
          {{- end }}
          volumeMounts:
            - name: config
              mountPath: /etc/alertmanager
        {{- end }}
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          env:
            - name: POD_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.podIP
{{- if .Values.command }}
          command:
            {{- toYaml .Values.command | nindent 12 }}
{{- end }}
          args:
            - --storage.path=/alertmanager
            - --config.file=/etc/alertmanager/alertmanager.yml
            {{- if or (gt (int .Values.replicaCount) 1) (.Values.additionalPeers) }}
            - --cluster.advertise-address=[$(POD_IP)]:{{ $svcClusterPort }}
            - --cluster.listen-address=0.0.0.0:{{ $svcClusterPort }}
            {{- end }}
            {{- if gt (int .Values.replicaCount) 1}}
            {{- $fullName := include "alertmanager.fullname" . }}
            {{- range $i := until (int .Values.replicaCount) }}
            - --cluster.peer={{ $fullName }}-{{ $i }}.{{ $fullName }}-headless:{{ $svcClusterPort }}
            {{- end }}
            {{- end }}
            {{- if .Values.additionalPeers }}
            {{- range $item := .Values.additionalPeers }}
            - --cluster.peer={{ $item }}
            {{- end }}
            {{- end }}
            {{- range $key, $value := .Values.extraArgs }}
            - --{{ $key }}={{ $value }}
            {{- end }}
          ports:
            - name: http
              containerPort: 9093
              protocol: TCP
          livenessProbe:
            {{- toYaml .Values.livenessProbe | nindent 12 }}
          readinessProbe:
            {{- toYaml .Values.readinessProbe | nindent 12 }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          volumeMounts:
            {{- if .Values.config }}
            - name: config
              mountPath: /etc/alertmanager
            {{- end }}
            {{- range .Values.extraSecretMounts }}
            - name: {{ .name }}
              mountPath: {{ .mountPath }}
              subPath: {{ .subPath }}
              readOnly: {{ .readOnly }}
            {{- end }}
            - name: storage
              mountPath: /alertmanager
      volumes:
        {{- if .Values.config }}
        - name: config
          configMap:
            name: {{ include "alertmanager.fullname" . }}
        {{- end }}
        {{- range .Values.extraSecretMounts }}
        - name: {{ .name }}
          secret:
            secretName: {{ .secretName }}
            {{- with .optional }}
            optional: {{ . }}
            {{- end }}
        {{- end }}
      {{- if .Values.persistence.enabled }}
  volumeClaimTemplates:
    - metadata:
        name: storage
      spec:
        accessModes:
          {{- toYaml .Values.persistence.accessModes | nindent 10 }}
        resources:
          requests:
            storage: {{ .Values.persistence.size }}
      {{- if .Values.persistence.storageClass }}
      {{- if (eq "-" .Values.persistence.storageClass) }}
        storageClassName: ""
      {{- else }}
        storageClassName: {{ .Values.persistence.storageClass }}
      {{- end }}
      {{- end }}
{{- else }}
        - name: storage
          emptyDir: {}
{{- end -}}
---
```

* Приемник - файл шаблона `service.yaml`
```yml

```
* Приемник - файл шаблона `values.yaml`
```yml
---

metadata:
  labels:
    app: fb-app



```





### 3. Деплой приложения
  * `helm lint first`
  * `helm install first first` 

### Технология создания версий приложения


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
```
controlplane $ helm install first
Error: INSTALLATION FAILED: must either provide a name or specify --generate-name
controlplane $ 
controlplane $ helm install first first
NAME: first
LAST DEPLOYED: Fri Jul 29 07:11:55 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=first,app.kubernetes.io/instance=first" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                             READY   STATUS    RESTARTS      AGE
alertmanager-0                                   0/1     Pending   0             37m
first-5f9fd64764-2gsgw                           1/1     Running   0             10s
nfs-server-nfs-server-provisioner-0              1/1     Running   0             37m
nginx-ingress-controller-9b5c967bf-5jzbd         0/1     Running   15 (5s ago)   37m
nginx-ingress-default-backend-85b4b4dd44-5wxm2   1/1     Running   0             37m
controlplane $ 
```
### Логи - 2

```
controlplane $ date
Sat Jul 30 07:23:10 UTC 2022

NAME                                             READY   STATUS    RESTARTS   AGE
alertmanager-0                                   0/1     Pending   0          2s
nfs-server-nfs-server-provisioner-0              1/1     Running   0          24s
nginx-ingress-controller-9b5c967bf-hxs2l         0/1     Pending   0          0s
nginx-ingress-default-backend-85b4b4dd44-dv7ps   0/1     Pending   0          0s
Sat Jul 30 07:04:21 UTC 2022
/root/My-Procect/stage/chart01/charts/nginx-ingress
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ helm create fb-pod
Creating fb-pod
controlplane $ 
controlplane $ mc

controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   `-- tests
`-- values.yaml

3 directories, 5 files
controlplane $ 
controlplane $ cat values.yaml 
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"

controlplane $ 
controlplane $ cat templates/deployment.yaml 
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: stage
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
controlplane $ 
```
```
controlplane $ date
Sat Jul 30 07:23:10 UTC 2022
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts/fb-pod
controlplane $ 
controlplane $ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
alertmanager    default         1               2022-07-30 07:04:19.044655091 +0000 UTC deployed        alertmanager-0.19.0             v0.23.0    
nfs-server      default         1               2022-07-30 07:03:56.095597041 +0000 UTC deployed        nfs-server-provisioner-1.1.3    2.3.0      
nginx-ingress   default         1               2022-07-30 07:04:20.772116071 +0000 UTC deployed        nginx-ingress-1.41.3            v0.34.1    
controlplane $ 
controlplane $ helm template fb-pod
Error: failed to download "fb-pod"
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod
Error: template: fb-pod/templates/NOTES.txt:2:14: executing "fb-pod/templates/NOTES.txt" at <.Values.ingress.enabled>: nil pointer evaluating interface {}.enabled

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ helm lint fb-pod 
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended
[ERROR] templates/: template: fb-pod/templates/NOTES.txt:2:14: executing "fb-pod/templates/NOTES.txt" at <.Values.ingress.enabled>: nil pointer evaluating interface {}.enabled

Error: 1 chart(s) linted, 1 chart(s) failed
controlplane $ 
controlplane $ 
controlplane $ helm lint fb-pod
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ tree
.
|-- alertmanager
|   |-- Chart.yaml
|   |-- README.md
|   |-- ci
|   |   `-- config-reload-values.yaml
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- _helpers.tpl
|   |   |-- configmap.yaml
|   |   |-- ingress.yaml
|   |   |-- pdb.yaml
|   |   |-- serviceaccount.yaml
|   |   |-- services.yaml
|   |   |-- statefulset.yaml
|   |   `-- tests
|   |       `-- test-connection.yaml
|   `-- values.yaml
|-- alertmanager-0.19.0.tgz
|-- fb-pod
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- _helpers.tpl
|   |   |-- deployment.yaml
|   |   `-- tests
|   `-- values.yaml
|-- nginx-ingress
|   |-- Chart.yaml
|   |-- OWNERS
|   |-- README.md
|   |-- ci
|   |   |-- daemonset-customconfig-values.yaml
|   |   |-- daemonset-customnodeport-values.yaml
|   |   |-- daemonset-headers-values.yaml
|   |   |-- daemonset-internal-lb-values.yaml
|   |   |-- daemonset-nodeport-values.yaml
|   |   |-- daemonset-tcp-udp-configMapNamespace-values.yaml
|   |   |-- daemonset-tcp-udp-values.yaml
|   |   |-- daemonset-tcp-values.yaml
|   |   |-- deamonset-default-values.yaml
|   |   |-- deamonset-metrics-values.yaml
|   |   |-- deamonset-psp-values.yaml
|   |   |-- deamonset-webhook-and-psp-values.yaml
|   |   |-- deamonset-webhook-values.yaml
|   |   |-- deployment-autoscaling-values.yaml
|   |   |-- deployment-customconfig-values.yaml
|   |   |-- deployment-customnodeport-values.yaml
|   |   |-- deployment-default-values.yaml
|   |   |-- deployment-headers-values.yaml
|   |   |-- deployment-internal-lb-values.yaml
|   |   |-- deployment-metrics-values.yaml
|   |   |-- deployment-nodeport-values.yaml
|   |   |-- deployment-psp-values.yaml
|   |   |-- deployment-tcp-udp-configMapNamespace-values.yaml
|   |   |-- deployment-tcp-udp-values.yaml
|   |   |-- deployment-tcp-values.yaml
|   |   |-- deployment-webhook-and-psp-values.yaml
|   |   `-- deployment-webhook-values.yaml
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- _helpers.tpl
|   |   |-- addheaders-configmap.yaml
|   |   |-- admission-webhooks
|   |   |   |-- job-patch
|   |   |   |   |-- clusterrole.yaml
|   |   |   |   |-- clusterrolebinding.yaml
|   |   |   |   |-- job-createSecret.yaml
|   |   |   |   |-- job-patchWebhook.yaml
|   |   |   |   |-- psp.yaml
|   |   |   |   |-- role.yaml
|   |   |   |   |-- rolebinding.yaml
|   |   |   |   `-- serviceaccount.yaml
|   |   |   `-- validating-webhook.yaml
|   |   |-- clusterrole.yaml
|   |   |-- clusterrolebinding.yaml
|   |   |-- controller-configmap.yaml
|   |   |-- controller-daemonset.yaml
|   |   |-- controller-deployment.yaml
|   |   |-- controller-hpa.yaml
|   |   |-- controller-metrics-service.yaml
|   |   |-- controller-poddisruptionbudget.yaml
|   |   |-- controller-prometheusrules.yaml
|   |   |-- controller-psp.yaml
|   |   |-- controller-role.yaml
|   |   |-- controller-rolebinding.yaml
|   |   |-- controller-service-internal.yaml
|   |   |-- controller-service.yaml
|   |   |-- controller-serviceaccount.yaml
|   |   |-- controller-servicemonitor.yaml
|   |   |-- controller-webhook-service.yaml
|   |   |-- default-backend-deployment.yaml
|   |   |-- default-backend-hpa.yaml
|   |   |-- default-backend-poddisruptionbudget.yaml
|   |   |-- default-backend-psp.yaml
|   |   |-- default-backend-role.yaml
|   |   |-- default-backend-rolebinding.yaml
|   |   |-- default-backend-service.yaml
|   |   |-- default-backend-serviceaccount.yaml
|   |   |-- proxyheaders-configmap.yaml
|   |   |-- tcp-configmap.yaml
|   |   `-- udp-configmap.yaml
|   `-- values.yaml
`-- nginx-ingress-1.41.3.tgz

13 directories, 91 files
controlplane $ 
controlplane $ cat   
^C
controlplane $ 
controlplane $ cat fb-pod/templates/NOTES.txt 
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ helm template fb-pod 
---
# Source: fb-pod/templates/deployment.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: stage
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
---
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: "zakharovnpa/k8s-frontend:05.07.22"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "zakharovnpa/k8s-backend:05.07.22"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod fb-pod
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:36:16 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                             READY   STATUS             RESTARTS       AGE
alertmanager-0                                   0/1     Pending            0              32m
nfs-server-nfs-server-provisioner-0              1/1     Running            0              32m
nginx-ingress-controller-9b5c967bf-hxs2l         0/1     CrashLoopBackOff   13 (64s ago)   32m
nginx-ingress-default-backend-85b4b4dd44-dv7ps   1/1     Running            0              32m
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-qtrww   0/2     ContainerCreating   0          28s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running   0          31s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running   0          33s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   `-- tests
`-- values.yaml

3 directories, 5 files
```
```
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Error: failed to download "fb-pod"
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts/fb-pod
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:47:17 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running             0          11m
fb-pod-6f45f8798b-82wht   0/2     ContainerCreating   0          14s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          20s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          23s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          25s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          27s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          28s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          30s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          32s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          34s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          36s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          38s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          40s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          42s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          43s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          46s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-82wht   2/2     Running   0          49s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:12.07.22controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:49:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-69fc56646b-ncqdp   2/2     Running       0          8s
fb-pod-6f45f8798b-82wht   2/2     Terminating   0          2m22s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-69fc56646b-ncqdp   2/2     Running   0          43s
controlplane $ 
controlplane $ cat fb-pod/values.yaml 
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "13.07.22"

controlplane $ 
controlplane $ date
Sat Jul 30 07:51:01 UTC 2022
controlplane $ 
controlplane $ 
```

![screen-helm-upgrade-fb-pod.png](/13-kubernetes-config-04-helm/Files/screen-helm-upgrade-fb-pod.png)
