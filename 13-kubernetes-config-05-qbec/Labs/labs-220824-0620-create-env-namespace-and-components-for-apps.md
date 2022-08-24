## ЛР-220824-0620. Подготовка к выполнению ДЗ. Технология проектирования приложения. Разделение на компоненты. Проектирование сред для различных целей.

- [ЛР-220824-0620. Подготовка к выполнению ДЗ. Технология проектирования приложения. Разделение на компоненты. Проектирование сред для различных целей.](/13-kubernetes-config-05-qbec/Labs/labs-220824-0620-create-env-namespace-and-components-for-apps.md)

### Технология проектирования приложения. 

### Разделение на компоненты. 
1. Для каждой env определить:
  - в каком namespace будет работать
  - какие приложения будут развернуты
2. Начать с описания каждой env

#### Env base.

#### Env default.

#### Env stage. 
Включает в себя:
  - Deployment, состоящий из двух приложений - frontend и backend.
  - Service NodePort для подключения извне, 
  - Service EndPoint для подключения к внутренней БД
  - StatefulSet для создания внутренней БД 
  - ReplicaSet


#### Env prod
Включает в себя:
  - StatefulSet для frontend
  - StatefulSet для backend
  - Service, включающий в себя NodePort для подключения извне, EndPoint для подключения к внутренней БД
  - StatefulSet для внешней БД 
  - ReplicaSet


### Создание бибилотек.

### Проектирование сред для различных целей.

### Включение и исключение компонентов для различных сред.

### Проектирование файлов jsonnet для генерации манифестов
#### Составные части манифестов
#### Части манифестов, передаваемые в библиотеки.
#### Написание функций для генерации манифестов
#### Изменение параметров в средах, отличных от базовой

* [Использование qbec.io/env](https://qbec.io/userguide/usage/runtime-params/#using-qbecioenv)
```
local env = std.extVar('qbec.io/env'); // get the value of the environment

// define baseline parameters
local baseParams = {
    components: {
        service1: {
            replicas: 1,
        },
    },
};

// define parameters per environment
local paramsByEnv = {

    _: baseParams, // the baseline environment used by qbec for some commands

    dev: baseParams {
        components+: {
            service1+: {
                replicas: 2,
            },
        },
    },

    prod: baseParams {
        components+: {
            service1+: {
                replicas: 3,
            },
        },
    },
};

// return value for correct environment
if std.objectHas(paramsByEnv, env) then paramsByEnv[env] else error 'environment ' + env ' not defined in ' + std.thisFile
 
```
* [Использование внешних переменных jsonnet](https://qbec.io/userguide/usage/runtime-params/#using-jsonnet-external-variables)

```
spec:
    vars:
      external:
        - name: service1_image_tag
          default: latest

        - name: service1_secret
          default: changeme # fake value
          secret: true # qbec debug logs will not print this value in cleartext
```
атем вы можете использовать их в своих компонентах или объекте конфигурации параметров времени выполнения, например:

    local imageTag = std.extVar('service1_image_tag');
    
и укажите реальные значения в командной строке qbec:

    export service1_secret=XXX
    qbec apply dev --vm:ext-str service1_image_tag=1.0.3 --vm:ext-str service1_secret

Обратите внимание, что мы явно устанавливаем для тега изображения значение 1.0.3, но не указываем значение секрета в командной строке. Это заставляет qbec установить секретное значение из переменной среды с тем же именем. Это предпочтительный метод передачи секретов.
