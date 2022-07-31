## Лог 6. Задание 1: подготовить helm чарт для приложения. Вариант 2

```
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
LAST DEPLOYED: Sun Jul 31 13:29:01 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ ls -l
total 8
drwxr-xr-x 4 root root 4096 Jul 31 13:29 fb-pod-app1
drwxr-xr-x 4 root root 4096 Jul 31 13:29 fb-pod-app2
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-pv.yaml
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-pvc.yaml
controlplane $ 
controlplane $ kubectl -n app1 get po,svc,deploy
NAME                               READY   STATUS              RESTARTS   AGE
pod/fb-pod-app1-6464948946-lljvq   0/2     ContainerCreating   0          25s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.107.178.87   <none>        80:30080/TCP   26s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   0/1     1            0           26s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl get po,svc,deploy
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          58s

NAME                                        TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
service/kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     83d
service/nfs-server-nfs-server-provisioner   ClusterIP   10.102.92.84   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   58s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd                
/root/My-Project/stage
controlplane $ 
controlplane $ ls fb-pod-app1
Chart.yaml  charts  templates  values.yaml
controlplane $ 
controlplane $ cat fb-pod-app1/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
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
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.0"
controlplane $ 
controlplane $ vi fb-pod-app1/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app1/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.05.22"
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.05.22"
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app1/values.yaml  

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
  tag: 05.07.22

controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

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
  tag: 05.07.22

controlplane $ 
controlplane $ vi fb-pod-app2/values.yaml 
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

controlplane $ 
controlplane $ cat fb-pod-app1/values.yaml 

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
  tag: 05.07.22

controlplane $ 
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
    nodePort: 30080
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
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2
NAME: fb-pod-app2
LAST DEPLOYED: Sun Jul 31 13:37:54 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS              RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   2/2     Running             0          9m10s
fb-pod-app2-6f45f8798b-fg4zq   0/2     ContainerCreating   0          17s
controlplane $ 
controlplane $ 
controlplane $ date
Sun Jul 31 13:40:40 UTC 2022
controlplane $ 
controlplane $ v itoge pomenyali versiyu Chart.yml i nomer porta servisa na 30081
v: command not found
controlplane $ 
controlplane $ zapuskaem versiyu 13.07.22 v namespace app2
zapuskaem: command not found
controlplane $ 
controlplane $ date
Sun Jul 31 13:42:24 UTC 2022
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: "13.05.22"
controlplane $ 
controlplane $ vi fb-pod-app2/values.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app2

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

controlplane $ 
controlplane $ sobiraem template for namespace app2 and image v-13.07.22
sobiraem: command not found
controlplane $ 
controlplane $ helm template fb-pod-app2
---
# Source: fb-pod-app2/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app2
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
# Source: fb-pod-app2/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app2
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
# Source: fb-pod-app2/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ zapuskaem install versii image v-13.07.22
zapuskaem: command not found
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ cp -r fb-pod-app2 fb-pod-app3
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
    nodePort: 30081
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
Error: INSTALLATION FAILED: Service "fb-pod-app3" is invalid: spec.ports[0].nodePort: Invalid value: 30081: provided port is already allocated
controlplane $ 
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
    nodePort: 30083
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
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   2/2     Running   0          21m
fb-pod-app2-6f45f8798b-fg4zq   0/2     Error     1          12m
fb-pod-app2-6f45f8798b-jvffr   2/2     Running   0          11m
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app3-69fc56646b-jbx4w   0/2     ContainerStatusUnknown   2          66s
fb-pod-app3-69fc56646b-n7bxv   2/2     Running                  0          10s
controlplane $ 
controlplane $ 
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
controlplane $ helm template --set nodePort=30088 fb-pod-app3
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
    nodePort: 30088
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
controlplane $ cat fb-pod-app3/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

nodePort: 30085
controlplane $ 
controlplane $ cat fb-pod-app3/templates/service.yaml 

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.name }}
  namespace: {{ .Values.namespace }}
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: {{ .Values.nodePort }}
  selector:
    app: fb-pod

controlplane $ 
controlplane $ 
controlplane $ vi fb-pod-app3/templates/NOTES.txt 
controlplane $ 
controlplane $ 
controlplane $ helm template --set nodePort=30089 fb-pod-app3
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
    nodePort: 30089
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
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS                   RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-jbx4w   0/2     ContainerStatusUnknown   2          27m
pod/fb-pod-app3-69fc56646b-n7bxv   2/2     Running                  0          26m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app3   1/1     1            1           27m
controlplane $ 
controlplane $ kubectl -n app2 delete pod fb-pod-app3-69fc56646b-jbx4w 
pod "fb-pod-app3-69fc56646b-jbx4w" deleted
controlplane $ 
controlplane $ kubectl -n app2 delete pod fb-pod-app3-69fc56646b-n7bxv 
pod "fb-pod-app3-69fc56646b-n7bxv" deleted
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-rvs95   2/2     Running   0          52s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app3   1/1     1            1           29m
controlplane $ 
controlplane $ kubectl -n app2 delete deployments.apps fb-pod-app3     
deployment.apps "fb-pod-app3" deleted
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          12s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          21s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          27s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          37s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
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
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
controlplane $ 
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
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
```
