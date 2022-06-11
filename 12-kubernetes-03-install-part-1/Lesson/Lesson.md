## Ход выполнения ДЗ по теме "12.3 Развертывание кластера на собственных серверах, лекция 1"
Поработав с персональным кластером, можно заняться проектами. Вам пришла задача подготовить кластер под новый проект.

## Задание 1: Описать требования к кластеру
Сначала проекту необходимо определить требуемые ресурсы. Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

* База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
* Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

План расчета
1. Сначала сделайте расчет всех необходимых ресурсов.
2. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
3. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды.
4. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные.
5. Рассчитайте итоговые цифры.
6. В результате должно быть указано количество нод и их параметры.

**Ответ:**

1. Составим таблицу необходимых ресурсов

#### Известное кол-во ресурсов для одной копии каждой системы
Система|Кол-во копий|CPU, шт|ОЗУ, Гб|HDD, Гб
|-|-|-|-|-|
БД|3|6|12|60
Кеширование|3|9|12|X
Фронтенд|5|1|0.25|X
Бэкенд|10|10|6|X
**Итого**||40|40|X

2. Составим таблицу 



Полезные ссылки:
[Привет, Minikube](https://kubernetes.io/ru/docs/tutorials/hello-minikube/#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-minikube)

[Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

[Установка Minikube](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

[Установка Kubernetes с помощью Minikube](https://kubernetes.io/ru/docs/setup/learning-environment/minikube/)

[Установка и настройка kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)


[Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/)

[Азбука безопасности в Kubernetes: аутентификация, авторизация, аудит](https://habr.com/ru/company/flant/blog/468679/)

[Установка среды выполнения контейнера](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

[кри-докерд](https://github.com/Mirantis/cri-dockerd)

[Migrate Docker Engine nodes from dockershim to cri-dockerd](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/migrate-dockershim-dockerd/)

[CRI-O — альтернатива Docker для запуска контейнеров в Kubernetes](https://habr.com/ru/company/flant/blog/340010/)

[Использование авторизации RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#referring-to-resources)

[Как изменить пользователей в kubectl?](https://stackoverflow.com/questions/61462892/how-to-change-users-in-kubectl)

[Руководство по Kubernetes, часть 2: создание кластера и работа с ним](https://habr.com/ru/company/ruvds/blog/438984/)

## Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.


