## Лог 3. Задание 1: подготовить helm чарт для приложения. Вариант 2

```
Sat Jul 30 17:50:20 UTC 2022
/root/My-Project/stage
Creating fb-pod
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
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
  namespace: app1
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
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
NAME: fb-pod-app1
LAST DEPLOYED: Sat Jul 30 17:50:21 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-vbt5v   0/2     ContainerCreating   0          0s
kubectl -n app1 get po
controlplane $ date && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && helm repo add stable https://charts.helm.sh/stable && helm repo add prometheus-community https://prometheus-community.githcontrolplane $ controlplane $ kubectl -n app1 get poNAME                      READY   STATUS    RESTARTS   AGEfb-pod-6464948946-vbt5v   2/2     Running   0          56s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          96s
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ helm template fb-pod 
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
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
  namespace: app1
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
        - image: zakharovnpa/k8s-frontend:12.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:12.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ vi fb-pod/templates/service.yaml 
controlplane $ 
controlplane $ helm template fb-pod
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
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
  namespace: app1
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
        - image: zakharovnpa/k8s-frontend:12.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:12.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-2 fb-pod
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-2": current value is "fb-pod-app1"
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          5m45s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           6m59s
controlplane $ 
controlplane $ helm lint fb-pod-2 fb-pod
==> Linting fb-pod-2
Error unable to check Chart.yaml file in chart: stat fb-pod-2/Chart.yaml: no such file or directory

==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

Error: 2 chart(s) linted, 1 chart(s) failed
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm lint fb-pod fb-pod
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

2 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm lint fb-pod       
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          22m
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ helm template fb-pod
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
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
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
NAME: fb-pod-app2
LAST DEPLOYED: Sat Jul 30 18:15:33 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          25m
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-69fc56646b-sfbpj   0/2     ContainerCreating   0          18s
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-69fc56646b-5wrxl   2/2     Running                  0          6m13s
fb-pod-69fc56646b-sfbpj   0/2     ContainerStatusUnknown   2          7m14s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 logs fb-pod-69fc56646b-sfbpj 
Defaulted container "frontend" out of: frontend, backend
Error from server (BadRequest): container "frontend" in pod "fb-pod-69fc56646b-sfbpj" is terminated
controlplane $ 
controlplane $ kubectl -n app2 logs fb-pod-69fc56646b-5wrxl 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/30 18:16:36 [notice] 1#1: using the "epoll" event method
2022/07/30 18:16:36 [notice] 1#1: nginx/1.23.0
2022/07/30 18:16:36 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/30 18:16:36 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/30 18:16:36 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/30 18:16:36 [notice] 1#1: start worker processes
2022/07/30 18:16:36 [notice] 1#1: start worker process 29
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/Chart.yaml 
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.3.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.13"
controlplane $ 
controlplane $ cat fb-pod/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

controlplane $ 
controlplane $ cat fb-pod/templates/deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: {{ .Values.namespace }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}

controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/templates/service.yaml    

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: {{ .Values.namespace }}
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod

controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
controlplane $ 
```
