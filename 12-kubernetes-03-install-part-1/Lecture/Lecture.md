## Лекция по теме "Развертывание кластера на собственных серверах. Часть 1"

Андрей
Копылов

### 1Андрей Копылов
TechLead
PremiumBonus
Андрей КопыловПлан занятия
1. Требования к серверам
2. Установка Control Plane
3. Установка рабочей ноды
4. Итоги
5. Домашнее задание

### 3Требования к серверам

### 4Требования для Control Plane
- CPU — от 2 ядер
- ОЗУ — от 2 ГБ
- Диск — от 50 ГБ

### 5Требования для рабочей ноды
- CPU — от 1 ядра
- ОЗУ — от 1 ГБ
- Диск — от 100 ГБ

### 6Установка Control Plane

### 7Установка зависимостей
```
- apt install apt-transport-https ca-certiﬁcates curl

- sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
https://packages.cloud.google.com/apt/doc/apt-key.gpg

- echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee \
/etc/apt/sources.list.d/kubernetes.list

- apt install kubelet kubeadm kubectl containerd
```

### 8Инициализация кластера
```
- kubeadm init
 --apiserver-advertise-address=192.168.7.4 — этот адрес слушает apiserver
 --control-plane-endpoint=master-1.k8s.lan — адрес для будущих подключений control plane
 --pod-network-cidr 10.244.0.0/16 — сеть для подов укажем сразу
``` 
 
### 9Установка рабочей ноды

### 10Установка зависимостей
```
- apt install apt-transport-https ca-certiﬁcates curl
- sudo curl -fsSLo \
/usr/share/keyrings/kubernetes-archive-keyring.gpg \
https://packages.cloud.google.com/apt/doc/apt-key.gpg

- echo "deb \
[signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee \
/etc/apt/sources.list.d/kubernetes.list

- apt install kubelet kubeadm kubectl
```

### 11Подключение к кластеру
```
- kubeadm join
- --token <token> — токен нам скажет мастер
- master-1.k8s.lan:6443
- --discovery-token-ca-cert-hash sha256:<hash> — как и весь хеш
```
Полную команду для подключения выдает мастер после
инициализации.

  
### 12Проверка статуса кластера
```
- kubectl get nodes — покажет все ноды кластера;
- kubectl get pods — покажет поды в default namespace.
```

### 13Итоги
Сегодня мы изучили:
- Требования к серверам кластера;
- Зависимости kubernetes;
- Установку кластера вручную.

### 14Домашнее задание
Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера
Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 15Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
16
