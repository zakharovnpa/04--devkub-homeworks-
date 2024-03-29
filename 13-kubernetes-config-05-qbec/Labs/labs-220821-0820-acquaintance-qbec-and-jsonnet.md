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

#### 1. Развертывание сначала без Tanka
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
  
  // НЕ ИСПОЛЬЗУЙТЕ здесь корневой уровень.
  // Включите подраздел grafana, иначе $ не будет работать.
  
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

// Думайте об `импорте` как о копировании содержимого
// из ./grafana.jsonnet здесь

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
Однако Jsonnet оценивается отложенно, что означает, что содержимое `grafana.jsonnet` сначала «копируется» в `main.jsonnet`(корневой объект), а затем оценивается. Это означает, что приведенный выше код на самом деле состоит из всех трех объектов, объединенных в один большой объект, который затем преобразуется в JSON.

* Вспомогательные утилиты
Хотя `main.jsonnet` теперь он короткий и очень читабельный, два других файла на самом деле не являются улучшением по сравнению с обычным yaml, в основном потому, что они все еще полны шаблонов.

Давайте воспользуемся функциями, чтобы создать несколько полезных помощников, чтобы уменьшить количество повторений. Для этого мы создаем новый файл с именем `kubernetes.libsonnet`, в котором будут храниться наши утилиты Kubernetes.

> Примечание . Расширение для библиотек Jsonnet — .libsonnet. Хотя вам не нужно его использовать, он отличает вспомогательный код от фактической конфигурации.

* Конструктор развертывания

Для создания Deployment требуется некоторая обязательная информация и много шаблонов. Функция, которая его создает, может выглядеть так:

* Код с функцией

```yml

{
  // hidden k namespace for this library
  
  // скрытое пространство имен k для этой библиотеки
  
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
  (import "kubernetes.libsonnet") + // this line adds it
  (import "grafana.jsonnet") +
  (import "prometheus.jsonnet") +
  { /* ... */ }
```
Давайте немного упростим наш `grafana.jsonnet`:

* grafana.jsonnet
```js

{
  grafana: {
    deployment: $.k.deployment.new("grafana", [{
      image: 'grafana/grafana',
      name: 'grafana',
      ports: [{
          containerPort: 3000,
          name: 'ui',
      }],
    }]),
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
  }
}

```
Это значительно упростило создание Deployment, потому что нам больше не нужно помнить, как именно Deploymentустроено . Просто вызовите нашего помощника (Конструктор развертывания), и все готово.

> Задача : Теперь попробуйте добавить конструктор для Service объекта `kubernetes.libsonnet` и использовать оба помощника (каких помощников? Это файлы шаблоны, описывающие объекты Kubernetes, созданные с помошью Конструктора развертывания, ) для воссоздания других объектов.

#### 5. Библиотека Kubernetes
В последнем разделе показано, что использование библиотеки для создания объектов Kubernetes может значительно упростить код, который вам нужно написать. Однако существует огромное количество различных типов объектов, и API Kubernetes развивается (и, следовательно, изменяется) довольно быстро.

Написание и поддержка такой библиотеки может стать самостоятельным занятием на полный рабочий день. К счастью, такую ​​библиотеку можно сгенерировать из спецификации Kubernetes OpenAPI! Более того, это уже было сделано за вас.

