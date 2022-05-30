## Лекция по теме "Компоненты Kubernetes"


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

### 3Кластер

### 4Базовые понятия
● Кластер — группа компьютеров, объединённых
высокоскоростными каналами связи и представляющая
с точки зрения пользователя единый аппаратный ресурс.
● Масштабирование — способность системы, сети или процесса
справляться с увеличением рабочей нагрузки (увеличивать
свою производительность) при добавлении ресурсов (обычно
аппаратных).
● Kubernetes — ПО для оркестровки контейнеризированных
приложений — автоматизации их развёртывания,
масштабирования и координации в условиях кластера.
Master
Node
Node
Node



### 5Схема кластера
![intro_01](/12-kubernetes-01-intro/Files/intro_01.png)

### 6Детальная схема кластера

### 7apiserver



### 8Kube-apiserver
● Масштабируется;
● Имеет внешний http интерфейс;
● Взаимодействует с etcd.Kube-apiserveretcd

### 11etcdetcd
● Запущен везде;
● Kubernetes хранит в нём все данные;
● Требователен к диску и сети (без них может потерять
кворум).etcdetcd: изменения конфигурацииkube-scheduler

### 16kube-schedulerkube-schedulerkube-controller-manager

### 19kube-controller-manager: node controllerkube-controller-manager: replication
controllerkube-controller-manager: endpoints controllerkube-controller-manager: account & tokens
controller
● Отслеживает создание namespace;
● Создаёт новые стандартные аккаунты;
● Добавляет стандартные токены доступа к ним.kubelet

### 24kubelet
● Запущен на каждой ноде;
● Взаимодействует с apiserver и container runtime;
● Следит за контейнерами.kubelet
Node
kube-proxy
container runtime
kubelet
kube-apiserverkube-proxy
● Основное решение для взаимодействия компонентов
кластера;
● Проксирует запросы между нодами.kube-proxy
Node
Client
apiserver
clusterIP
(iptables)
Backend Pod 1
Labels: app = MyApp
Port: 9376
kube-proxy
Backend Pod 2
Labels: app = MyApp
Port: 9376
Backend Pod 3
Labels: app = MyApp
Port: 9376Container Runtime
● Реализация может быть любой:
docker, containerd, CRI-O;
● Обеспечивает совместимость сред.Container RuntimeИтоги
Сегодня мы изучили:
● Понятие кластера;
● Из каких компонентов состоит Kubernetes;
● Как устроены эти компоненты;
● Из чего состоят рабочие ноды.


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
