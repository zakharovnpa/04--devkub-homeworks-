## Лекция по теме "Развертывание кластера на собственных серверах - часть 2"

Андрей
Копылов
1Андрей Копылов
TechLead
PremiumBonus
Андрей Копылов
[1](https://github.com/kubernetes-sigs/kubespray)
[2](https://devops.stackexchange.com/questions/9483/how-can-i-add-an-additional-ip-hostname-to-my-kubernetes-certificate)

### 2План занятия
1. Требования к серверам
2. Ansible
3. Kubespray
4. Итоги
5. Домашнее задание

### 3Требования к серверам

### 4Требования для Control Plane (3 шт.)
- CPU — от 2 ядер
- ОЗУ — от 2 ГБ
- Диск — от 50 ГБ

### 5Требования для рабочих нод (5 шт.)
- CPU — от 1 ядра
- ОЗУ — от 1 ГБ
- Диск — от 100 ГБ

### 6Зависимости
- Системные:
apt-transport-https ca-certiﬁcates curl
- Новый репозиторий:
```
echo "deb
[signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg
] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee
/etc/apt/sources.list.d/kubernetes.list
```
- Системные для кубера:
```
kubelet kubeadm kubectl
```

### 7Зависимости в ansible
![install_01](/12-kubernetes-04-install-part-2/Files/install_01.png)

### 8Инициализация мастер ноды
![install_02](/12-kubernetes-04-install-part-2/Files/install_02.png)

### 9Подключение остальных мастеров
![install_03](/12-kubernetes-04-install-part-2/Files/install_03.png)

### 10Подключение рабочих нод
![install_04](/12-kubernetes-04-install-part-2/Files/install_04.png)

### 11Проверка работоспособности
- забрать конфиг с мастера
- kubectl get nodes

### 12Kubespray

### 13Что за “зверь”?
- Набор Ansible ролей для установки и конфигурации системы оркестрации контейнерами Kubernetes.
- В качестве IaaS в этом случае могут выступать AWS, GCE, Azure, OpenStack или обычные виртуальные машины.

### 14Пример настройки через kubespray
![install_05](/12-kubernetes-04-install-part-2/Files/install_05.png)

### 15Проверка статуса кластера
- kubectl get nodes — покажет все ноды кластера;
- kubectl get pods — покажет поды в default namespace.

### 16Полезный софт
- Ingress
- Kubernetes dashboard

![install_06](/12-kubernetes-04-install-part-2/Files/install_06.png)

### Практическая часть Лекии   -00:22:50


### 17Итоги
Сегодня мы изучили:
- Установку мастеров и рабочих нод через ansible;
- Возможности Kubespray.

### 18Домашнее задание      -01:37:30

- Папку с kubespray сохранить у себя и потом использовать
- Кластер можно использовать и на меньшее кол-во рабочих нод, а не как в задании.
- Немного усложним задание:
  - кластер должен быть доступен извне. Нужно чтобы кластер был не в локальной сети
В ответе прикладывать только те файлы, которые были изменены.
- Можно в Яндекс.Облаке запускать. 


Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты все задачи.


К домашке рикладывать испавленные файлы для проверки.

### 19Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
