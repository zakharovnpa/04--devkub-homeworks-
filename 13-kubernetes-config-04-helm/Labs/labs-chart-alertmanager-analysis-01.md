## ЛР-3. Чарт Alertmanager. Разбор файлов конфигураций

### 1. Подготовка рабочего пространства
* Устанавливаем Helm
* Добавляем репозиторий чартов stable
* Добавляем репозиторий чартов prometheus-community
* Устанавливаем nfs-server
* Устанавливаем mc
* Создаем namespace stage
* Создаем директорию проекта My-Procect/stage с пустыми файлами
* Создаем чарт My-chart
* Включаем автодополнение для Helm
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
kubectl get po && \
date

```


### Logs
* Tab 1

```
namespace/stage created
Creating My-chart
total 12K
drwxr-xr-x 3 root root 4.0K Jul 29 02:56 .
drwxr-xr-x 3 root root 4.0K Jul 29 02:56 ..
drwxr-xr-x 4 root root 4.0K Jul 29 02:56 My-chart
-rw-r--r-- 1 root root    0 Jul 29 02:56 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Jul 29 02:56 stage-pv.yaml
-rw-r--r-- 1 root root    0 Jul 29 02:56 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm search repo alertmanager
NAME            CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/karma    1.7.2           v0.72           DEPRECATED - A Helm chart for Karma - an UI for...
controlplane $ 
controlplane $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
"prometheus-community" has been added to your repositories
controlplane $ 
controlplane $ helm repo list
NAME                    URL                                               
stable                  https://charts.helm.sh/stable                     
prometheus-community    https://prometheus-community.github.io/helm-charts
controlplane $ 
controlplane $ helm repo udate

This command consists of multiple subcommands to interact with chart repositories.

It can be used to add, remove, list, and index chart repositories.

Usage:
  helm repo [command]

Available Commands:
  add         add a chart repository
  index       generate an index file given a directory containing packaged charts
  list        list chart repositories
  remove      remove one or more chart repositories
  update      update information of available charts locally from chart repositories

Flags:
  -h, --help   help for repo

Global Flags:
      --debug                       enable verbose output
      --kube-apiserver string       the address and the port for the Kubernetes API server
      --kube-as-group stringArray   group to impersonate for the operation, this flag can be repeated to specify multiple groups.
      --kube-as-user string         username to impersonate for the operation
      --kube-ca-file string         the certificate authority file for the Kubernetes API server connection
      --kube-context string         name of the kubeconfig context to use
      --kube-token string           bearer token used for authentication
      --kubeconfig string           path to the kubeconfig file
  -n, --namespace string            namespace scope for this request
      --registry-config string      path to the registry config file (default "/root/.config/helm/registry/config.json")
      --repository-cache string     path to the file containing cached repository indexes (default "/root/.cache/helm/repository")
      --repository-config string    path to the file containing repository names and URLs (default "/root/.config/helm/repositories.yaml")

Use "helm repo [command] --help" for more information about a command.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
controlplane $ 
controlplane $ helm search repo alertmanager
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION                                       
prometheus-community/alertmanager       0.19.0          v0.23.0         The Alertmanager handles alerts sent by client ...
stable/karma                            1.7.2           v0.72           DEPRECATED - A Helm chart for Karma - an UI for...
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage
controlplane $ 
controlplane $ cd My-chart/charts/
controlplane $ 
controlplane $ ls
controlplane $ 
controlplane $ 
controlplane $ helm pull prometheus-community/alertmanager
controlplane $ 
controlplane $ ls
alertmanager-0.19.0.tgz
controlplane $ 
controlplane $ tar -zxvf alertmanager-0.19.0.tgz 
alertmanager/Chart.yaml
alertmanager/values.yaml
alertmanager/templates/NOTES.txt
alertmanager/templates/_helpers.tpl
alertmanager/templates/configmap.yaml
alertmanager/templates/ingress.yaml
alertmanager/templates/pdb.yaml
alertmanager/templates/serviceaccount.yaml
alertmanager/templates/services.yaml
alertmanager/templates/statefulset.yaml
alertmanager/templates/tests/test-connection.yaml
alertmanager/.helmignore
alertmanager/README.md
alertmanager/ci/config-reload-values.yaml
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 3 root root 4.0K Jul 29 03:05 .
drwxr-xr-x 4 root root 4.0K Jul 29 02:56 ..
drwxr-xr-x 4 root root 4.0K Jul 29 03:05 alertmanager
-rw-r--r-- 1 root root 6.4K Jul 29 03:04 alertmanager-0.19.0.tgz
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cd alertmanager/
controlplane $ 
controlplane $ ls -lha
total 36K
drwxr-xr-x 4 root root 4.0K Jul 29 03:05 .
drwxr-xr-x 3 root root 4.0K Jul 29 03:05 ..
-rw-r--r-- 1 root root  361 Jul 20 22:11 .helmignore
-rw-r--r-- 1 root root  502 Jul 20 22:11 Chart.yaml
-rw-r--r-- 1 root root 1.9K Jul 20 22:11 README.md
drwxr-xr-x 2 root root 4.0K Jul 29 03:05 ci
drwxr-xr-x 3 root root 4.0K Jul 29 03:05 templates
-rw-r--r-- 1 root root 4.5K Jul 20 22:11 values.yaml
controlplane $ 
controlplane $ tree

