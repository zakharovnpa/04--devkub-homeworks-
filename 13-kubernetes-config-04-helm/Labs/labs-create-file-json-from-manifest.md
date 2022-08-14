## ЛР-4. Создание файлов в формате json из готовых манфестов чарта Helm.
### Логи
```
Sun Aug 14 11:01:44 UTC 2022
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
LAST DEPLOYED: Sun Aug 14 11:01:44 2022
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
fb-pod-app1-6464948946-j5mh6   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 .
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 ..
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app1
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app2
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-pvc.yaml
controlplane $ 
controlplane $ mc

controlplane $ jsonnet --version
Jsonnet commandline interpreter v0.15.0
controlplane $ whereis jsonnet
jsonnet: /usr/bin/jsonnet
controlplane $ 
controlplane $ yaml2jsonnet stage-front-back.yaml | jsonnetfmt - -o stage-front-back.jsonnet
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ cat stage-front-back.yaml 
controlplane $ 
controlplane $ cd fb-pod-app1
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 .
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  349 Aug 14 11:01 .helmignore
-rw-r--r-- 1 root root 1.2K Aug 14 11:01 Chart.yaml
drwxr-xr-x 2 root root 4.0K Aug 14 11:01 charts
drwxr-xr-x 2 root root 4.0K Aug 14 11:01 templates
-rw-r--r-- 1 root root  289 Aug 14 11:01 values.yaml
controlplane $ cd templates/
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 14 11:01 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root  998 Aug 14 11:01 deployment.yaml
-rw-r--r-- 1 root root  258 Aug 14 11:01 service.yaml
controlplane $ 
controlplane $ yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 357, in _mapping_key
    raise UnhandledEventError(self, event)
yaml2jsonnet.jsonnet_renderer.UnhandledEventError: Event was not handled by the current state: Last event was MappingStartEvent(anchor=None, tag=None, implicit=True, flow_style=True), the state was _mapping_key, the queue was [(StreamStartEvent,_start), (DocumentStartEvent,_stream), (MappingStartEvent,_document), (MappingStartEvent,_mapping_key), (MappingStartEvent,_mapping_key)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ cat deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }}
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
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 357, in _mapping_key
    raise UnhandledEventError(self, event)
yaml2jsonnet.jsonnet_renderer.UnhandledEventError: Event was not handled by the current state: Last event was MappingStartEvent(anchor=None, tag=None, implicit=True, flow_style=True), the state was _mapping_key, the queue was [(StreamStartEvent,_start), (DocumentStartEvent,_stream), (MappingStartEvent,_document), (MappingStartEvent,_mapping_key), (MappingStartEvent,_mapping_key)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ cp deployment.yaml dep.yaml
controlplane $ 
controlplane $ vi dep.yaml 
controlplane $ 
controlplane $ yaml2jsonnet dep.yaml | jsonnetfmt - -o dep.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 210, in render
    self.state.send(event)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 357, in _mapping_key
    raise UnhandledEventError(self, event)
yaml2jsonnet.jsonnet_renderer.UnhandledEventError: Event was not handled by the current state: Last event was MappingStartEvent(anchor=None, tag=None, implicit=True, flow_style=True), the state was _mapping_key, the queue was [(StreamStartEvent,_start), (DocumentStartEvent,_stream), (MappingStartEvent,_document), (MappingStartEvent,_mapping_key), (MappingStartEvent,_mapping_key)]
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ 
controlplane $ vi dep.yaml 
controlplane $ 
controlplane $ vi dep.yaml 
controlplane $ 
controlplane $ yaml2jsonnet dep.yaml | jsonnetfmt - -o dep.jsonnet
controlplane $ 
controlplane $ cat dep.jsonnet 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '\\{{ .Values.name }}',
    namespace: '\\{{ .Values.namespace }}',
  },
  spec: {
    replicas: '\\{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '\\{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: '\\{}',  //
          },
        ],
      },
    },
  },
}
controlplane $ 
controlplane $ 
controlplane $ cp dep.yaml 2-dep.yaml
controlplane $ 
controlplane $ vi 2-dep.yaml 
controlplane $ 
controlplane $ yaml2jsonnet 2-dep.yaml | jsonnetfmt - -o 2-dep.jsonnet
controlplane $ 
controlplane $ cat 2-dep.jsonnet 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
  },
  spec: {
    replicas: '{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: '{}',  //
          },
        ],
      },
    },
  },
}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 36K
drwxr-xr-x 2 root root 4.0K Aug 14 11:30 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root 1.1K Aug 14 11:30 2-dep.jsonnet
-rw-r--r-- 1 root root  700 Aug 14 11:30 2-dep.yaml
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.1K Aug 14 11:26 dep.jsonnet
-rw-r--r-- 1 root root  695 Aug 14 11:26 dep.yaml
-rw-r--r-- 1 root root  946 Aug 14 11:13 deployment.yaml
-rw-r--r-- 1 root root  258 Aug 14 11:01 service.yaml
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ 
controlplane $ cat deployment.yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }}
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
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ vi service.yaml 
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
controlplane $ 
controlplane $ yaml2jsonnet service.yaml | jsonnetfmt - -o service.jsonnet
controlplane $ 
controlplane $ ls -lha
total 44K
drwxr-xr-x 2 root root 4.0K Aug 14 11:37 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root 1.1K Aug 14 11:30 2-dep.jsonnet
-rw-r--r-- 1 root root  700 Aug 14 11:30 2-dep.yaml
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.1K Aug 14 11:26 dep.jsonnet
-rw-r--r-- 1 root root  695 Aug 14 11:26 dep.yaml
-rw-r--r-- 1 root root 1.4K Aug 14 11:37 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 14 11:35 deployment.yaml
-rw-r--r-- 1 root root  378 Aug 14 11:37 service.jsonnet
-rw-r--r-- 1 root root  264 Aug 14 11:36 service.yaml
controlplane $ rm 2-dep.jsonnet 2-dep.yaml dep.yaml dep.jsonnet deployment.yaml service.yaml 
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 14 11:38 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.4K Aug 14 11:37 deployment.jsonnet
-rw-r--r-- 1 root root  378 Aug 14 11:37 service.jsonnet
controlplane $ 
controlplane $ mv deployment.jsonnet deployment.yaml    
controlplane $ 
controlplane $ mv service.jsonnet service.yaml    
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 14 11:39 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.4K Aug 14 11:37 deployment.yaml
-rw-r--r-- 1 root root  378 Aug 14 11:37 service.yaml
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 .
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  349 Aug 14 11:01 .helmignore
-rw-r--r-- 1 root root 1.2K Aug 14 11:01 Chart.yaml
drwxr-xr-x 2 root root 4.0K Aug 14 11:01 charts
drwxr-xr-x 2 root root 4.0K Aug 14 11:39 templates
-rw-r--r-- 1 root root  289 Aug 14 11:01 values.yaml
controlplane $ cd ..
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 .
drwxr-xr-x 5 root root 4.0K Aug 14 11:01 ..
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app1
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app2
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 14 11:01 stage-pvc.yaml
controlplane $ 
controlplane $ helm template fb-pod-app fb-pod-app1
Error: YAML parse error on fb-pod-app1/templates/service.yaml: error converting YAML to JSON: yaml: line 2: did not find expected ',' or '}'

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ cat fb-pod-app1/templates/deployment.yaml 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
  },
  spec: {
    replicas: '{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: '{}',  //
          },
        ],
      },
    },
  },
}
controlplane $ vi fb-pod-app1/templates/deployment.yaml 
controlplane $ 
controlplane $ vi fb-pod-app1/templates/service.yaml    
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1
Error: YAML parse error on fb-pod-app1/templates/service.yaml: error converting YAML to JSON: yaml: line 2: did not find expected ',' or '}'

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ helm template fb-app fb-pod-app1
Error: YAML parse error on fb-pod-app1/templates/service.yaml: error converting YAML to JSON: yaml: line 2: did not find expected ',' or '}'

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ mv service.yaml service.jsonnet
mv: cannot stat 'service.yaml': No such file or directory
controlplane $ 
controlplane $ cd fb-pod-app1/templates/
controlplane $ 
controlplane $ mv service.yaml service.jsonnet
controlplane $ 
controlplane $ mv deployment.yaml deployment.jsonnet
controlplane $ 
controlplane $ jsonnet deployment.jsonnet deployment.yaml    
ERROR: only one filename is allowed

controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 14 11:48 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.4K Aug 14 11:41 deployment.jsonnet
-rw-r--r-- 1 root root  382 Aug 14 11:42 service.jsonnet
controlplane $ jsonnet deployment.jsonnet > deployment.yaml
RUNTIME ERROR: unary operator - does not operate on type object
        deployment.jsonnet:(1:3)-(64:2)
controlplane $ 
controlplane $ vi deployment.jsonnet 
controlplane $ 
controlplane $ jsonnet deployment.jsonnet > deployment.yaml
controlplane $ 
controlplane $ vi service.jsonnet 
controlplane $ 
controlplane $ jsonnet service.jsonnet service.yaml    
ERROR: only one filename is allowed

controlplane $ 
controlplane $ jsonnet service.jsonnet > service.yaml
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Aug 14 11:51 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.4K Aug 14 11:50 deployment.jsonnet
-rw-r--r-- 1 root root 1.7K Aug 14 11:50 deployment.yaml
-rw-r--r-- 1 root root  378 Aug 14 11:51 service.jsonnet
-rw-r--r-- 1 root root  419 Aug 14 11:51 service.yaml
controlplane $ 
controlplane $ mc

controlplane $ cat deployment.jsonnet 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
  },
  spec: {
    replicas: '{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: '{}',  //
          },
        ],
      },
    },
  },
}
controlplane $ 
controlplane $ 
controlplane $ cat deployment.yaml 
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": "{}",
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat service.jsonnet 
{
  // Config Service
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
    labels: {
      app: 'fb',
    },
  },
  spec: {
    type: 'NodePort',
    ports: [
      {
        port: 80,
        nodePort: '{{ .Values.nodePort }}',
      },
    ],
    selector: {
      app: 'fb-pod',  //
    },
  },
}
controlplane $ 
controlplane $ 
controlplane $ cat service.yaml 
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "{{ .Values.nodePort }}",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
controlplane $ 
controlplane $ 
controlplane $ rm deployment.jsonnet service.jsonnet 
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 14 11:52 .
drwxr-xr-x 4 root root 4.0K Aug 14 11:01 ..
-rw-r--r-- 1 root root  368 Aug 14 11:01 NOTES.txt
-rw-r--r-- 1 root root 1.7K Aug 14 11:50 deployment.yaml
-rw-r--r-- 1 root root  419 Aug 14 11:51 service.yaml
controlplane $ 
controlplane $ cd ..
controlplane $ cd ..
controlplane $ 
controlplane $ ls
fb-pod-app1  fb-pod-app2  fb-pod-app3  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ helm template fb-app fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "fb-pod-app1",
      "namespace": "app1"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "30080",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
---
# Source: fb-pod-app1/templates/deployment.yaml
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "fb-pod-app1",
      "namespace": "app1"
   },
   "spec": {
      "replicas": "1",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "zakharovnpa/k8s-frontend:05.07.22",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "zakharovnpa/k8s-backend:05.07.22",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": "{}",
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm deploy fb-app fb-pod-app1
Error: unknown command "deploy" for "helm"
Run 'helm --help' for usage.
controlplane $ 
controlplane $ helm create fb-app fb-pod-app1
Error: "helm create" requires 1 argument

Usage:  helm create NAME [flags]
controlplane $ 
controlplane $ helm create fb-pod-app1       
Creating fb-pod-app1
WARNING: File "/root/My-Project/stage/fb-pod-app1/Chart.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/values.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/.helmignore" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/deployment.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/service.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/NOTES.txt" already exists. Overwriting.
controlplane $ 
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
app1              Active   53m
app2              Active   53m
default           Active   44h
kube-node-lease   Active   44h
kube-public       Active   44h
kube-system       Active   44h
stage             Active   53m
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-j5mh6   2/2     Running   0          53m
controlplane $ 
controlplane $ kubectl delete -n app1 pod fb-pod-app1-6464948946-j5mh6 
pod "fb-pod-app1-6464948946-j5mh6" deleted
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-fsh7n   2/2     Running   0          42s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   1/1     1            1           55m
controlplane $ 
controlplane $ kubectl delete -n app1 deployments.apps fb-pod-app1     
deployment.apps "fb-pod-app1" deleted
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS        RESTARTS   AGE
fb-pod-app1-6464948946-fsh7n   2/2     Terminating   0          79s
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS        RESTARTS   AGE
fb-pod-app1-6464948946-fsh7n   2/2     Terminating   0          92s
controlplane $ 
controlplane $ kubectl -n app1 get pod
No resources found in app1 namespace.
controlplane $ 
controlplane $ helm create fb-pod-app1
Creating fb-pod-app1
WARNING: File "/root/My-Project/stage/fb-pod-app1/Chart.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/values.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/.helmignore" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/ingress.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/deployment.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/service.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/serviceaccount.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/hpa.yaml" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/NOTES.txt" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/_helpers.tpl" already exists. Overwriting.
WARNING: File "/root/My-Project/stage/fb-pod-app1/templates/tests/test-connection.yaml" already exists. Overwriting.
controlplane $ 
```

