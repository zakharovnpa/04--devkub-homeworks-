## Ход выполнения ДЗ по теме "12.5 Сетевые решения CNI"

После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

### Подготовка к решению.

Условие:
 - сейчас установен Flannel
 - надо установить Calico, т.к. у него есть больше возможностей
 - Calico по умолчанию устанавливается с помощью Kubespray
 - необходимо настроить политику безопасности (политику доступа) к какому-то нашему приложению "hello-world"
 - приложение можно брать любое, можно взять multitool 
 - доступ нужно обеспечить "из вне", т.е. на уровне межподового взаимодействия
 - продемонстрировать как что-то работает согласно задания
 - продемонстрировать как что-то не работает там где нужны ограничения доступа (согласно задания)

1. Установить в кластер приложение hello-world
2. Предостаить к нему доступ извне

### Ход решения.

##### Подготовка кластера к выполнению ДЗ
1. Создан кластер на ЯО:
  1. 1 управляющая нода cp1
  2. 2 рабочие ноды node1, node2
```
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm6kdtgn7a54j3gmfbe | node1 | ru-central1-a | RUNNING | 51.250.86.192 | 10.128.0.34 |
| fhmpr3ehr27lhjbngras | node2 | ru-central1-a | RUNNING | 51.250.91.26  | 10.128.0.17 |
| fhmtrqairbmsnvmuolat | cp1   | ru-central1-a | RUNNING | 51.250.95.178 | 10.128.0.33 |
+----------------------+-------+---------------+---------+---------------+-------------+

```
2. Установлен CNI Flanel
3. На каждой ноде работает kube-proxy, iptables
4. 

#### Установка Calico 

#### Развертывание приложений Frontend, Backend, Cash
1. Подготовка манифестов для создания деплойментов
* Manifest Frontend
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: frontend
  name: frontend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:                  # Описание пода
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: frontend
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: frontend


```

* Manifest Backend
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: backend
  name: backend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:                  # Описание пода
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: backend

```

* Manifest Cash
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: cache
  name: cache
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cache
  template:
    metadata:
      labels:
        app: cache
    spec:                  # Описание пода
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: cache
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: cache

```
2. Развертывание 

Для начала необходимо развернуть объекты из подготовленных манифестов.
```shell script
# Развертывание
kubectl apply -f ./templates/main/

# Проверка созданных подов
kubectl get po
``` 
1. Проверка подов в неймспейс default
```
maestro@PC-Ubuntu:~$ kubectl get ns
NAME              STATUS   AGE
default           Active   20h
kube-node-lease   Active   20h
kube-public       Active   20h
kube-system       Active   20h
```
* Подов никаких нет в неймспейс default
```
maestro@PC-Ubuntu:~$ kubectl -n default get po
No resources found in default namespace.
```
* Если поды есть, то очищаем ноду от ранее созданных деплойментов
```
kubectl -n default delete deployment --all
```

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

Поясненеи:
  - после установки calicoctl сделать get параметров
  - приложить вывод из консоли или скриншот
  
  
### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