Command 'tree' not found, but can be installed with:

apt install tree

controlplane $ 
controlplane $ apt install tree
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  tree
0 upgraded, 1 newly installed, 0 to remove and 195 not upgraded.
Need to get 43.0 kB of archives.
After this operation, 115 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 tree amd64 1.8.0-1 [43.0 kB]
Fetched 43.0 kB in 0s (354 kB/s)
Selecting previously unselected package tree.
(Reading database ... 72625 files and directories currently installed.)
Preparing to unpack .../tree_1.8.0-1_amd64.deb ...
Unpacking tree (1.8.0-1) ...
Setting up tree (1.8.0-1) ...
Processing triggers for man-db (2.9.1-1) ...
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- README.md
|-- ci
|   `-- config-reload-values.yaml
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- configmap.yaml
|   |-- ingress.yaml
|   |-- pdb.yaml
|   |-- serviceaccount.yaml
|   |-- services.yaml
|   |-- statefulset.yaml
|   `-- tests
|       `-- test-connection.yaml
`-- values.yaml

3 directories, 13 files
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat config-reload-values.yaml
cat: config-reload-values.yaml: No such file or directory
controlplane $ 
controlplane $ cat NOTES.txt
cat: NOTES.txt: No such file or directory
controlplane $ 
```
```
controlplane $ cat Chart.yaml
```

#### Chart.yaml
```
apiVersion: v2
appVersion: v0.23.0
description: The Alertmanager handles alerts sent by client applications such as the
  Prometheus server.
home: https://prometheus.io/
icon: https://raw.githubusercontent.com/prometheus/prometheus.github.io/master/assets/prometheus_logo-cb55bb5c346.png
maintainers:
- email: monotek23@gmail.com
  name: monotek
- email: naseem@transit.app
  name: naseemkullah
name: alertmanager
sources:
- https://github.com/prometheus/alertmanager
type: application
version: 0.19.0
controlplane $ 
controlplane $ cat README.md
# Alertmanager

