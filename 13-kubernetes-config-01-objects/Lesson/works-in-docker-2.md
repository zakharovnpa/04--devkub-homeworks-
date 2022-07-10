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



### 5. Исправления
* Для окрытия порта 5432 для доступа к контейнеру с БД персобран docker-compose-yaml


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
