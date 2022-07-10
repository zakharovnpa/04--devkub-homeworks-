## 10.07.2022 Ход работ по развертыванию БД PostgresSQL

### 1. Файл, на оснве которого создается 3 ВМ

```
version: "3.7"

services:
  frontend:
    image: zakharovnpa/k8s-frontend:05.07.22
    ports:
      - 8000:80

  backend:
    image: zakharovnpa/k8s-backend:05.07.22
    links:
      - db
    ports:
      - 9000:9000

  db:
    image: zakharovnpa/k8s-database:05.07.22
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```
### 2. Запуск сборки образов и запуска контейнеров

* Команда запуска `docker-compose up --build`

[Логи этапа сборки контейнеров](/13-kubernetes-config-01-objects/Logs/log-docker-compose-build.md)

### 3. Результат установки прилжений

```
yc-user@node3:~$ sudo -i
root@node3:~# 
root@node3:~# docker image list
REPOSITORY                 TAG        IMAGE ID       CREATED       SIZE
zakharovnpa/k8s-backend    05.07.22   bf58e470d5a5   5 days ago    1.07GB
zakharovnpa/k8s-frontend   05.07.22   5438a0c5806b   5 days ago    142MB
zakharovnpa/k8s-database   05.07.22   2bb8cea1e0bb   2 weeks ago   213MB
```
```
root@node3:~# docker ps
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS          PORTS                                       NAMES
3e7faf67720a   zakharovnpa/k8s-backend:05.07.22    "/bin/sh -c 'pipenv …"   28 minutes ago   Up 28 minutes   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp   root-backend-1
a80122aaeb28   zakharovnpa/k8s-database:05.07.22   "docker-entrypoint.s…"   28 minutes ago   Up 28 minutes   5432/tcp                                    root-db-1
db5a8e295fb6   zakharovnpa/k8s-frontend:05.07.22   "/docker-entrypoint.…"   28 minutes ago   Up 28 minutes   0.0.0.0:8000->80/tcp, :::8000->80/tcp       root-frontend-1
```


### 4. Тестирование работы приложений

#### Нет доступности между нодами на порт с БД
```
yc-user@node4:~$ curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432: Connection refused

```


#### 4.1 В контейнере root-backend-1

* Входим в контейнер
```
root@node3:~# docker exec -it root-backend-1 bash
root@a16dfe14432d:/app# cd
root@a16dfe14432d:~# 
root@a16dfe14432d:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
19: eth0@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:12:00:04 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.4/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```
* curl на адрес самого себя и порт 9000
```
root@a16dfe14432d:~# curl a16dfe14432d:9000
{"detail":"Not Found"}
root@a16dfe14432d:~# curl localhost:9000
{"detail":"Not Found"}
```

#### 4.2 В ноде `node3` на которой запущен Docker-compose и контейнеры с приложениями.
* Сетевые настройки ноды `node3`
```
root@node3:~# ip a | grep eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 10.128.0.8/24 brd 10.128.0.255 scope global eth0
```
* Доступность из ноды порта контейнера `backand`
```
root@node3:~# curl 127.1:9000
{"detail":"Not Found"}
```
* Доступность из ноды порта контейнера `frontend`
```
root@node3:~# curl 127.1:8000
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>
```
* Доступность из ноды порта контейнера `backand`

```
root@node3:~# curl 127.1:5432
curl: (52) Empty reply from server
```

#### 4.3 В ноде `node4` на которой запущен Docker-compose и контейнеры с приложениями.

* Сетевые настройки ноды `node4`

```
yc-user@node4:~$ ip a | grep eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 10.128.0.38/24 brd 10.128.0.255 scope global eth0
```
* Доступность из ноды `node4` порта контейнера `backand`, расположенного в ноде `node3`
```
yc-user@node4:~$ curl 10.128.0.8:9000
{"detail":"Not Found"}
```
* Доступность из ноды `node4` порта контейнера `frontend`, расположенного в ноде `node3`
```
yc-user@node4:~$ curl 10.128.0.8:8000
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>
```
* Доступность из ноды `node4` порта контейнера `db`, расположенного в ноде `node3`. Порт недоступен, т.к. не открыть доступ извне в Docker-compose

```
yc-user@node4:~$ curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432: Connection refused
```


##### 4.3.1 Исправления
* Для окрытия порта 5432 для доступа к контейнеру с БД персобран `docker-compose-yaml`

```yml
  db:
    image: zakharovnpa/k8s-database:05.07.22
    ports:              # Добавлены настройки
      - 5432:5432       # Добавлены настройки
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```

* Результат: открыт на внешнй доступ порт 5432
```
root@node3:~# docker ps
CONTAINER ID   IMAGE                               COMMAND                  CREATED         STATUS         PORTS                                       NAMES
a16dfe14432d   zakharovnpa/k8s-backend:05.07.22    "/bin/sh -c 'pipenv …"   6 minutes ago   Up 6 minutes   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp   root-backend-1
f9e383c1b547   zakharovnpa/k8s-frontend:05.07.22   "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:8000->80/tcp, :::8000->80/tcp       root-frontend-1
d9dea443daf9   zakharovnpa/k8s-database:05.07.22   "docker-entrypoint.s…"   6 minutes ago   Up 6 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   root-db-1
```
* Проверка доступности из другой ноды `node4`

```
yc-user@node4:~$ curl 10.128.0.8:5432
curl: (52) Empty reply from server

```
