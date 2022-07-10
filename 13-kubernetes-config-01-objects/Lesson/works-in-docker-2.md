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
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```
### 2. Запуск сборки образов и запуска контейнеров

[Логи этапа сборки контейнеров](/13-kubernetes-config-01-objects/Logs/log-docker-compose-build.md)
