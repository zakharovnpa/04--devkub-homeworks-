## Лекция по теме "Контейнеры, поды, deployment, statefulset, services, endpoints"

Андрей
Копылов

### 1Андрей Копылов
TechLead
PremiumBonus

### 2План занятия
1. Компоненты
2. Pods
3. Deployments
4. Statefulset
5. Services
6. Endpoints
7. Итоги
8. Домашнее задание

### 3Основные компоненты:
- pods — минимальная единица развертывания;
- deployments — масштабирование;
- statefulsets — масштабирование для состояний;
- services — внешняя точка доступа;
- endpoints — точки соединения подов и сервисов.

### 4Pods

### 5Возможности:
- запускает несколько контейнеров;
- все контейнеры внутри видят друг друга как localhost;
- файловая система у всех разная;
- запускаются одновременно.

### 6Init-контейнеры:
- запускаются последовательно;
- запускаются перед основными контейнерами;
- могут шарить общие тома с контейнерами;
- требуются для начальной настройки.

### 7Сеть в поде:
- для всех контейнеров внутри один ip;
- контейнеры могут открыть порты наружу;
- обращение по сокетам не будет работать без томов.

### 8Тома для пода:
- внутри можно создать общую папку или другой том;
- тома могут быть временными или постоянными
(PersistentVolumeClaim).

### 9Проверка на работоспособность:
- есть liveness и readiness probes;
- liveness нужна для проверки работы и перезапуска в
случае проблем;
- readiness нужны для ожидания запуска перед
обслуживанием трафика;
- все пробы запускаются с какой-либо периодичностью
всё время.

### 10Deployments

### 11Возможности:
- следит за количеством и статусом запущенных подов;
- позволяет масштабировать приложение;
- хранит шаблон конфигурации пода и позволяет
обновлять его;
- работает поверх replicaset.

### 12Схема компонентов
![shems_01](/13-kubernetes-config-01-objects/Files/shems_01.png)

### 13Statefulset

### 14Возможности:
- также следит за подами;
- не переносит упавший под на другую ноду;
- обычно служит для запуска stateful-приложений (база
данных, например).

### 15Схема компонентов
![shems_02](/13-kubernetes-config-01-objects/Files/shems_02.png)

### 16Services

### 17Возможности:
- служит для маршрутизации приложения;
- можно обратиться с любой ноды;
- выбирает поды для связки по меткам и селекторам;
- имеет свой IP-адрес (и dns-имя).

### 18Схема компонентов
![shems_03](/13-kubernetes-config-01-objects/Files/shems_03.png)

### 19Endpoints

### 20Возможности:
- объединяет поды по селекторам;
- можно создать вручную;
- позволяет направлять трафик наружу из кластера.

### 21Схема компонентов
![shems_04](/13-kubernetes-config-01-objects/Files/shems_04.png)

### 22Итоги
Сегодня мы изучили:
- что такое pods, deployments, statefulset, services, endpoints;
- зачем нужен каждый элемент;
- отдельные особенности каждого элемента.

### 23Домашнее задание
Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера
Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.


### 24Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов