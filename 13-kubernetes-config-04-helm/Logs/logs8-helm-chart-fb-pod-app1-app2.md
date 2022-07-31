## Лог 8. Задание 1, вопрос 2, часть 2. Успешная установка `fb-pod-app2` в окружение `app1`



```
Sun Jul 31 17:44:51 UTC 2022
/root/My-Project/stage
Creating fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
NAME: fb-pod-app1
LAST DEPLOYED: Sun Jul 31 17:44:52 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running   0          2m58s
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app3 get po
No resources found in app3 namespace.
controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30081

controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml  

apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: 12.07.22

controlplane $ 
controlplane $ ustanovka vtoroy versii application in namespace app1 ====
ustanovka: command not found
controlplane $ 
controlplane $ date
Sun Jul 31 17:50:42 UTC 2022
controlplane $ 
controlplane $ helm template fb-pod-app2
---
# Source: fb-pod-app2/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app2
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
# Source: fb-pod-app2/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app2
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
# Source: fb-pod-app2/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2
NAME: fb-pod-app2
LAST DEPLOYED: Sun Jul 31 17:52:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30081.
Application name=fb-pod-app2.
Image tag: 12.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          8m27s
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          61s
fb-pod-app2-6f45f8798b-xzc58   0/2     ContainerCreating        0          2s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          9m3s
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          97s
fb-pod-app2-6f45f8798b-xzc58   2/2     Running                  0          38s
controlplane $ 
controlplane $ 
controlplane $ 
```
```
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30082
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
NAME: fb-pod-app3
LAST DEPLOYED: Sun Jul 31 18:08:55 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app2 namespace. 
nodePort is port= 30082.
Application name=fb-pod-app3.
Image tag: 13.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                           READY   STATUS              RESTARTS   AGE
fb-pod-app3-69fc56646b-6nxg9   0/2     ContainerCreating   0          19s
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          24m
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          17m
fb-pod-app2-6f45f8798b-xzc58   2/2     Running                  0          16m
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app3-69fc56646b-6nxg9   2/2     Running   0          40s
controlplane $ 
controlplane $ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
fb-pod-app1     default         1               2022-07-31 17:44:52.183509842 +0000 UTC deployed        fb-pod-app1-0.1.0               1.16.0     
fb-pod-app2     default         1               2022-07-31 17:52:18.500453626 +0000 UTC deployed        fb-pod-app2-0.1.0               12.07.22   
fb-pod-app3     default         1               2022-07-31 18:08:55.846634505 +0000 UTC deployed        fb-pod-app3-0.1.0               13.07.22   
nfs-server      default         1               2022-07-31 17:44:28.959734952 +0000 UTC deployed        nfs-server-provisioner-1.1.3    2.3.0      
controlplane $ 
controlplane $ 

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
Error from server (NotFound): deployments.apps "fb-pod" not found
controlplane $ 
controlplane $ kubectl -n app1 get deploy
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   1/1     1            1           29m
fb-pod-app2   1/1     1            1           21m
controlplane $ 
controlplane $ kubectl -n app2 get deploy
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app3   1/1     1            1           5m15s
controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod-app1 -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod-app2 -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:12.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deploy fb-pod-app3 -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
controlplane $ 
controlplane $ 

controlplane $ kubectl -n app2 get po -o wide
NAME                           READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
fb-pod-app3-69fc56646b-6nxg9   0/2     Error     1          9m2s    192.168.0.7   controlplane   <none>           <none>
fb-pod-app3-69fc56646b-h7pcz   2/2     Running   0          7m48s   192.168.1.7   node01         <none>           <none>
controlplane $ 
controlplane $ kubectl -n app1 get po -o wide
NAME                           READY   STATUS                   RESTARTS   AGE   IP            NODE           NOMINATED NODE   READINESS GATES
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          33m   192.168.1.5   node01         <none>           <none>
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          26m   192.168.0.6   controlplane   <none>           <none>
fb-pod-app2-6f45f8798b-xzc58   2/2     Running                  0          25m   192.168.1.6   node01         <none>           <none>
controlplane $ 
controlplane $ 
```
* Попытка установить приложение с тем же именем в тот же неймспейс, но с другой версей образа приложения
```
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod-app3/values.yaml 
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30085
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
```
* неуспешная попытка запустить приложение в другом окружении. 
> Вывод: с одним и тем же именем установить приложение в один кластер в разные окружения не удается.
> Можно установить любые версии образа приложения даже в одно окружение, но под различными именами.

```
controlplane $ 
controlplane $ vi fb-pod-app3/values.yaml 
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml  
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app1
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30085
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app3/Chart.yaml 

apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.3
appVersion: 12.07.22

controlplane $ 
controlplane $ cat fb-pod-app3/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app3

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30085

controlplane $ 
controlplane $ 
```
```
controlplane $ 
controlplane $ helm delete fb-pod-app3 fb-pod-app3
release "fb-pod-app3" uninstalled
Error: uninstall: Release not loaded: fb-pod-app3: release: not found
controlplane $ 
controlplane $ helm delete fb-pod-app2 fb-pod-app2
release "fb-pod-app2" uninstalled
Error: uninstall: Release not loaded: fb-pod-app2: release: not found
controlplane $ 
controlplane $ helm delete fb-pod-app1 fb-pod-app1
release "fb-pod-app1" uninstalled
Error: uninstall: Release not loaded: fb-pod-app1: release: not found
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS        RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Terminating   0          57m
fb-pod-app2-6f45f8798b-xzc58   2/2     Terminating   0          48m
controlplane $ 
controlplane $ kubectl -n app1 get deploy
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n app2 get deploy
No resources found in app2 namespace.
```
