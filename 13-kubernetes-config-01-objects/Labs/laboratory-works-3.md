## 11.07.2022 Ход работ по ДЗ "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

### Задачи:
1. В Яндекс.Облаке развернуть три ВМ для  cp1, node1, node2 кластера Kubernetes
2. На node2 развернуть в Docker-compose контейнер с БД PostgresSQL
3. На нодах cp1, node1 развернуть кластер Kubernetes
4. В кластере Kubernetes развернуть приложения Frontend, Backend 
5. Связать приложение Backend с БД, расположенной на node2. Проверить доступность
  * Вручную добавить переменную окружения для доступа к БД
6. Связать приложение Frontend с Backend. Проверить доступность
  * Вручную добавить переменную окружения для доступа к Backend
7. Предоставить доступ к Frontend из Интерента для доступа ко всем приложениям
  * Добавить сервис типа NodePort
8. Проверить функционал работы приложений
  * В БД должны записыватья скрипты
  * Логи подключений
  * Скриншоты страницы

### Задачи дополнительные
1. Пересобрать образы приложений Frontend, Backend так, чтобы переменные окружения были добавлены в новый образ

### Ход выполнения

#### 1. Создаем три ВМ в Яндекс.Облаке

```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Betta# ./list-vms.sh 
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhmaq5hlg9qcnpmttkiq | node2 | ru-central1-a | RUNNING | 51.250.85.102 | 10.128.0.14 |
| fhmgerac9egp1jn3bnia | cp1   | ru-central1-a | RUNNING | 51.250.6.237  | 10.128.0.28 |
| fhmr7602g266r06jg0s8 | node1 | ru-central1-a | RUNNING | 51.250.92.215 | 10.128.0.16 |
+----------------------+-------+---------------+---------+---------------+-------------+
```
#### 2. Установка Kubernetes
1. В файлах Kuberspray `hosts.yaml`, `k8s-claster.yaml` добавляем ip адреса нод cp1 и node1
2. Запускаем установку кластера 
`ansible-playbook -i inventory/netology-test-cl2/hosts.yaml  --become --become-user=root cluster.yml`



#### 3. Устанавливаем на ноде node2 Docker, Docker-Compose
1. Устанавливаем Docker
```
apt install docker.io
```
2. Устанавливаем Docker-Compose
```
curl -L https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose && chmod +x /usr/bin/docker-compose
```
3. Результат
```
root@node2:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
```
root@node2:~# type docker
docker is hashed (/usr/bin/docker)
```
```
root@node2:~# type docker-compose
docker-compose is /usr/bin/docker-compose
```

#### 4. Разворачиваем в Docker-Compose приложение для БД Postgres SQL
1. Создаем файл ` vim docker-compose.yaml`
```yml
version: "3.7"

services:
  db:
    image: zakharovnpa/k8s-database:05.07.22
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```
2. Запускаем сборку образа и развертывание приложения в контейнере
```
docker-compose up --build
```
3. Проверяем доступность приложения с ноды cp1, node1
```
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhmaq5hlg9qcnpmttkiq | node2 | ru-central1-a | RUNNING | 51.250.85.102 | 10.128.0.14 |
+----------------------+-------+---------------+---------+---------------+-------------+
```
* Внутренний адрес node2 с cp1 доступен
```
yc-user@cp1:~$ ping 10.128.0.14
PING 10.128.0.14 (10.128.0.14) 56(84) bytes of data.
64 bytes from 10.128.0.14: icmp_seq=1 ttl=63 time=1.31 ms
64 bytes from 10.128.0.14: icmp_seq=2 ttl=63 time=0.500 ms
^C
--- 10.128.0.14 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 0.500/0.903/1.307/0.403 ms
```
* Порт 5432 приложения БД с ноды cp1 доступно.
```
yc-user@cp1:~$ curl 10.128.0.14:5432
curl: (52) Empty reply from server
```
##### Решено: разворачивание в Docker-Compose приложение для БД Postgres SQL выполнено

#### 5. Разворачивание а кластере Kubernetes приложений Frontend, Backend 
