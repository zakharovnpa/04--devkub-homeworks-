## ЛР-220821-0820. Знакомство с Qbec и Jsonnet

- [ЛР-220821-0820. Знакомство с Qbec и Jsonnet](/13-kubernetes-config-05-qbec/Labs/labs-220821-0820-acquaintance-qbec-and-jsonnet.md)

### Источники информации:
1. Проект [Grafana Tanka](https://tanka.dev/tutorial/jsonnet) - очень похож на Qbec, но работает на Grafana & Promrtheus

#### Уроки по Grafana Tanka
- [Руководство](https://tanka.dev/tutorial/overview)/. Учимся пользоваться Танкой

> Добро пожаловать в учебник Танка! В следующих разделах объясняется, как развернуть пример стека 
> ( Grafana и Prometheus ) в Kubernetes. Мы также разберемся с параметрами, различиями devи prodтем, 
> как перестать волноваться и полюбить библиотеки.

Для этого у нас есть следующие шаги:

1. [Развертывание сначала без Tanka](https://tanka.dev/tutorial/refresher) : Использование старого доброго, kubectlчтобы понять, что Tanka сделает для нас.
2. [Использование Jsonnet](https://tanka.dev/tutorial/jsonnet) : делаем то же самое еще раз, но на этот раз с Tanka и Jsonnet.
3. [Параметризация](https://tanka.dev/tutorial/parameters) : использование переменных для предотвращения дублирования данных.
4. [Абстракция](https://tanka.dev/tutorial/abstraction) : разделение компонентов на отдельные части.
5. [Среды](https://tanka.dev/tutorial/environments) : работа с различиями между devи prod.
6. [k.libsonnet](https://tanka.dev/tutorial/k-lib): Избегайте необходимости запоминать ресурсы API.
Завершение этого дает твердое знание основ Tanka. Давайте начнем!

### По аналогии с Grafana Tanka будем проходить шаги по созданию шаблонов Qbec

#### 1. Развертывание сначала без Qbec
> Создаем манифесты на основе обычных файлов yaml

> Это позволить развернуть приложения Frontend и Backend в клстере Kubernetes и запустить сетевой сервис для подключения к Frontend извне.

* fb-pod.yaml
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
* grafana.yaml
```yml
# Grafana server Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  selector:
    matchLabels:
      name: grafana
  template:
    metadata:
      labels:
        name: grafana
    spec:
      containers:
        - image: grafana/grafana
          name: grafana
          ports:
            - containerPort: 3000
              name: ui
---
# Grafana UI Service NodePort
apiVersion: v1
kind: Service
metadata:
  labels:
    name: grafana
  name: grafana
spec:
  ports:
    - name: grafana-ui
      port: 3000
      targetPort: 3000
  selector:
    name: grafana
  type: NodePort

```
* prometheus
```yml
# Prometheus server Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  selector:
    matchLabels:
      name: prometheus
  template:
    metadata:
      labels:
        name: prometheus
    spec:
      containers:
        - image: prom/prometheus
          name: prometheus
          ports:
            - containerPort: 9090
              name: api
---
# Prometheus API Service
apiVersion: v1
kind: Service
metadata:
  labels:
    name: prometheus
  name: prometheus
spec:
  ports:
    - name: prometheus-api
      port: 9090
      targetPort: 9090
  selector:
    name: prometheus
```

Это довольно многословно, верно?

Хуже того, есть метки и сопоставители (например fb-app), которые должны быть точно такими же, разбросанными по всему файлу. Это кошмар для отладки и, кроме того, сильно вредит читабельности.

```
Развертывание в кластере
Чтобы применить эти ресурсы, скопируйте их в .yamlфайлы и используйте:

$ kubectl apply -f fb-pod.yaml
deployment.apps/fb-pod created
service/fb-pod created

Проверка, это сработало
Пока все хорошо, но можем ли мы сказать, что это действительно сделало то, что мы хотели? 
Давайте проверим, может ли Grafana подключиться к Prometheus!

# Temporarily forward Grafana to localhost
kubectl port-forward deployments/grafana 8080:3000

Теперь перейдите по адресу http://localhost:8080 в браузере и войдите в систему, используя admin:admin. Затем перейдите к Configuration > Data Sources > Add data source, выберите Prometheusтип и введите http://prometheus:9090URL-адрес. Удар Save & Test, который должен дать большую зеленую полосу, сообщающую вам, что все хорошо.

Прохладный! Это хорошо сработало для этого небольшого примера, но .yamlфайлы трудно читать и поддерживать. Особенно, когда вам нужно развернуть то же самое, devи prodваш выбор очень ограничен.

Давайте узнаем, как Танка может помочь нам в следующем разделе!

Убираться
Давайте удалим все, что мы создали, чтобы начать заново с Jsonnet в следующем разделе:

$ kubectl delete -f prometheus.yaml -f grafana.yaml
```
#### 2. Использование Jsonnet

> Самая мощная часть Tanka — это [язык шаблонов данных Jsonnet](https://jsonnet.org/). 

Jsonnet — это надмножество JSON, в которое добавлены:
- переменные, 
- функции, 
- исправления (глубокое слияние), 
- арифметика, 
- условные операторы 
- и многое другое.

> Он имеет много общего с более реальными языками программирования, такими как JavaScript, чем с языками разметки, тем не менее он предназначен специально для представления данных и конфигурации. В отличие от JSON (и YAML) это язык, предназначенный для людей, а не для компьютеров.

* Создание нового проекта
Чтобы начать работу с Tanka и Jsonnet, давайте инициируем новый проект, в котором мы установим Prometheus и Grafana в наш кластер Kubernetes:
```
$ mkdir prom-grafana && cd prom-grafana # create a new folder for the project and change to it
$ tk init # initiate a new project
```
Это дает нам следующую структуру каталогов:
```
├── environments
│   └── default # default environment
│       ├── main.jsonnet # main file (important!)
│       └── spec.json # environment's config
├── jsonnetfile.json
├── lib # libraries
└── vendor # external libraries
```
На данный момент нас действительно интересует только папка environments/default . Назначение других каталогов будет объяснено позже в этом руководстве (в основном это относится к библиотекам).

* Окружающая среда
При использовании Tanka вы применяете конфигурацию Environment к кластеру Kubernetes . Среда — это некоторая логическая группа частей, образующих стек приложений.

Например, Grafana Labs использует Loki , Cortex и, конечно же , Grafana для нашего предложения Grafana Cloud . Для каждого из них у нас есть отдельная среда. Кроме того, нам нравится видеть изменения в нашем коде в отдельных devнастройках, чтобы убедиться, что все они подходят для использования в рабочей среде, поэтому у нас devтакже есть prodсреды для каждого приложения, поскольку prod среды обычно требуют другой конфигурации (секреты, масштаб и т. д.), чем dev. Это примерно оставляет нам следующее:


Локи|кора|Графана
|-|-|-|
**prod**	Имя: /environments/loki/prod|Имя: /environments/cortex/prod|Имя: /environments/grafana/prod
Пространство имен:loki-prod	|Пространство имен:cortex-prod	|Пространство имен:grafana-prod|

Локи|кора|Графана
|-|-|-|
**dev**	Имя: /environments/loki/dev|Имя: /environments/cortex/dev|Имя: /environments/grafana/dev
Пространство имен:loki-dev|Пространство имен:cortex-dev	| Пространство имен:grafana-dev

Сложность среды не ограничена, создавайте столько, сколько вам нужно для моделирования собственных требований. Grafana Labs, например, также умножает все это на регион высокой доступности.

Для начала достаточно одной среды. 
Давайте воспользуемся автоматически созданным environnments/defaultдля этого.

* Определение ресурсов
* 
Загружая kubectlвсе `.yaml` файлы в определенной папке, у Tanka есть один файл, который служит каноническим источником для всего содержимого среды, называемого `main.jsonnet`. Это точно так же, как в Go main.goили C++ в main.cpp.

Подобно JSON, каждый `.jsonnet` файл содержит один объект. Тот, который возвращается, `main.jsonnet` будет содержать все ваши ресурсы Kubernetes:

```
// main.jsonnet
{
    "some_deployment": { /* ... */ },
    "some_service": { /* ... */ }
}
```
Они могут быть глубоко вложенными, Tanka автоматически извлекает все, что похоже на ресурс Kubernetes.

* Итак, давайте перепишем предыдущее `.yaml `в очень простое `.jsonnet`:

* main.jsonnet

```js
{
  // Grafana
  grafana: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'grafana',
      },
      spec: {
        selector: {
          matchLabels: {
            name: 'grafana',
          },
        },
        template: {
          metadata: {
            labels: {
              name: 'grafana',
            },
          },
          spec: {
            containers: [
              {
                image: 'grafana/grafana',
                name: 'grafana',
                ports: [{
                    containerPort: 3000,
                    name: 'ui',
                }],
              },
            ],
          },
        },
      },
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: 'grafana',
        },
        name: 'grafana',
      },
      spec: {
        ports: [{
            name: 'grafana-ui',
            port: 3000,
            targetPort: 3000,
        }],
        selector: {
          name: 'grafana',
        },
        type: 'NodePort',
      },
    },
  },

  // Prometheus
  prometheus: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'prometheus',
      },
      spec: {
        minReadySeconds: 10,
        replicas: 1,
        revisionHistoryLimit: 10,
        selector: {
          matchLabels: {
            name: 'prometheus',
          },
        },
        template: {
          metadata: {
            labels: {
              name: 'prometheus',
            },
          },
          spec: {
            containers: [
              {
                image: 'prom/prometheus',
                imagePullPolicy: 'IfNotPresent',
                name: 'prometheus',
                ports: [
                  {
                    containerPort: 9090,
                    name: 'api',
                  },
                ],
              },
            ],
          },
        },
      },
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: 'prometheus',
        },
        name: 'prometheus',
      },
      spec: {
        ports: [
          {
            name: 'prometheus-api',
            port: 9090,
            targetPort: 9090,
          },
        ],
        selector: {
          name: 'prometheus',
        },
      },
    },
  },
}
```
* Файл, пребразованный в [онлайн-конвертере](https://www.json2yaml.com/convert-yaml-to-json)

* grafana.json
```js
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "name": "grafana"
  },
  "spec": {
    "selector": {
      "matchLabels": {
        "name": "grafana"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "name": "grafana"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "grafana/grafana",
            "name": "grafana",
            "ports": [
              {
                "containerPort": 3000,
                "name": "ui"
              }
            ]
          }
        ]
      }
    }
  }
}
```
* Для преобразования этого файлв в файл jsonnet необходимо обернуть его 


```
{ 
  grafana: {
    deployment: {
      
  
    },
  },
}
```

На данный момент это еще более многословно, потому что мы успешно преобразовали YAML в JSON, который по дизайну требует больше символов.

Но Jsonnet открывает достаточно возможностей, чтобы значительно улучшить это, что будет рассмотрено в следующих разделах.

* Манифест для создания пространства имен namespace
```yml
{
  my_namespace: {
    apiVersion: "v1",
    kind: "Namespace",
    metadata: {
      name: "monitoring"
    }
  }
}
```




* Подключение к кластеру
YAML выглядит так, как ожидалось? Применим его к кластеру. Для этого Танке нужна дополнительная настройка.

Хотя для хранения текущего выбранного кластера kubectlиспользуется $KUBECONFIGпеременная среды и файл в домашнем каталоге, Tanka использует более явный подход:

В каждой среде есть файл с именем spec.json, содержащий информацию для выбора кластера:

* Среда
```
{
  "apiVersion": "tanka.dev/v1alpha1",
  "kind": "Environment",
  "metadata": {
    "name": "default"
  },
  "spec": {
    "apiServer": "https://127.0.0.1:6443", // cluster to use
    "namespace": "monitoring" // default namespace for all created resources
  }
}
```

#### 3. Параметризации
> Развертывание с помощью Tanka работало хорошо, но не особо улучшало ситуацию с точки зрения ремонтопригодности и читабельности.

> Для этого в следующих разделах будут рассмотрены некоторые способы, которые предоставляет нам Jsonnet.

* Объект конфигурации

Самое простое, что можно сделать, — это создать скрытый объект, содержащий все фактические значения в одном месте, которые будут потребляться реальными ресурсами.

К счастью, в Jsonnet есть раздел `key:: "value"` для частных полей. Они доступны только во время компиляции и будут удалены из фактического вывода.

Такой объект может выглядеть так:
```js
{
  _config:: {
    grafana: {
      port: 3000,
      name: "grafana",
    },
    prometheus: {
      port: 9090,
      name: "prometheus"
    }
  }
}
```
Затем мы можем заменить жестко заданные значения ссылкой на этот объект:

```
{ // <- This is $
  _config:: { /* .. */ },
  grafana: {
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
-         name: 'grafana',
+         name: $._config.grafana.name, // $ refers to the outermost object
        },
-       name: 'grafana',
+       name: $._config.grafana.name,
      },
      spec: {
        ports: [{
-           name: 'grafana-ui',
+           name: '%s-ui' % $._config.grafana.name, // printf-style formatting
-           port: 3000,
+           port: $._config.grafana.port,
-           targetPort: 3000,
+           targetPort: $._config.grafana.port,
        }],
        selector: {
-          name: 'grafana',
+          name: $._config.grafana.name,
        },
        type: 'NodePort',
      },
    },
  },
}
```

Здесь мы видим, что можем легко ссылаться на другие части конфигурации, используя самый внешний объект $(корневой уровень). Каждое значение — это просто обычная переменная, на которую вы можете ссылаться, используя тот же знакомый синтаксис из других C-подобных языков.

Теперь у нас есть не только одно место для изменения настраиваемых параметров, но также мы больше не будем страдать от несоответствия меток и селекторов, так как они определены в одном месте и все меняются сразу.

#### 4. Абстракция

Абстракция
`_config` Хотя теперь, когда у нас есть объект для наших настраиваемых параметров, нам больше не нужно напрямую касаться определений ресурсов, `main.jsonnet` файл все еще очень длинный и трудный для чтения. Тем более, что из-за всех скобок это даже хуже, чем yaml на данный момент.

Разделение его

* Давайте начнем очищать это, разделив логические части на отдельные файлы:

  * main.jsonnet: по-прежнему наш основной файл, содержащий `_config` объект и импортирующий другие файлы.
  * grafana.jsonnet: Deploymentи Service для экземпляра Grafana
  * prometheus.jsonnet: Deploymentи Serviceдля сервера Prometheus

* grafana.jsonnet
```yml
{
  // DO NOT use the root level here.
  // Include the grafana subkey, otherwise $ won't work.
  grafana: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: $._config.grafana.name,
      },
      spec: {
        selector: {
          matchLabels: {
            name: $._config.grafana.name,
          },
        },
        template: {
          metadata: {
            labels: {
              name: $._config.grafana.name,
            },
          },
          spec: {
            containers: [
              {
                image: 'grafana/grafana',
                name: $._config.grafana.name,
                ports: [{
                    containerPort: $._config.grafana.port,
                    name: 'ui',
                }],
              },
            ],
          },
        },
      },
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: $._config.grafana.name,
        },
        name: $._config.grafana.name,
      },
      spec: {
        ports: [{
            name: '%s-ui' % $._config.grafana.name,
            port: $._config.grafana.port,
            targetPort: $._config.grafana.port,
        }],
        selector: {
          name: $._config.grafana.name,
        },
        type: 'NodePort',
      },
    },
  }
}
```
Файл должен содержать ровно то же самое, что grafana раньше находилось под ключом на корневом объекте. Сделайте то же самое для 
`/environments/default/prometheus.jsonnet` тоже.

* main.jsonnet
```yml
// Think of `import` as copy-pasting the contents
// of ./grafana.jsonnet here
(import "grafana.jsonnet") +
(import "prometheus.jsonnet") +
{
  _config:: {
    grafana: {
      port: 3000,
      name: "grafana",
    },
    prometheus: {
      port: 9090,
      name: "prometheus"
    }
  }
}
```
> Пояснение :
на первый взгляд может показаться странным, что этот код работает, потому что он grafana.jsonnetпо-прежнему ссылается на корневой объект с помощью $, даже если он находится за пределами области действия файла.
Однако Jsonnet оценивается отложенно, что означает, что содержимое grafana.jsonnetсначала «копируется» в main.jsonnet(корневой объект), а затем оценивается . Это означает, что приведенный выше код на самом деле состоит из всех трех объектов, объединенных в один большой объект, который затем преобразуется в JSON.

* Вспомогательные утилиты
Хотя main.jsonnetтеперь он короткий и очень читабельный, два других файла на самом деле не являются улучшением по сравнению с обычным yaml, в основном потому, что они все еще полны шаблонов.

Давайте воспользуемся функциями, чтобы создать несколько полезных помощников, чтобы уменьшить количество повторений. Для этого мы создаем новый файл с именем kubernetes.libsonnet, в котором будут храниться наши утилиты Kubernetes.

> Примечание . Расширение для библиотек Jsonnet — .libsonnet. Хотя вам не нужно его использовать, он отличает вспомогательный код от фактической конфигурации.

Конструктор развертывания
Для создания Deployment требуется некоторая обязательная информация и много шаблонов. Функция, которая его создает, может выглядеть так:

* Код с функцией

```yml

{
  // hidden k namespace for this library
  k:: {
    deployment: {
      new(name, containers): {
        apiVersion: "apps/v1",
        kind: "Deployment",
        metadata: {
          name: name,
        },
        spec: {
          selector: { matchLabels: {
            name: name,
          }},
          template: {
            metadata: { labels: {
              name: name,
            }},
            spec: { containers: containers }
          }
        }
      }
    }
  }
}
```
Вызов этой функции заменит все переменные соответствующими переданными параметрами функции и вернет собранный объект.

Чтобы использовать его, просто добавьте его к корневому объекту в main.jsonnet:

* main.jsonnet
```

```




### Уроки по Qbec

##### Создание нового проекта. [КРАТКИЙ ОБЗОР QBEC](https://qbec.io/userguide/tour/)
Чтобы начать работу с Qbec и Jsonnet, давайте инициируем новый проект, в котором мы установим fb-pod в наш кластер Kubernetes:
```
$ mkdir My-Project && cd My-Project # create a new folder for the project and change to it
$ qbec init demo --with-example # --with-example creates a sample "hello" component
```
> Когда приведенная выше команда выполняется успешно, она создает подкаталог с именем demo, который имеет один компонент и среду. 
> Среда по умолчанию выводится из текущего контекста в вашей конфигурации kube.




Это дает нам следующую структуру каталогов:
* Qbec
```

demo
|-- components
|-- environments
|   |-- base.libsonnet
|   `-- default.libsonnet
|-- params.libsonnet
```
В каталоге создаются следующие файлы demo:

* qbec.yaml: это минимальный манифест qbec, определяющий единую среду
* components/hello.jsonnet: создает карту конфигурации и объект развертывания.
* params.libsonnet- файл параметров времени выполнения верхнего уровня. Это отвечает за возврат правильного набора параметров времени выполнения в зависимости от среды.
* environments/base.libsonnet- базовые параметры времени выполнения со значениями по умолчанию
* environments/default.libsonnet- параметры времени выполнения для среды по умолчанию



##### Выполнение локальных команд
> Следующие команды выполняются локально и не взаимодействуют ни с одним сервером Kubernetes.

`qbec show default` # show the YAML that would be applied to the server

`qbec component list default` # list all components

`qbec param list default`  # list all parameters

`qbec show -O default` # show all object names instead of contents

* Далее идет тескт со страницы `КРАТКИЙ ОБЗОР QBEC`
```
Фильтрация
Большинство команд qbec можно применять к подмножеству компонентов или объектов. Компоненты могут быть включены или исключены с помощью фильтров -cи . -CОпределенные типы объектов можно включать и исключать с помощью фильтров -kи .-K

qbec show -k deployment default # only shows the deployment but not configmap

qbec show -K deployment default # only shows the configmap and excludes the deployment

qbec show -C hello default # no output since the only component has been excluded
Проверить, сравнить и применить
qbec validate default # validates local objects against server metadata

qbec diff default # shows a diff between remote and local objects

qbec apply default  # applies the components to an environment similar to kubectl apply
После того как объекты были применены к удаленному кластеру, последующие команды diffи applyне должны показывать никаких изменений. Повторно запустите эти команды, чтобы убедиться, что это действительно так.

Внесение изменений
Сделаем некоторые изменения в параметрах.

Отредактируйте environments/default.libsonnetфайл и измените количество реплик и/или строку конфигурации. Повторно запустите команды diffи apply. Они должны показывать, соответственно, что отличается и отображать патч, отправленный на сервер для его применения.

Очистить
Существует два способа очистки qbecсозданных объектов. В любом случае будут удалены только компоненты, созданные qbec.

вы можете явно удалить их.
qbec delete default
вы можете удалить локальный компонент и позволить сборке мусора позаботиться об этом.
rm components/hello.jsonnet
qbec apply default
```
