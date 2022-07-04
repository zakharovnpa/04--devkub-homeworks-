## Ход выполнения ДЗ по теме "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.


### В лекции по ДЗ      - 02:09:10

## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

#### Пояснение: 
  * приложения можно ставить и свои, но аналогичные
  * манифесты можно брать от преподавателя и создать то, что нам нужно

* Важно: 
  * конфиг для теста (задача 1) и для продакшена (задача 2) - разные 

* В тестовом конфиге в описании одного пода находятся два контейнера — фронтенд, бекенд;
* Надо сделать БД через statefulset.
* Пример направления трафика на внешнюю БД:
![pod-to-db](/13-kubernetes-config-01-objects/Files/pod-to-db.png)

* Что еще на описано но надо иметь ввиду:
  * фронтенд может обращаться к бэеэнду напрямую. Они в одном поде
  * Создать сервис для обращения к БД. Нам нужен сервис. Без него не сможем обратиться к БД.
  * мы сделали БД через statefulset
  * в описании пода указать метки (селекторы и т.д.)
  * селекторы мы должны указать в сервисе, который будет обращаться к подам

### Ход решения Задания 1

#### 1. Созданы образы для запуска контейнеров
* Процесс создания описан здесь: [Ход создания образов приложений Frontend, Backand, DataBase](/13-kubernetes-config-01-objects/Lesson/build-docker-compose-images.md)
* Приготовленные образы размещаем на Dockerhub
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker push zakharovnpa/k8s-frontend:05.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-frontend]
352d627bd336: Pushed 
a5b05b1f6d07: Pushed 
cf2af7b6ae79: Pushed 
649f9ccbcc97: Pushed 
e7344f8a29a3: Mounted from library/nginx 
44193d3f4ea2: Mounted from library/nginx 
41451f050aa8: Mounted from library/nginx 
b2f82de68e0d: Mounted from library/nginx 
d5b40e80384b: Mounted from library/nginx 
08249ce7456a: Mounted from library/nginx 
05.07.22: digest: sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a size: 2401
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker push zakharovnpa/k8s-backend:05.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-backend]
59283fad6e30: Pushed 
c4bf1e206190: Pushed 
fbd3193641ee: Pushed 
de4ab17faf49: Pushed 
a4023f1effb2: Pushed 
843f990feb92: Mounted from library/python 
70dce5ebf427: Mounted from library/python 
aba5ac262080: Mounted from library/python 
2df8715307ad: Mounted from library/python 
e6fd4ebbaaab: Mounted from library/python 
261e5d6450d3: Mounted from library/python 
65d22717bade: Mounted from library/python 
3abde9518332: Mounted from library/python 
0c8724a82628: Mounted from library/python 
05.07.22: digest: sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f size: 3264
```
#### 2. Создаем план развертывания приложений в кластере.
* Количество нод - не оговаривается, но возьмем две ноды
* В первом поде содержатся контейнеры:
  * Frontend
  * Backend
  >  Будем делать первый Deploy, в котором описано создание Frontend и Backend в одном поде
* Во втором поде содержится:
  *  БД
  >  Будем делать первый Statefulset, в котором описано создание БД в одном отдельном поде
* Необходимо создать сервис для обращения к БД
  * селекторы мы должны указать в сервисе, который будет обращаться к подам

#### 3. Создаем манифесты для разворачивания приложений
1. Deployment для Frontend и Backend

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: froontend
  name: froontend
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: froontend
  template:
    metadata:
      labels:
        app: froontend
    spec:
      containers:
      - image: nginx:1.20
        imagePullPolicy: IfNotPresent
        name: nginx
      - image: praqma/network-multitool:alpine-extra
        imagePullPolicy: IfNotPresent
        name: multitool
        env:
          - name: HTTP_PORT
            value: "8080"
```






## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

#### Пояснение     -01:12:35
  * Сервисы для каждого компонента свой отдельный
  * в окружении фронта (Environment) нужно  прописан адрес сервиса бекенда 
  * в окружении бекенда прописан адрес сервиса базы данных.
  * БД запускать не в Кубере, а отдельно.

## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).

#### Пояснение:
* 

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают.

---
