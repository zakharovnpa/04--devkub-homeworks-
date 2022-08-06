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
#### Примеры
##### 1. Файлы из которых создаются манфесты
* pod-spec.jsonnet
``` 
local utils = import 'utils.libsonnet';

local PodSpec = {
  containersObj:: {
    foo: {
      envObj:: {
        var1: 'somevalue',
        var2: 'somevalue',
      },
      env: utils.pairList(self.envObj),
    },
    bar: {
      envObj:: {
        var2: 'somevalue',
        var3: 'somevalue',
      },
      env: utils.pairList(self.envObj),
    },
  },
  containers:
    utils.namedObjectList(self.containersObj),
};

PodSpec {
  containersObj+: {
    bar+: { envObj+: { var3: 'othervalue' } }
  }
}
```
* cat utils.libsonnet 
```
// utils.libsonnet
{
  pairList(tab, kfield='name',
           vfield='value'):: [
    { [kfield]: k, [vfield]: tab[k] }
    for k in std.objectFields(tab)
  ],

  namedObjectList(tab, name_field='name'):: [
    tab[name] + { [name_field]: name }
    for name in std.objectFields(tab)
  ],
}
```
##### Запускаем jsonnet
```
jsonnet pod-spec.jsonnet 
```


##### 2. Полученный манфест
* pod-spec.yaml 

```yml
{
   "containers": [
      {
         "env": [
            {
               "name": "var2",
               "value": "somevalue"
            },
            {
               "name": "var3",
               "value": "othervalue"
            }
         ],
         "name": "bar"
      },
      {
         "env": [
            {
               "name": "var1",
               "value": "somevalue"
            },
            {
               "name": "var2",
               "value": "somevalue"
            }
         ],
         "name": "foo"
      }
   ]
}
```
* pod-spec.uaml
```yml
---
containers:
- env:
  - name: var2
    value: somevalue
  - name: var3
    value: othervalue
  name: bar
- env:
  - name: var1
    value: somevalue
  - name: var2
    value: somevalue
  name: foo

```
* Преобразование с помощью jsonnetfmt
```
jsonnetfmt -i pod-spec.yaml 
```
* cat pod-spec.yaml 
```
{
  containers: [
    {
      env: [
        {
          name: 'var2',
          value: 'somevalue',
        },
        {
          name: 'var3',
          value: 'othervalue',
        },
      ],
      name: 'bar',
    },
    {
      env: [
        {
          name: 'var1',
          value: 'somevalue',
        },
        {
          name: 'var2',
          value: 'somevalue',
        },
      ],
      name: 'foo',
    },
  ],
}

```
