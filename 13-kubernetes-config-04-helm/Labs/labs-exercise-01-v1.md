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
