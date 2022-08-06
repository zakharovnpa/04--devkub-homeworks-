## Задание 3(*): Работа с Jsonnet. Создание из файла jsonnet шаблона jsonnet для создания манифестов. Группировка по объектам и категорям

### Задание:
1. Из файла jsonnet создать шаблон jsonnet для создания манифестов

### Ход решения:

#### Скрипт развертывания окружения и установки утилит
* Полигон [killercoda](https://killercoda.com/playgrounds/scenario/kubernetes)
```
apt install jsonnet && \
apt install python3-pip -y && \
pip install yaml2jsonnet && \
mkdir -p My-Project && \
cd My-Project && \
touch pod.yaml pod.jsonnet && \
mkdir -p components && \
kubectl create namespace stage && \
echo "
---
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
...
" > pod.yaml && \
cat pod.yaml

```