#### Логи-2
```
Sun Aug 14 12:29:17 UTC 2022
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
LAST DEPLOYED: Sun Aug 14 12:29:17 2022
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
fb-pod-app1-6464948946-qkhrb   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          73s
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-qkhrb   2/2     Running   0          61s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   1/1     1            1           71s
controlplane $ 
controlplane $ kubectl -n app1 delete deployments.apps 
error: resource(s) were provided, but no name was specified
controlplane $ 
controlplane $ kubectl -n app1 delete deployments.apps fb-pod-app1 
deployment.apps "fb-pod-app1" deleted
controlplane $ 
controlplane $ kubectl -n app1 get pod
NAME                           READY   STATUS        RESTARTS   AGE
fb-pod-app1-6464948946-qkhrb   2/2     Terminating   0          2m8s
controlplane $ 
controlplane $ cd fb-pod-app1/templates/
controlplane $ 
controlplane $ ls -l
total 12
-rw-r--r-- 1 root root 368 Aug 14 12:29 NOTES.txt
-rw-r--r-- 1 root root 998 Aug 14 12:29 deployment.yaml
-rw-r--r-- 1 root root 258 Aug 14 12:29 service.yaml
controlplane $ 
controlplane $ cd ..
controlplane $ cd ..
controlplane $ 
controlplane $ cd fb-pod-app1/templates/
controlplane $ 
controlplane $ ls -l
total 12
-rw-r--r-- 1 root root 368 Aug 14 12:29 NOTES.txt
-rw-r--r-- 1 root root 998 Aug 14 12:29 deployment.yaml
-rw-r--r-- 1 root root 258 Aug 14 12:29 service.yaml
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ cat deployment.yaml 
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": "{}",
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ vi service.yaml 
controlplane $ 
controlplane $ cat service.yaml 
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "{{ .Values.nodePort }}",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}

controlplane $ 
controlplane $ 
controlplane $ ls -l
total 12
-rw-r--r-- 1 root root  368 Aug 14 12:29 NOTES.txt
-rw-r--r-- 1 root root 1737 Aug 14 12:38 deployment.yaml
-rw-r--r-- 1 root root  420 Aug 14 12:39 service.yaml
controlplane $ 
controlplane $ cd ..
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-app fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "fb-pod-app1",
      "namespace": "app1"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "30080",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
---
# Source: fb-pod-app1/templates/deployment.yaml
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "fb-pod-app1",
      "namespace": "app1"
   },
   "spec": {
      "replicas": "1",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "zakharovnpa/k8s-frontend:05.07.22",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "zakharovnpa/k8s-backend:05.07.22",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": "{}",
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ helm install fb-app fb-pod-app1
Error: INSTALLATION FAILED: unable to build kubernetes objects from release manifest: error validating "": error validating data: ValidationError(Service.spec.ports[0].nodePort): invalid type for io.k8s.api.core.v1.ServicePort.nodePort: got "string", expected "integer"
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ helm install fb-pod-app1            
Error: INSTALLATION FAILED: must either provide a name or specify --generate-name
controlplane $ 
controlplane $ 
controlplane $ 
```
## Подготовить helm чарт для приложения. 


