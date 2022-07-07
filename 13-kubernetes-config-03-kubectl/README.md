
# Домашнее задание к занятию "13.3 работа с kubectl" - Захаров Сергей Николаевич
## Задание 1: проверить работоспособность каждого компонента
Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:
* сделайте запросы к бекенду;
* сделайте запросы к фронту;
* подключитесь к базе данных.
### Ответ:

#### 1. запросы к бекенду

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get all -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
pod/db-0                      1/1     Running   0          4h30m   10.233.90.1   node1   <none>           <none>
pod/fb-pod-65b9777746-b2sl2   2/2     Running   0          174m    10.233.96.3   node2   <none>           <none>

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
service/db           NodePort    10.233.2.152    <none>        5432:32602/TCP   177m   app=db
service/fb-pod       NodePort    10.233.54.126   <none>        80:30080/TCP     98m    app=fb-pod
service/kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          5h     <none>

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS         IMAGES                                                               SELECTOR
deployment.apps/fb-pod   1/1     1            1           4h21m   frontend,backend   zakharovnpa/k8s-frontend:05.07.22,zakharovnpa/k8s-backend:05.07.22   app=fb-app

NAME                                DESIRED   CURRENT   READY   AGE     CONTAINERS         IMAGES                                                               SELECTOR
replicaset.apps/fb-pod-65b9777746   1         1         1       4h21m   frontend,backend   zakharovnpa/k8s-frontend:05.07.22,zakharovnpa/k8s-backend:05.07.22   app=fb-app,pod-template-hash=65b9777746

NAME                  READY   AGE     CONTAINERS   IMAGES
statefulset.apps/db   1/1     4h30m   db           zakharovnpa/k8s-database:05.07.22

```
#### 2. Запросы к фронту

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   437k      0 --:--:-- --:--:-- --:--:--  437k
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
#### 3. запросы к бэкенду

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1:9000
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    22  100    22    0     0  11000      0 --:--:-- --:--:-- --:--:-- 11000
{"detail":"Not Found"}

```

#### 4. Запросы к базе данных
1. Запрос из приложения бэкенд
```
root@fb-pod-65b9777746-54942:/app# curl db:5432
curl: (52) Empty reply from server
```
2. Запроссы к БД с приложения PostgresSQL
```
db-0:/# psql -h db -U postgres -d news
Password for user postgres: 
psql (13.7)
Type "help" for help.

news=# 
news=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

news=# 
news=# \c news
You are now connected to database "news" as user "postgres".
news=# 
news=# \conninfo
You are connected to database "news" as user "postgres" on host "db" (address "10.233.2.152") at port "5432".
news=# 
```

## Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

### Ответ:

* После автоскейлинга до 3 реплик поды деплоя оказались на рзличных нодах
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl scale --replicas=3 deployment fb-pod 
deployment.apps/fb-pod scaled
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          5h7m
fb-pod-65b9777746-54942   2/2     Running   0          5s
fb-pod-65b9777746-b2sl2   2/2     Running   0          3h31m
fb-pod-65b9777746-w7pmd   2/2     Running   0          5s
```
* На какие ноды попали новые поды
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE    IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          6h6m   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-54942   2/2     Running   0          59m    10.233.90.3   node1   <none>           <none>
fb-pod-65b9777746-jm7r4   2/2     Running   0          5s     10.233.96.6   node2   <none>           <none>
fb-pod-65b9777746-mzcsg   2/2     Running   0          5s     10.233.96.5   node2   <none>           <none>
```
* После автоскейлинга до 1 реплики поды всех приложений оказались на node1
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          6h11m   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-54942   2/2     Running   0          64m     10.233.90.3   node1   <none>           <none>

```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
