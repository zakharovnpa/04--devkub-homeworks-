## Лог 10. Успешное ДЗ вопрос 2



```
Wed Aug 17 13:04:37 UTC 2022
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
LAST DEPLOYED: Wed Aug 17 13:04:39 2022
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
fb-pod-app1-6464948946-cnlzt   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           82s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-cnlzt   2/2     Running   0          82s

NAME                  TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.99.225.5   <none>        80:30080/TCP   82s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ cd fb-pod-app2
controlplane $ 
controlplane $ cat values.yaml 

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
controlplane $ cat Chart.yaml 

apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: 12.07.22

controlplane $ 
controlplane $ cat values.yaml 

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

controlplane $ vi values.yaml 
controlplane $ 
controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30081

controlplane $ 
controlplane $ 
controlpla
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 4 root root 4.0K Aug 17 13:28 .
drwxr-xr-x 5 root root 4.0K Aug 17 13:04 ..
-rw-r--r-- 1 root root  349 Aug 17 13:04 .helmignore
-rw-r--r-- 1 root root  130 Aug 17 13:26 Chart.yaml
drwxr-xr-x 2 root root 4.0K Aug 17 13:04 charts
drwxr-xr-x 2 root root 4.0K Aug 17 13:04 templates
-rw-r--r-- 1 root root  289 Aug 17 13:28 values.yaml
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app2
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app2
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
    nodePort: 30081
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
# Source: fb-pod-app1/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app2 | grep name:
  name: fb-pod-app1
  name: fb-pod-app1
          name: frontend
              name: my-volume
          name: backend
              name: my-volume
        - name: my-volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app2
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 

apiVersion: v2
name: fb-pod-app1-v2
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: 12.07.22

controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1-v2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30081

controlplane $ 
controlplane $ helm template fb-pod-app2 fb-pod-app2 | grep name:
  name: fb-pod-app1-v2
  name: fb-pod-app1-v2
          name: frontend
              name: my-volume
          name: backend
              name: my-volume
        - name: my-volume
controlplane $ 
controlplane $ 
controlplan
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2             
NAME: fb-pod-app2
LAST DEPLOYED: Wed Aug 17 13:39:03 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30081.
Application name=fb-pod-app1-v2.
Image tag: 12.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ cd fb-pod-app3
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 4 root root 4.0K Aug 17 13:45 .
drwxr-xr-x 5 root root 4.0K Aug 17 13:04 ..
-rw-r--r-- 1 root root  349 Aug 17 13:04 .helmignore
-rw-r--r-- 1 root root  130 Aug 17 13:44 Chart.yaml
drwxr-xr-x 2 root root 4.0K Aug 17 13:04 charts
drwxr-xr-x 2 root root 4.0K Aug 17 13:04 templates
-rw-r--r-- 1 root root  292 Aug 17 13:44 values.yaml
controlplane $ 
controlplane $ cat Chart.yaml 

apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.3.0
appVersion: 13.07.22

controlplane $ 
controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1-v3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22
nodePort: 30082

controlplane $ 
controlplane $ 
controlplane $ cat Chart.yaml 

apiVersion: v2
name: fb-pod-app1-v3
description: A Helm chart for Kubernetes
type: application
version: 0.3.0
appVersion: 13.07.22

controlplane $ 
controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1-v3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22
nodePort: 30082

controlplane $ 
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3   
Error: failed to download "fb-pod-app3"
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app3
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3
---
# Source: fb-pod-app1-v3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1-v3
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
# Source: fb-pod-app1-v3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1-v3
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
# Source: fb-pod-app1-v3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3 | grep name:
  name: fb-pod-app1-v3
  name: fb-pod-app1-v3
          name: frontend
              name: my-volume
          name: backend
              name: my-volume
        - name: my-volume
controlplane $ 
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3 | grep fb-pod
# Source: fb-pod-app1-v3/templates/service.yaml
  name: fb-pod-app1-v3
    app: fb-pod
# Source: fb-pod-app1-v3/templates/deployment.yaml
  name: fb-pod-app1-v3
# Source: fb-pod-app1-v3/templates/deployment.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app1-v3 fb-pod-app3
NAME: fb-pod-app1-v3
LAST DEPLOYED: Wed Aug 17 13:53:44 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app2 namespace. 
nodePort is port= 30082.
Application name=fb-pod-app1-v3.
Image tag: 13.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1      1/1     1            1           49m
deployment.apps/fb-pod-app1-v2   1/1     1            1           15m

NAME                                  READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-cnlzt      2/2     Running   0          49m
pod/fb-pod-app1-v2-6f45f8798b-z5kdr   2/2     Running   0          15m

NAME                     TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1      NodePort   10.99.225.5      <none>        80:30080/TCP   49m
service/fb-pod-app1-v2   NodePort   10.111.224.177   <none>        80:30081/TCP   15m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1-v3   1/1     1            1           38s

NAME                                  READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-v3-69fc56646b-jthng   2/2     Running   0          38s

NAME                     TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1-v3   NodePort   10.98.66.157   <none>        80:30082/TCP   38s
```
