## Лекция по теме "Компоненты Kubernetes"

https://github.com/aak74/kubernetes-for-beginners

https://github.com/aak74/kubernetes-for-beginners

Андрей
Копылов
1Андрей Копылов
TechLead
PremiumBonus
Андрей Копылов

### 2План занятия
1. Кластер
2. apiserver
3. etcd
4. kube-scheduler
5. kube-controller-manager
6. kubelet
7. Итоги
8. Домашнее задание

Сегодня мы изучим:
- Понятие кластера;
- Из каких компонентов состоит Kubernetes;
- Как устроены эти компоненты;
- Из чего состоят рабочие ноды.


### 3Кластер

### 4Базовые понятия
- Кластер — группа компьютеров, объединённых
высокоскоростными каналами связи и представляющая
с точки зрения пользователя единый аппаратный ресурс.
- Масштабирование — способность системы, сети или процесса
справляться с увеличением рабочей нагрузки (увеличивать
свою производительность) при добавлении ресурсов (обычно
аппаратных).
- Kubernetes — ПО для оркестровки контейнеризированных
приложений — автоматизации их развёртывания,
масштабирования и координации в условиях кластера.


### 5Схема кластера
![intro_01](/12-kubernetes-01-intro/Files/intro_01.png)

### 6Детальная схема кластера

![intro_02](/12-kubernetes-01-intro/Files/intro_02.png)

### 7apiserver

### 8Kube-apiserver
- Масштабируется;
- Имеет внешний http интерфейс;
- Взаимодействует с etcd.

### 9Kube-apiserver
Все компоненты общаются только через kube-apiserver

![intro_03](/12-kubernetes-01-intro/Files/intro_03.png)

### 10etcd

### 11etcd
Распределенная БД

![intro_04](/12-kubernetes-01-intro/Files/intro_04.png)

### 12etcd
- Запущен везде;
- Kubernetes хранит в нём все данные;
- Требователен к диску и сети (без них может потерять кворум).

### 13etcd


![intro_05](/12-kubernetes-01-intro/Files/intro_05.png)

### 14etcd: изменения конфигурации

![intro_06](/12-kubernetes-01-intro/Files/intro_06.png)

### 15kube-scheduler

### 16kube-scheduler

![intro_07](/12-kubernetes-01-intro/Files/intro_07.png)

### 17kube-scheduler

![intro_08](/12-kubernetes-01-intro/Files/intro_08.png)


### 18kube-controller-manager

### 19kube-controller-manager: node controller

![intro_09](/12-kubernetes-01-intro/Files/intro_09.png)

### 20kube-controller-manager: replication controller

![intro_10](/12-kubernetes-01-intro/Files/intro_10.png)

### 21kube-controller-manager: endpoints controller

![intro_11](/12-kubernetes-01-intro/Files/intro_11.png)

### 22kube-controller-manager: account & tokens controller
- Отслеживает создание namespace;
- Создаёт новые стандартные аккаунты;
- Добавляет стандартные токены доступа к ним.

### 23kubelet

### 24kubelet
- Запущен на каждой ноде;
- Взаимодействует с apiserver и container runtime;
- Следит за контейнерами.


### 25kubelet
Node
kube-proxy
container runtime
kubelet
kube-apiserver

![intro_12](/12-kubernetes-01-intro/Files/intro_12.png)

### 26kube-proxy
- Основное решение для взаимодействия компонентов кластера;
- Проксирует запросы между нодами.
- 

### 27kube-proxy

![intro_13](/12-kubernetes-01-intro/Files/intro_13.png)


### 28Container Runtime
- Реализация может быть любой: docker, containerd, CRI-O;
- Обеспечивает совместимость сред.

### 29Container Runtime

![intro_14](/12-kubernetes-01-intro/Files/intro_14.png)

### 30Итоги
Сегодня мы изучили:
- Понятие кластера;
- Из каких компонентов состоит Kubernetes;
- Как устроены эти компоненты;
- Из чего состоят рабочие ноды.


### 31Домашнее задание
Давайте посмотрим ваше домашнее задание.
● Вопросы по домашней работе задавайте в чате мессенджера
Slack.
● Задачи можно сдавать по частям.
● Зачёт по домашней работе проставляется после того, как приняты
все задачи.
32Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