* k8s-libsonnet
Библиотека называется k8s-libsonnet(взамен снятой с производства ksonnet-lib), на данный момент доступна по адресу [https://github.com/jsonnet-libs/k8s-libsonnet](https://github.com/jsonnet-libs/k8s-libsonnet).

> Примечание : ksonnet проект заброшен, библиотека больше не поддерживается. Тем не менее, сообщество, поддерживаемое Grafana Labs, подхватило это с k8s-libsonnet библиотекой.

Поскольку k8s-libsonnet в нескольких местах была нарушена совместимость ksonnet-lib(по уважительной причине), мы оснастили широко используемую ksonnet-util библиотеку слоем совместимости, чтобы улучшить взаимодействие с разработчиком и пользователем: [https://github.com/grafana/jsonnet-libs/tree/мастер/ksonnet-утилита](https://github.com/grafana/jsonnet-libs/tree/master/ksonnet-util) 

Если у вас нет веских причин против этого, просто используйте обертку, это облегчит вашу работу. Многие из первоначальных ksonnet-util улучшений уже вошли в k8s-libsonnet.

Документы для k8s-libsonnetбиблиотеки можно найти здесь: [https://jsonnet-libs.github.io/k8s-libsonnet/](https://jsonnet-libs.github.io/k8s-libsonnet/)

* Монтаж
Как и любая другая внешняя библиотека, k8s-libsonnetее можно установить с помощью jsonnet-bundler. Впрочем, Танка уже сделала это за вас при создании проекта ( tk init) :

    $ tk init
      └─ jb install github.com/jsonnet-libs/k8s-libsonnet/1.21@main github.com/grafana/jsonnet-libs/ksonnet-util

Это создало следующую структуру в /vendor:
```
vendor
├── github.com
│   ├── grafana
│   │   └── jsonnet-libs
│   │       └── ksonnet-util
│   │           ├── ...
│   │           └── kausal.libsonnet # Grafana's wrapper
│   └── jsonnet-libs
│       └── k8s-libsonnet
│           └── 1.21
│               ├── ...
│               └── main.libsonnet   # k8s-libsonnet entrypoint
├── 1.21 -> github.com/jsonnet-libs/k8s-libsonnet/1.21
└── ksonnet-util -> github.com/grafana/jsonnet-libs/ksonnet-util
```
> Информация : vendor/ это место для внешних библиотек, но lib/ вы можете использовать его для своих собственных. Проверьте пути импорта для получения дополнительной информации.

* Псевдоним
Из-за того, как jb работает, библиотека может быть импортирована как `github.com/jsonnet-libs/k8s-libsonnet/1.21/main.libsonnet`. Большинство внешних библиотек (включая нашу оболочку) ожидают его как простой k.libsonnet(без префикса пакета).

Чтобы поддерживать и то, и другое, Tanka автоматически создала для вас файл псевдонима: `/lib/k.libsonnet` он просто импортирует фактическую библиотеку, предоставляя ее также под этим альтернативным именем.

> Дополнительная информация : Это работает, потому что `import` ведет себя как копирование и вставка. Таким образом, содержимое `k8s-libsonnet/1.21` «скопировано» в наш новый файл, благодаря чему они ведут себя точно так же.

* Используй это

Сначала нам нужно импортировать его в main.jsonnet:
* main.jsonnet
```
- local k = import "kubernetes.libsonnet";
+ local k = import "github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet";
  local grafana = import "grafana.jsonnet";
  local prometheus = import "prometheus.jsonnet";
  { /* ... */ }
```
> Примечание : `ksonnet-util` импортирует литерал `k.libsonnet`, поэтому [псевдоним](https://tanka.dev/tutorial/k-lib#aliasing) здесь обязателен. Это работает, потому что `/lib` и `/vendor` автоматически ищутся библиотеки, и `k.libsonnet` их можно найти `/lib` из-за вышеупомянутого псевдонима.

Теперь, когда мы установили правильную версию, давайте используем ее `/environments/default/grafana.jsonnet` вместо нашего собственного помощника:
```js
local k = import "github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet";

{
  // use locals to extract the parts we need
  // используем локальные переменные для извлечения нужных нам частей
  
  local deploy = k.apps.v1.deployment,
  local container = k.core.v1.container,
  local port = k.core.v1.containerPort,
  local service = k.core.v1.service,
  // defining the objects:
  // определение объектов:
  grafana: {
    // deployment constructor: name, replicas, containers
    // конструктор развертывания: имя, реплики, контейнеры
    deployment: deploy.new(name=$._config.grafana.name, replicas=1, containers=[
      // container constructor
      // конструктор контейнера
      container.new($._config.grafana.name, "grafana/grafana")
      + container.withPorts( // add ports to the container
          [port.new("ui", $._config.grafana.port)] // port constructor
        ),
    ]),

    // instead of using a service constructor, our wrapper provides
    // a handy helper to automatically generate a service for a Deployment
    // вместо использования конструктора сервиса наша оболочка предоставляет
    // удобный помощник для автоматической генерации сервиса для развертывания
    service: k.util.serv.util.serviceFor(self.deployment)
             + service.mixin.spec.withType("NodePort"),
  }
}

```
* Полный пример
Теперь, когда создание отдельных объектов занимает не более 5 строк, мы можем объединить все это обратно в один файл ( main.jsonnet) и посмотреть на картину в целом:
```js
local k = import "github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet";

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
  },

  local deployment = k.apps.v1.deployment,
  local container = k.core.v1.container,
  local port = k.core.v1.containerPort,
  local service = k.core.v1.service,

  prometheus: {
    deployment: deployment.new(
      name=$._config.prometheus.name, replicas=1,
      containers=[
        container.new($._config.prometheus.name, "prom/prometheus")
        + container.withPorts([port.new("api", $._config.prometheus.port)]),
      ],
    ),
    service: k.util.serviceFor(self.deployment),
  },
  grafana: {
    deployment: deployment.new(
      name=$._config.grafana.name, replicas=1,
      containers=[
        container.new($._config.grafana.name, "grafana/grafana")
        + container.withPorts([port.new("ui", $._config.grafana.port)]),
      ],
    ),
    service:
      k.util.serviceFor(self.deployment)
      + service.mixin.spec.withType("NodePort"),
  },
}
```
Это довольно большое улучшение, учитывая, насколько многословным и подверженным ошибкам он был раньше!

#### 6. Окружающая среда

На данный момент наша конфигурация уже является гибкой и лаконичной, но не может использоваться повторно. Давайте также взглянем на третье модное словечко Танки: Окружающая среда .

В наши дни одна и та же часть программного обеспечения обычно развертывается много раз в одной организации. Это могут быть `dev` и среды, а также регионы ( testing, , ) или отдельные клиенты ( , , ).prodeuropeusasiafoo-corpbar-gmbhbaz-inc

Однако большая часть приложения в этих средах совершенно одинакова ... обычно различаются только конфигурация, масштабирование или мелкие детали. YAML (и, следовательно kubectl, ) предоставляет нам здесь только одно решение: дублирование каталога, изменение деталей, сохранение обоих. Но что, если у вас 32 среды? Правильный! Затем вам нужно поддерживать 32 каталога YAML. И мы все можем представить себе кошмар этих файлов, разлетающихся друг от друга.

Но опять же, Jsonnet может быть решением : извлекая фактические объекты в библиотеку, вы можете импортировать их в столько сред, сколько вам нужно!

* Создание библиотеки
В библиотеке нет ничего особенного, просто папка с .libsonnetфайлами где-то в путях импорта:

Дорожка	|Описание
|-|-|
/lib	|Пользовательские, созданные пользователями библиотеки только для этого проекта.
/vendor	|Внешние библиотеки, установленные с помощью Jsonnet-bundler

Так что для нашей цели /libподходит лучше всего, так как мы создаем его только для нашего текущего проекта. Давайте настроим один:

    /$ mkdir lib/prom-grafana # a folder for our prom-grafana library   # папка для нашей библиотеки prom-grafana
    /$ cd lib/prom-grafana

    /lib/prom-grafana$ touch prom-grafana.libsonnet # library file that will be imported   # файл библиотеки, который будет импортирован
    /lib/prom-grafana$ touch config.libsonnet # _config and images   # _config и образы
    
Для документации удобно иметь отдельный файл для параметров и используемых изображений:
* config.libsonnet
```js

{
  // +:: is important (we don't want to override the
  // _config object, just add to it)
  _config+:: {
    // define a namespace for this library  # определение пространства имен для этой библиотеки
    promgrafana: {
      grafana: {
        port: 3000,
        name: "grafana",
      },
      prometheus: {
        port: 9090,
        name: "prometheus"
      }
    }
  },

  // again, make sure to use +::
  _images+:: {
    promgrafana: {
      grafana: "grafana/grafana",
      prometheus: "prom/prometheus",
    }
  }
}
```

* prom-grafana.libsonnet

```js
local k = import "ksonnet-util/kausal.libsonnet";

(import "./config.libsonnet") +
{
  local deployment = k.apps.v1.deployment,
  local container = k.core.v1.container,
  local port = k.core.v1.containerPort,
  local service = k.core.v1.service,

  // alias our params, too long to type every time
  local c = $._config.promgrafana,

  promgrafana: {
    prometheus: {
      deployment: deployment.new(
        name=c.prometheus.name, replicas=1,
        containers=[
          container.new(c.prometheus.name, $._images.promgrafana.prometheus)
          + container.withPorts([port.new("api", c.prometheus.port)]),
        ],
      ),
      service: k.util.serviceFor(self.deployment),
    },

    grafana: {
      deployment: deployment.new(
        name=c.grafana.name, replicas=1,
        containers=[
          container.new(c.grafana.name, $._images.promgrafana.grafana)
          + container.withPorts([port.new("ui", c.grafana.port)]),
        ],
      ),
      service: 
        k.util.serviceFor(self.deployment)
        + service.mixin.spec.withType("NodePort"),
    },
  }
}
```
* Дев и Прод
До сих пор мы использовали только environments/defaultсреду. Давайте создадим несколько реальных:

    /$ tk env add environments/prom-grafana/dev --namespace=prom-grafana-dev # one for dev ...
    /$ tk env add environments/prom-grafana/prod --namespace=prom-grafana-prod # and one for prod

> Примечание . Не забудьте настроить IP-адрес кластера в соответствующем файле spec.json!

Осталось только импортировать библиотеку и настроить ее. Для dev, значений по умолчанию, определенных в `/lib/prom-grafana/config.libsonnet`должно быть достаточно, поэтому мы ничего не переопределяем:
```js
// environments/prom-grafana/dev
import "prom-grafana/prom-grafana.libsonnet"
```
Однако `prod` полагаться на `latest` образ — плохая идея. давайте добавим несколько правильных тегов:
```js
// environments/prom-grafana/prod
(import "prom-grafana/prom-grafana.libsonnet") +
{
  // again, we only want to patch, not replace, thus +::
  _images+:: {
    // we update this one entirely, so we can replace this one (:)
    promgrafana: {
      prometheus: "prom/prometheus:v2.14",
      grafana: "grafana/grafana:6.5.2"
    }
  }
}
```
* Исправление
Вышеупомянутое хорошо работает для библиотек, которыми мы сами управляем, но что, когда другая команда написала библиотеку, она была установлена ​​с помощью jbGitHub или вы не можете легко ее изменить?

Здесь вступает в игру уже знакомый ` +: (или +::) ` синтаксис. Это позволяет частично переопределять значения объекта. Допустим, мы хотели добавить какие-то метки в Prometheus Deployment, но наши ` _config` параметры не позволяют нам это сделать. Мы все еще можем сделать это в нашем `main.jsonnet`:

* main.jsonnet
```js
(import "prom-grafana/prom-grafana.libsonnet") +
{
  promgrafana+: {
    prometheus+: {
      deployment+: {
        metadata+: {
          labels+: {
            foo: "bar"
          }
        }
      }
    }
  }
}
```
Используя ` +: ` оператор все время и ` foo: "bar" ` используя только `« :»`, мы переопределяем только значение "foo", оставляя остальную часть объекта такой, какой она была.

Проверим, сработало:
```
$ tk show environments/prom-grafana/patched -t deployment/prometheus
```
```js
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    foo: bar # <- There it is!
  name: prometheus
  namespace: default
spec:
  minReadySeconds: 10
  replicas: 1
  revisionHistoryLimit: 10
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
        imagePullPolicy: IfNotPresent
        name: prometheus
        ports:
        - containerPort: 9090
          name: api
```

### Написание Jsonnet
#### 1. Обзор языка
[Jsonnet](https://jsonnet.org/) — это язык шаблонов данных, который Tanka использует для выражения того, что должно быть развернуто в вашем кластере Kubernetes. Понимание Jsonnet имеет решающее значение для эффективного использования Tanka.

На этой странице рассматривается сам язык Jsonnet. Дополнительные сведения о том, как использовать Jsonnet с Kubernetes, см . [в руководстве](https://tanka.dev/tutorial/jsonnet) . Существует также [официальное руководство по Jsonnet](https://jsonnet.org/learning/tutorial.html), в котором представлен более подробный обзор возможностей языка.

* Синтаксис
Будучи надмножеством JSON, синтаксис очень похож:

```js
// Line comment
/* Block comment */

// a local variable (not exported)
local greeting = "hello world!";

// the exported/returned object
{
  foo: "bar", // string
  bar: 5, // int
  baz: false, // bool
  list: [1,2,3], // array
  // object
  dict: {
    nested: greeting, // using the local
  }
  hidden:: "incognito!" // an unexported field
}
```
* Абстракция
Jsonnet имеет богатые возможности абстракции, что делает его интересным для настройки Kubernetes, поскольку он позволяет сохранять конфигурации краткими, но читабельными.

  * Импорт
  * Объединение
  * Функции

##### Импорт
Как и другие языки, Jsonnet позволяет импортировать код из других файлов:
```js
local secret = import "./secret.libsonnet";
```
Экспортируемый объект (единственный нелокальный) ` secret.libsonnet ` теперь доступен как local переменная с именем secret.

При использовании Tanka также можно напрямую импортировать `.json` и `.yaml` файлы, как если бы они были в формате `.libsonnet`.

Не забудьте также ознакомиться с документацией библиотек, чтобы узнать, как использовать import и повторно использовать код. Документация по [путям импорта](https://tanka.dev/libraries/import-paths) и [поставщикам](https://tanka.dev/libraries/install-publish) Tanka полезна для понимания того, как импорт работает в контексте Tanka.

##### Объединение
Глубокое слияние позволяет изменять части объекта, не затрагивая его целиком. Рассмотрим следующий пример:
```js
local secret = {
  kind: Secret,
  metadata: {
    name: "mySecret",
    namespace: "default", // need to change that
  },
  data: {
    foo: std.base64("foo")
  }
};
```

Чтобы изменить только пространство имен, мы можем использовать специальный ключ слияния ` +: `, например:
```js
// define the patch:
local patch = {
  metadata+: {
    namespace: "myApp"
  }
}
```
Разница между ` : ` и ` +: ` заключается в том, что первый заменяет исходные данные в этом ключе, а второй применяет новый объект в качестве исправления поверх, что означает, что значения будут обновлены, если это возможно, но все остальные останутся такими, какие они есть.
Чтобы объединить эти два, просто добавьте ( +) патч к оригиналу:
```js
secret + patch
```
Результатом этого является следующий объект JSON:
```js
{
  "kind": "Secret",
  "metadata": {
    "name": "mySecret",
    "namespace": "myApp"
  },
  "data": {
    "foo": "Zm9vCg=="
  }
}
```
##### Функции
Jsonnet поддерживает функции, аналогичные тому, как это делает Python. Они могут быть определены двумя различными способами:
```js
local add(x,y) = x + y;
local mul = (function(x, y) x * y);
```
Объекты могут иметь методы:

    {
      greet(who): "hello " + who,
    }
    
Значения по умолчанию, аргументы ключевых слов и другие примеры можно найти на [jsonnet.org](https://jsonnet.org/learning/tutorial.html#functions) .

* Стандартная библиотека
Стандартная библиотека Jsonnet включает в себя множество вспомогательных методов, начиная от изменения объектов и массивов и заканчивая строковыми утилитами и помощниками вычислений.

Документация доступна на [jsonnet.org](https://jsonnet.org/learning/tutorial.html#conditionals) .

* использованная литература
Jsonnet имеет несколько вариантов обращения к частям объекта:
```js
{ // this is $
  junk: "foo",
  nested: { // this is self
    app: "Tanka",
    msg: self.app + " rocks!" // "Tanka rocks!"
  },
  children: { // this is also self
    baz: "bar",
    junk: $.junk + self.baz, // "foobar"
  }
}
```
Для получения дополнительной информации взгляните на [jsonnet.org](https://jsonnet.org/learning/tutorial.html#references)

### main.jsonnet
Самый важный файл называется `main.jsonnet`, потому что именно здесь Танка вызывает компилятор Jsonnet. Затем каждая строка Jsonnet, включая импорт, функции и прочее, оценивается до тех пор, пока не останется один очень большой объект JSON.
Этот объект возвращается в Tanka и включает в себя все ваши манифесты Kubernetes где-то в нем, скорее всего глубоко вложенные.

Но, как `kubectl` и ожидается поток yaml, а не вложенное дерево, Танке нужно сначала извлечь ваши объекты. Для этого он обходит дерево, пока не найдет что-то похожее на манифест Kubernetes. Объект считается действительным, если он имеет оба значения `kind` и `apiVersion` установлен.

Чтобы Танка мог найти ваши манифесты, выходные данные вашего Jsonnet должны иметь одну из следующих структур:

* Глубоко вложенный объект (рекомендуется)
Чаще всего используется один большой объект, включающий все манифесты в виде листовых узлов.

Насколько глубоко инкапсулирован реальный объект, не имеет значения, Танка будет двигаться вниз, пока не найдет что-то действительное.
```js

{
  "prometheus": {
    "service": {
      // Service nested one level
      "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
        "name": "promSvc"
      }
    },
    "deployment": {
      "apiVersion": "apps/v1", // apiVersion ..
      "kind": "Deployment", // .. and kind are required to identify an object.
      "metadata": {
        "name": "prom"
      }
    }
  },
  "web": {
    "nginx": {
      "deployment": {
        // Deployment nested two levels
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
          "name": "nginx"
        }
      }
    }
  }
}
```
Использование этого метода имеет большое преимущество в том, что оно является самодокументируемым, поскольку вложение ключей может использоваться для логической группировки связанных манифестов, например, по приложениям.

Также возможен нулевой уровень инкапсуляции, что означает не что иное, как обычный объект, который можно получить из kubectl show -o json:

* Множество
Использование массива объектов также прекрасно:
```js
[
  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "promSvc"
    }
  },
  {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
      "name": "prom"
    }
  }
]
```
* Тип списка
Пользователи kubectlмогли иметь контакт с типом под названием List. Это не часть официального API Kubernetes, а скорее псевдотип, введенный kubectlдля одновременной работы с несколькими объектами. Таким образом, Танка не поддерживает его из коробки.

Чтобы в полной мере воспользоваться возможностями Tankas, вы можете сгладить его вручную:
```js

local list = {
  apiVersion: "v1",
  kind: "List",
  items: [
    {
      apiVersion: "v1",
      kind: "Service",
      /* ... */
    }
    /* ... */
  ]
};

# expose the `items` array on the top level:
list.items
```
### Собственные функции
Tanka расширяет Jsonnet с помощью нативных функций , предлагая дополнительный функционал, которого пока нет в стандартной библиотеке.

Чтобы использовать их в своем коде, вам необходимо получить к ним доступ `std.native` из стандартной библиотеки:
```
{
  someField:  std.native('<name>')(<arguments>),
}
```
`std.native` принимает имя собственной функции в качестве `string` аргумента и возвращает function, который вызывается с использованием второго набора круглых скобок.

##### parseJson
* Подпись

    parseJson(string json) Object
    
`parseJsonан` ализирует строку json и возвращает соответствующий тип Jsonnet ( Object, Array, и т. д.).


* Примеры
{
  array: std.native('parseJson')('[0, 1, 2]'),
  object: std.native('parseJson')('{ "foo": "bar" }'),
}
Оценка с помощью Tanka приводит к JSON:
```
{
  "array": [0, 1, 2],
  "object": {
    "foo": "bar"
  }
}
```
##### parseYaml
* Подпись

parseYaml(string yaml) []Object
parseYamlобертки yaml.Unmarshalдля преобразования строки документов yaml в набор dicts. Если yamlсодержит только один документ, будет возвращен один массив значений.

* Примеры
```
{
  yaml: std.native('parseYaml')(|||
    ---
    foo: bar
    ---
    bar: baz
  |||),
}
```
Оценка с помощью Tanka приводит к JSON:
```
{
  "yaml": [
    {
      "foo": "bar"
    },
    {
      "bar": "baz"
    }
  ]
}
```

##### манифестJsonFromJson
* Подпись

manifestJsonFromJson(string json, int indent) string
manifestJsonFromJsonповторно сериализует JSON и позволяет изменить отступ.

* Примеры
```
{
  indentWithEightSpaces: std.native('manifestJsonFromJson')('{ "foo": { "bar": "baz" } }', 8),
}
```
Оценка с помощью Tanka приводит к JSON:
```
{
  "indentWithEightSpaces": "{\n        \"foo\": {\n                \"bar\": \"baz\"\n        }\n}\n"
}
```

##### манифестYamlFromJson
* Подпись

manifestYamlFromJson(string json) string
manifestYamlFromJsonсериализует строку JSON как документ YAML.

* Примеры
```
{
  yaml: std.native('manifestYamlFromJson')('{ "foo": { "bar": "baz" } }'),
}
```
Оценка с помощью Tanka приводит к JSON:
```
{
  "yaml": "foo:\n    bar: baz\n"
}
```

##### escapeStringRegex
* Подпись

escapeStringRegex(string s) string
escapeStringRegexэкранирует все метасимволы регулярного выражения и возвращает регулярное выражение, соответствующее буквальному тексту.

* Примеры
```
{
  escaped: std.native('escapeStringRegex')('"([0-9]+"'),
}
```
Оценка с помощью Tanka приводит к JSON:
```
{
  "escaped": "\"\\(\\[0-9\\]\\+\""
}
```

##### регулярное выражение

* Подпись

regexMatch(string regex, string s) boolean
regexMatchвозвращает, соответствует ли данная строка заданному регулярному выражению [RE2](https://github.com/google/re2/wiki/Syntax) .

* Примеры
```
{
  matched: std.native('regexMatch')('.', 'a'),
}
```
Оценка с помощью Tanka приводит к JSON:
```
{
  "matched": true
}
```
##### регулярное выражение Subst

* Подпись

regexSubst(string regex, string src, string repl) string
regexSubstзаменяет все совпадения регулярного выражения re2 строкой замены.

* Примеры
```
{
  substituted: std.native('regexSubst')('p[^m]*', 'pm', 'poe'),
}
```

Оценка с помощью Tanka приводит к JSON:
```
{
  "substituted": "poem"
}
```










####  XXX. Параметризация
Развертывание с помощью Tanka работало хорошо, но не особо улучшало ситуацию с точки зрения ремонтопригодности и читабельности.

Для этого в следующих разделах будут рассмотрены некоторые способы, которые предоставляет нам Jsonnet.

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
```js
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