As per [prometheus.io documentation](https://prometheus.io/docs/alerting/latest/alertmanager/):
> The Alertmanager handles alerts sent by client applications such as the
> Prometheus server. It takes care of deduplicating, grouping, and routing them
> to the correct receiver integration such as email, PagerDuty, or OpsGenie. It
> also takes care of silencing and inhibition of alerts.

## Prerequisites

Kubernetes 1.14+

## Get Repo Info

```console
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```
```
_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

```console
# Helm 3
$ helm install [RELEASE_NAME] prometheus-community/alertmanager

# Helm 2
$ helm install --name [RELEASE_NAME] prometheus-community/alertmanager
```
```
_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
# Helm 3
$ helm uninstall [RELEASE_NAME]

# Helm 2
# helm delete --purge [RELEASE_NAME]
```
```
This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
# Helm 3 or 2
$ helm upgrade [RELEASE_NAME] [CHART] --install
```
```
_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
# Helm 2
$ helm inspect values prometheus-community/alertmanager

# Helm 3
$ helm show values prometheus-community/alertmanager
```

```
controlplane $ cat values.yaml
```
#### values.yaml
```
# Default values for alertmanager.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: quay.io/prometheus/alertmanager
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: ""

extraArgs: {}

## Additional Alertmanager Secret mounts
# Defines additional mounts with secrets. Secrets must be manually created in the namespace.
extraSecretMounts: []
  # - name: secret-files
  #   mountPath: /etc/secrets
  #   subPath: ""
  #   secretName: alertmanager-secret-files
  #   readOnly: true

imagePullSecrets: []
nameOverride: ""
fullnameOverride: ""

serviceAccount:
  # Specifies whether a service account should be created
  create: true
  # Annotations to add to the service account
  annotations: {}
  # The name of the service account to use.
  # If not set and create is true, a name is generated using the fullname template
  name:

podSecurityContext:
  fsGroup: 65534
dnsConfig: {}
  # nameservers:
  #   - 1.2.3.4
  # searches:
  #   - ns1.svc.cluster-domain.example
  #   - my.dns.search.suffix
  # options:
  #   - name: ndots
  #     value: "2"
  #   - name: edns0
securityContext:
  # capabilities:
  #   drop:
  #   - ALL
  # readOnlyRootFilesystem: true
  runAsUser: 65534
  runAsNonRoot: true
  runAsGroup: 65534

additionalPeers: []

livenessProbe:
  httpGet:
    path: /
    port: http

readinessProbe:
  httpGet:
    path: /
    port: http

service:
  annotations: {}
  type: ClusterIP
  port: 9093
  clusterPort: 9094
  # if you want to force a specific nodePort. Must be use with service.type=NodePort
  # nodePort:

ingress:
  enabled: false
  className: ""
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: alertmanager.domain.com
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: []
  #  - secretName: chart-example-tls
  #    hosts:
  #      - alertmanager.domain.com

resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 10m
  #   memory: 32Mi

nodeSelector: {}

tolerations: []

affinity: {}

## Topology spread constraints rely on node labels to identify the topology domain(s) that each Node is in.
## Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
topologySpreadConstraints: []
  # - maxSkew: 1
  #   topologyKey: failure-domain.beta.kubernetes.io/zone
  #   whenUnsatisfiable: DoNotSchedule
  #   labelSelector:
  #     matchLabels:
  #       app.kubernetes.io/instance: alertmanager

statefulSet:
  annotations: {}

podAnnotations: {}
podLabels: {}

# Ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb/
podDisruptionBudget: {}
  # maxUnavailable: 1
  # minAvailable: 1

command: []

persistence:
  enabled: true
  ## Persistent Volume Storage Class
  ## If defined, storageClassName: <storageClass>
  ## If set to "-", storageClassName: "", which disables dynamic provisioning
  ## If undefined (the default) or set to null, no storageClassName spec is
  ## set, choosing the default provisioner.
  ##
  # storageClass: "-"
  accessModes:
    - ReadWriteOnce
  size: 50Mi

config:
  global: {}
    # slack_api_url: ''

  templates:
    - '/etc/alertmanager/*.tmpl'

  receivers:
    - name: default-receiver
      # slack_configs:
      #  - channel: '@you'
      #    send_resolved: true

  route:
    group_wait: 10s
    group_interval: 5m
    receiver: default-receiver
    repeat_interval: 3h

## Monitors ConfigMap changes and POSTs to a URL
## Ref: https://github.com/jimmidyson/configmap-reload
##
configmapReload:
  ## If false, the configmap-reload container will not be deployed
  ##
  enabled: false

  ## configmap-reload container name
  ##
  name: configmap-reload

  ## configmap-reload container image
  ##
  image:
    repository: jimmidyson/configmap-reload
    tag: v0.5.0
    pullPolicy: IfNotPresent

  # containerPort: 9533

  ## configmap-reload resource requests and limits
  ## Ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ##
  resources: {}

templates: {}
#   alertmanager.tmpl: |-
```

```
controlplane $ 
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- README.md
|-- ci
|   `-- config-reload-values.yaml
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- configmap.yaml
|   |-- ingress.yaml
|   |-- pdb.yaml
|   |-- serviceaccount.yaml
|   |-- services.yaml
|   |-- statefulset.yaml
|   `-- tests
|       `-- test-connection.yaml
`-- values.yaml

3 directories, 13 files
controlplane $ 
controlplane $ cd templates/
controlplane $ 
controlplane $ tree
.
|-- NOTES.txt
|-- _helpers.tpl
|-- configmap.yaml
|-- ingress.yaml
|-- pdb.yaml
|-- serviceaccount.yaml
|-- services.yaml
|-- statefulset.yaml
`-- tests
    `-- test-connection.yaml

1 directory, 9 files
controlplane $ 
```

```
controlplane $ cat NOTES.txt
```
#### NOTES.txt
```
1. Get the application URL by running these commands:
{{- if .Values.ingress.enabled }}
{{- range $host := .Values.ingress.hosts }}
  {{- range .paths }}
  http{{ if $.Values.ingress.tls }}s{{ end }}://{{ $host.host }}{{ .path }}
  {{- end }}
{{- end }}
{{- else if contains "NodePort" .Values.service.type }}
  export NODE_PORT=$(kubectl get --namespace {{ .Release.Namespace }} -o jsonpath="{.spec.ports[0].nodePort}" services {{ include "alertmanager.fullname" . }})
  export NODE_IP=$(kubectl get nodes --namespace {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
{{- else if contains "LoadBalancer" .Values.service.type }}
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace {{ .Release.Namespace }} svc -w {{ include "alertmanager.fullname" . }}'
  export SERVICE_IP=$(kubectl get svc --namespace {{ .Release.Namespace }} {{ include "alertmanager.fullname" . }} --template "{{"{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}"}}")
  echo http://$SERVICE_IP:{{ .Values.service.port }}
{{- else if contains "ClusterIP" .Values.service.type }}
  export POD_NAME=$(kubectl get pods --namespace {{ .Release.Namespace }} -l "app.kubernetes.io/name={{ include "alertmanager.name" . }},app.kubernetes.io/instance={{ .Release.Name }}" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:{{ .Values.service.port }} to use your application"
  kubectl --namespace {{ .Release.Namespace }} port-forward $POD_NAME {{ .Values.service.port }}:80
{{- end }}
```

```
controlplane $ cat _helpers.tpl
```
####  _helpers.tpl
```
{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "alertmanager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alertmanager.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alertmanager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "alertmanager.labels" -}}
helm.sh/chart: {{ include "alertmanager.chart" . }}
{{ include "alertmanager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "alertmanager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertmanager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "alertmanager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "alertmanager.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
controlplane $ 
controlplane $ 
controlplane $ cat configmap.yaml
{{- if .Values.config }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "alertmanager.fullname" . }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
data:
  alertmanager.yml: |
    {{- toYaml .Values.config | default "{}" | nindent 4 }}
  {{- range $key, $value := .Values.templates }}
  {{ $key }}: |-
    {{- $value | nindent 4 }}
  {{- end }}
{{- end }}
```
```
controlplane $ cat ingress.yaml
```
#### ingress.yaml
```yml
{{- if .Values.ingress.enabled -}}
{{- $fullName := include "alertmanager.fullname" . -}}
{{- $svcPort := .Values.service.port -}}
{{- if and .Values.ingress.className (not (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion)) }}
  {{- if not (hasKey .Values.ingress.annotations "kubernetes.io/ingress.class") }}
  {{- $_ := set .Values.ingress.annotations "kubernetes.io/ingress.class" .Values.ingress.className}}
  {{- end }}
{{- end }}
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1beta1
{{- else -}}
apiVersion: extensions/v1beta1
{{- end }}
kind: Ingress
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if and .Values.ingress.className (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion) }}
  ingressClassName: {{ .Values.ingress.className }}
  {{- end }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            {{- if and .pathType (semverCompare ">=1.18-0" $.Capabilities.KubeVersion.GitVersion) }}
            pathType: {{ .pathType }}
            {{- end }}
            backend:
              {{- if semverCompare ">=1.19-0" $.Capabilities.KubeVersion.GitVersion }}
              service:
                name: {{ $fullName }}
                port:
                  number: {{ $svcPort }}
              {{- else }}
              serviceName: {{ $fullName }}
              servicePort: {{ $svcPort }}
              {{- end }}
          {{- end }}
    {{- end }}
{{- end }}
controlplane $ 
controlplane $ 
controlplane $ cat pdb.yaml
{{- if .Values.podDisruptionBudget -}}
{{ if $.Capabilities.APIVersions.Has "policy/v1/PodDisruptionBudget" -}}
apiVersion: policy/v1
{{- else -}}
apiVersion: policy/v1beta1
{{- end }}
kind: PodDisruptionBudget
metadata:
  name: {{ template "alertmanager.fullname" . }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
spec:
  selector:
    matchLabels:
      {{- include "alertmanager.selectorLabels" . | nindent 6 }}
{{ toYaml .Values.podDisruptionBudget | indent 2 }}
{{- end -}}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat serviceaccount.yaml
{{- if .Values.serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "alertmanager.serviceAccountName" . }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat services.yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "alertmanager.fullname" . }}
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
{{- if .Values.service.annotations }}
  annotations:
    {{- toYaml .Values.service.annotations | nindent 4 }}
{{- end }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
      {{- if (and (eq .Values.service.type "NodePort") .Values.service.nodePort) }}
      nodePort: {{ .Values.service.nodePort }}
      {{- end }}
  selector:
    {{- include "alertmanager.selectorLabels" . | nindent 4 }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "alertmanager.fullname" . }}-headless
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
spec:
  clusterIP: None
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
    {{- if or (gt (int .Values.replicaCount) 1) (.Values.additionalPeers) }}
    - port: {{ .Values.service.clusterPort }}
      targetPort: {{ .Values.service.clusterPort }}
      protocol: TCP
      name: cluster-tcp
    - port: {{ .Values.service.clusterPort }}
      targetPort: {{ .Values.service.clusterPort }}
      protocol: UDP
      name: cluster-udp
    {{- end }}
  selector:
    {{- include "alertmanager.selectorLabels" . | nindent 4 }}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat statefulset.yaml
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
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat 
^C
controlplane $ 
controlplane $ cd tests/
controlplane $ 
controlplane $ cat test-connection.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "alertmanager.fullname" . }}-test-connection"
  labels:
    {{- include "alertmanager.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test-success
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "alertmanager.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
controlplane $ 
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ cd ci
bash: cd: ci: No such file or directory
controlplane $ 
controlplane $ ls
NOTES.txt  _helpers.tpl  configmap.yaml  ingress.yaml  pdb.yaml  serviceaccount.yaml  services.yaml  statefulset.yaml  tests
controlplane $ cd ..
controlplane $ 
controlplane $ cd ci
controlplane $ 
controlplane $ cat config-reload-values.yaml 
configmapReload:
  enabled: true
controlplane $ 
controlplane $ 

```
* Tab 2

```
controlplane $ date
Fri Jul 29 03:42:51 UTC 2022
controlplane $ 
controlplane $ pwd
/root
controlplane $ 
controlplane $ cd My-Procect/stage/My-chart/charts/alertmanager/
controlplane $ 
controlplane $ pwd 
/root/My-Procect/stage/My-chart/charts/alertmanager
controlplane $ 
controlplane $ helm lint
==> Linting .

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm repo list
NAME                    URL                                               
stable                  https://charts.helm.sh/stable                     
prometheus-community    https://prometheus-community.github.io/helm-charts
controlplane $ 
controlplane $ helm search repo alertmanager
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION                                       
prometheus-community/alertmanager       0.19.0          v0.23.0         The Alertmanager handles alerts sent by client ...
stable/karma                            1.7.2           v0.72           DEPRECATED - A Helm chart for Karma - an UI for...
controlplane $ 
controlplane $ 
controlplane $ helm install alertmanager-0.23 prometheus-community/alertmanager
Error: INSTALLATION FAILED: Service "alertmanager-0.23-headless" is invalid: metadata.name: Invalid value: "alertmanager-0.23-headless": a DNS-1035 label must consist of lower case alphanumeric characters or '-', start with an alphabetic character, and end with an alphanumeric character (e.g. 'my-name',  or 'abc-123', regex used for validation is '[a-z]([-a-z0-9]*[a-z0-9])?')
controlplane $ 
controlplane $ helm install alertmanager prometheus-community/alertmanager
NAME: alertmanager
LAST DEPLOYED: Fri Jul 29 03:46:36 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:9093 to use your application"
  kubectl --namespace default port-forward $POD_NAME 9093:80
controlplane $ 
controlplane $ 
controlplane $ curl 127.1:9093
curl: (7) Failed to connect to 127.1 port 9093: Connection refused
controlplane $ 
controlplane $ curl http://127.0.0.1:9093
curl: (7) Failed to connect to 127.0.0.1 port 9093: Connection refused
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
alertmanager-0                        0/1     Pending   0          2m22s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          53m
controlplane $ 
controlplane $ helm uninstall alertmanager prometheus-community/alertmanager
release "alertmanager" uninstalled
Error: uninstall: Release name is invalid: prometheus-community/alertmanager
controlplane $ 
controlplane $ 
controlplane $ helm uninstall alertmanager-0 prometheus-community/alertmanager
Error: uninstall: Release not loaded: alertmanager-0: release: not found
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          54m
controlplane $ 
controlplane $ 
controlplane $ helm install alertmanager prometheus-community/alertmanager
NAME: alertmanager
LAST DEPLOYED: Fri Jul 29 03:50:32 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:9093 to use your application"
  kubectl --namespace default port-forward $POD_NAME 9093:80
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
alertmanager-0                        0/1     Pending   0          9s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          54m
controlplane $ 
controlplane $ helm uninstall alertmanager-0 prometheus-community/alertmanager
Error: uninstall: Release not loaded: alertmanager-0: release: not found
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
alertmanager-0                        0/1     Pending   0          28s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          55m
controlplane $ 
controlplane $ 
controlplane $ 
```
