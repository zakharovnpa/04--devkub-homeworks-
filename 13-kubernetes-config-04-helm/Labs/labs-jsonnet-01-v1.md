## Задание 3(*): Работа с Jsonnet. Вариант 1

### Задача: 
1. создать файлы `.jsonnet` для создания из них файлов манифестов для деплойментов, сервсов и прочее. 
2. сохранить эти файлы в формате `yaml`. 
3. на сонове этих файлов создать чарты Helm

#### 1. создать файлы `.jsonnet` для создания из них файлов манифестов для деплойментов, сервсов и прочее.


Используем инструмент преобразования фалов манифестов Kubernetes в файлы jsonnet.

[Conversion Tool](https://jsonnet.org/articles/kubernetes.html)

Не разобрался что это за инструмент.

Но есть [Онлайн конвертер](https://www.json2yaml.com/convert-yaml-to-json)

* Результат работы конвертера
* kube.yaml
```yml
kind: ReplicationController
apiVersion: v1
metadata:
  name: spark-master-controller
spec:
  replicas: 1
  selector:
    component: spark-master
  template:
    metadata:
      labels:
        component: spark-master
    spec:
      containers:
        - name: spark-master
          image: k8s.gcr.io/spark:1.5.2_v1
          command: ["/start-master"]
          ports:
            - containerPort: 7077
            - containerPort: 8080
          resources:
            requests:
              cpu: 100m
```

* kube.json
```json
{
  "kind": "ReplicationController",
  "apiVersion": "v1",
  "metadata": {
    "name": "spark-master-controller"
  },
  "spec": {
    "replicas": 1,
    "selector": {
      "component": "spark-master"
    },
    "template": {
      "metadata": {
        "labels": {
          "component": "spark-master"
        }
      },
      "spec": {
        "containers": [
          {
            "name": "spark-master",
            "image": "k8s.gcr.io/spark:1.5.2_v1",
            "command": [
              "/start-master"
            ],
            "ports": [
              {
                "containerPort": 7077
              },
              {
                "containerPort": 8080
              }
            ],
            "resources": {
              "requests": {
                "cpu": "100m"
              }
            }
          }
        ]
      }
    }
  }
}

```
* Конвертируем в формат json файл [fb-pod.yaml](/13-kubernetes-config-02-mounts/Files/fb-pod.yaml)
* Результат [fb-pod.json]()
```json
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "fb-pod",
    "namespace": "stage"
  },
  "spec": {
    "replicas": 1,
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
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
```