#### Установка Helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
./get_helm.sh
```
#### Конвертировать файлы манифестов в формат json
##### Инструменты для конвертирования:
- [yaml2jsonnet](https://github.com/waisbrot/yaml2jsonnet)
* Установка
```
apt install jsonnet

apt install python3-pip -y

pip install yaml2jsonnet

```
* Команда преобразования. 
> В файле `trivial.yaml` для корректного преобразования должен быть описан только один объект Kubernetes, 
например, Deployment, Pod, Service (не несколько в одном файле). Иначе будут ошибки при перобразовании.

```
yaml2jsonnet trivial.yaml | jsonnetfmt - -o trivial.jsonnet
```

#### Скрипт разворачивания окружения

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
apt install jsonnet && \
apt install python3-pip -y && \
pip install yaml2jsonnet && \
kubectl create namespace stage && \
kubectl create namespace app1 && \
kubectl create namespace app2 && \
mkdir -p My-Project/stage && \
mkdir -p My-Project/app1 && \
mkdir -p My-Project/app2 && \
cd My-Project/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
cd ../app1 && \
touch app1-pv.yaml app1-pvc.yaml app1-front-back.yaml && \
cd ../app2 && \
touch app2-pv.yaml app2-pvc.yaml app2-front.yaml app2-back.yaml && \
cd ../stage && \
clear && \
date && \
pwd && \
helm create fb-pod-app1 && \
cd fb-pod-app1 && \
rm values.yaml && \
touch values.yaml && \
echo "" > values.yaml && \
cd templates && \
rm -r * && \
touch NOTES.txt deployment.yaml service.yaml && \
echo "--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to {{ .Values.namespace }} namespace. 
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------" > NOTES.txt && \
echo "
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }}
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
" > deployment.yaml && \
echo "
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
" > service.yaml && \
cd .. && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
" > values.yaml && \
cd .. && \
helm template fb-pod-app1 && \
helm install fb-pod-app1 fb-pod-app1 && \
cp -r fb-pod-app1 fb-pod-app2 && \
cp -r fb-pod-app1 fb-pod-app3 && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "12.07.22"
nodePort: 30081
" > fb-pod-app2/values.yaml && \
echo "
apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "13.07.22"
" > fb-pod-app3/Chart.yaml && \
echo "
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.07.22"
" > fb-pod-app2/Chart.yaml && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "13.07.22"
nodePort: 30082
" > fb-pod-app3/values.yaml && \
kubectl -n app1 get po && \
echo "kubectl -n app1 get po"
```

```
echo "
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
    nodePort: 30080
  selector:
    app: fb-pod
" > test-1.txt
```
```
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
```

### Как устанавливать приложения в разные namespace
1. Изменить namespace в файле values.yml
2. Отследить уникальность портов сетевых сервисов при создании копий деплоя
3. Изменить версию чарта в файле Chart.yaml
4. Собрать приложение `helm template fb-pod`
5. Установить приложение поод другим именем `helm install fb-pod-app1 fb-pod`


### Используемые манифесты

#### Notes.txt
```
---------------------------------------------------------

Content of NOTES.txt appears after deploy.

Deployed to {{ .Values.namespace }} namespace.
NodePort is {{ .Values.nodePort }}.
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------
```
#### файл шаблона с переменными `values.yaml`

```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
```

#### файл шаблона `service.yaml`
```yml
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
```
#### файл шаблона `deployment.yaml`

```yml
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }} 
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
 
```


###  Ход выполнения

#### Команды

