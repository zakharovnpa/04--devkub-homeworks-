## Команды управления кластером Kubernetes при выполнении ДЗ по теме "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

###  Подключение к БД
1. Подключаемся к поду `db-0` с запущенной БД 
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
```
2. Внутри пода (и контейнера тоже) с БД подключаемся к самой БД. 
  * Имя БД - "news". `-d news`
  * Указываем в качестве хоста имя сервиса "db-svc" `-h db-svc`
  * Указывать сокет "10.233.90.1:5432" не нужно
  * Пользователь postgres `-U postgres`
```
db-0:/# psql -h db-svc 10.233.90.1:5432 -U postgres -d news
psql: warning: extra command-line argument "10.233.90.1:5432" ignored
Password for user postgres: 
psql (13.7)
Type "help" for help.

news=#
```
