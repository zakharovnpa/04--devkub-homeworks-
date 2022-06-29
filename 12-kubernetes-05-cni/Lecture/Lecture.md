## Лекция по теме "Сетевые решения CNI"

Андрей
Копылов

### 1Андрей Копылов
TechLead
PremiumBonus

### 2План занятия
1. CNI
2. Плагины
3. Итоги
4. Домашнее задание

### 3Container Network Interface
- Стандарт сетевого взаимодействия контейнеров;
- Состоит из спецификации и примеров библиотек.

### 4Зачем CNI?
- заменяемость решений;
- гибкость реализации;
- масштабируемость;
- содержит минимально необходимую спецификацию.

### 5Компоненты CNI
![cni-components](/12-kubernetes-05-cni/Files/cni-components.png)

### 6Адрес контейнера
![address-conteiner](/12-kubernetes-05-cni/Files/address-conteiner.png)

### 7Сеть в кластере
![network-claster](/12-kubernetes-05-cni/Files/network-claster.png)

### 8Готовые плагины

### 9Flannel
- минимальный бинарник;
- хранит конфиги в etcd;
- работает на 3 уровне OSI.

### 10Weave Net
- поддерживает dns-запросы;
- поддерживает изоляцию сетей (например, по
namespace);
- поддерживает политики безопасности.

### 11Calico
- скорость работы;
- поддержка политик безопасности;
- гибкая настройка политик.

### 12AWS / GCE / etc
- большинство облачных провайдеров имеют свою
реализацию;
- необходимо для поддержки фичей облаков;
- можно использовать с другими решениями
(ﬂannel/calico).

## Практическая часть лекции     - 00:36:40
- 00:36:50 - показан файл /etc/kubernetes/manifest/kube-controller-manager.yml
- показаны настройки claster-cidr=10.244.0.0/16
- 00:40:50 - kube-sheduller.yml
- 00:41:55 - подсети для нод, настройки интерфейса
- 00:42:55  -kubectl get pods -o wide -A | grep node1
Видно, что адрес сети для всех контейнеров пода одинаковый
- 00:46:10 - kube-proxy по умолчению на ноде создает правила iptables
- 00:47:50 - про кол-во подов в ноде. Натсраивается в куберспрее
- 00:40:10 - о плагинах и что они делают
- 00:50:10 - настройки iptables на нодах. iptables -vnL | less
- 00:51:35 - iptables -t nat -vnL | less
- 00:51:35 - на ноде смотрим роуты `route -n`
- 00:56:00 - показаны роуты с calico
### Про плагины       - 01:05:30
- Если для нашей сети кластера нужно что-то особенное, то надо выбрать правильный плагин
### Бонусный материал   NetworkPolicy   - 00:06:50
- Объект NetworkPolicy служит для разграничения доступа между подами.
- Для исследования работы принципов Network Policy рекомендую использовать ящик с инструментами [Network-MultiTool](https://github.com/Praqma/Network-MultiTool).
- Docker-образы из этого репозитория содержит все необходимые для этого инструменты.
- 01:10:30 - пример сетевой политики

## Настройка NetworkPolicy
Вот пример желаемого поведения:
![network-poplicy](/12-kubernetes-05-cni/Files/network-poplicy.png)
В нашем приложении реализовано 3 сервиса:
- frontend; 
- backend; 
- cache.

Откуда берутся данные в cache оставим за скобками данного упражнения.
 
Выглядит разумным обеспечить доступ:
- frontend -> backend;
- backend -> cache.

Остальные возможные взаимодействия должны быть запрещены. 
- 01:12:35 
- Проверка доступности между подами с flannel
Сначала развертываем в кластере с установленным CNI плагином flannel.
В этом плагине не реализована работа с NetworkPolicy. 
Поэтому указание NetworkPolicy никак не повлияет на сетевую доступность между подами.

Выдвинем две гипотезы:
1. Без настройки NetworkPolicy все поды будут доступны между собой.
1. После настройки NetworkPolicy все поды будут все еще доступны между собой.

### Развертывание   - 01:13:46 - 
Для начала необходимо развернуть объекты из подготовленных манифестов.
```shell script
# Развертывание
kubectl apply -f ./templates/main/
```
- манифест выглядит так:
/root/learning-kubernetis/kubernetes-for-beginners/16-networking/20-network-policy/templates/main/10-frontend.yml

```yml
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
    spec:
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
- 00:14:20 - проверка существующих подов в неймспейс default `kubectl -n default get po`
- 00:14:40 - очищаем ноду от ранее созданных деплойментов `kubectl -n default delete deployment --all`
- 01:15:05 - `kubectl apply -f ./templates/main/` и результат применения манифеста (перед этим был очищены от подов неймспейс)
- Создаются три новые поды (фронтэнд, бэкэнд, кэш)
- 00:15:20 - фронтэнд, бэкэнд, кэш созданы из одного и тогоже образа. Они абсолютно одинаковые контенеры.

### Проверка созданных подов
kubectl get po

### Проверка доступности между подами
```shell script
kubectl exec backend-7b4877445f-kgvnr -- curl -s -m 1 frontend
kubectl exec backend-7b4877445f-kgvnr -- curl -s -m 1 cache
kubectl exec backend-7b4877445f-kgvnr -- curl -s -m 1 backend
```
В случае отсутствия запретов все поды будут доступны. 
Подобный эксперимент можно провести из любого из созданных подов.

- 00:16:00 - Гипотеза подтвердилась.

### Применение политик   - 01:18:20 
- Применение NetworkPolicy
```shell script
kubectl apply -f ./templates/network-policy

kubectl get networkpolicies
```
- 01:19:10- удаление нетворкполиси `kubectl delete networkpolicies --all`
- 01:19:40 - /root/learning-kubernetis/kubernetes-for-beginners/16-networking/20-network-policy/templates/network-policy/00-default.yaml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}   # Здесь описываем разрешающие правила
  policyTypes:
    - Ingress

```

### Проверка доступности между подами после применения NetworkPolicy    - 01:20:00
Выполняем те же самые команды. Результат ожидаемо такой же.
А именно все поды доступны со всех подов.

Вторая гипотеза тоже подтвердилась.

- Из этого можно сделать вывод, что Flanel сетевые политики не поддерживает и для работы NetworkPolicy необходим CNI плагин с поддержкой NetworkPolicy.
  - Одним из таких плагинов является calico.
### Про Calico      - 01:21:00 - 
- Конфигурирование ./kube/config для создания новго контекста
- Нам нужен еще один кластер, на котором установлен Calico
- 01:21:55 
  - kubectl get networkpolicies
  - kubectl delete networkpolicies
- 01:22:40 - Устанавливаем в новом кластере поды: kubectl apply -f ./manifest/main

- 01:24:15 - применение политики по умоланию "все запрещено"
- Применим этот конфиг:
```shell script
kubectl apply -f templates/network-policy/00-default.yaml
```
- 00-default.yaml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
    - Ingress

```
- 01:25:45 - применяем политику согласно нашей предполгаемой схеме
- ### Применение NetworkPolicy
Применяем остальные наши сетевые политики. 
```shell script
kubectl apply -f templates/network-policy
```
* 10-default.yml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
    - Ingress
```
* 10-frontend.yml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: frontend
  policyTypes:
    - Ingress

```
* 20-backend.yaml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend
  namespace: default
spec:     # Описание политики
  podSelector:      # Выбираем по отношению к каклму поду применяется политика
    matchLabels:   # По совпадению 
      app: backend   # Политика распространяется на поды, имена app которых содержат  backend
  policyTypes:
    - Ingress       # Входящий тип сетевой политики
  ingress:    # Начинаем описывать политику входящую
    - from:        # Откуда будем разрешать принимать данные
      - podSelector:  # Фильтр, выбирающий данные из общего потока для пода, указанного в следующей строке
          matchLabels:  # Если совпадает с Labels, обозначенном в следующей строке
            app: frontend    # С пода, имя app которого содержит frontend
      ports:                 # для входящих портов backend. Перечислить столько сколько надо
        - protocol: TCP
          port: 80
        - protocol: TCP
          port: 443

```
- 01:25:55 - распространение сетевой политики на поды, указанные в `podSelector`
- 01:26:30 - какой тип политики `policyTypes`  Ingress - Входящий тип сетевой политики
- 01:28:00 - применение политики `20-backend.yaml`
- 01:30:25 - про сервис `ifconfig.me`
- 01:30:40 - про политику исходящуу `Egress`

* 99-egress.yml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
spec:
  podSelector: {}
  policyTypes:
    - Egress
```



* cashe.yml
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cache
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: cache
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: backend
      ports:
        - protocol: TCP
          port: 80
        - protocol: TCP
          port: 443
```

Теперь проверим доступность между подами по прежней схеме.

Будут доступны поды только по нашей схеме.
- frontend -> backend
- backend -> cache

Остальные варианты недоступны.

Вторая гипотеза подтвердилась полностью.

- 01:37:45 - удаление политики
- `kubectl delete -f templates/network-policy/00-default.yml`
- 01:38:50 - как сделать Egress доступный для Backend

* 99-egress-backend.yml Не факт, что работает.
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Egress
  egress:
    - to:
        podSelector:
          matchLabels:
            app: frontend
      ports:
       - protocol: TCP
         port: 80
       - protocol: TCP
         port: 443
      
```







## Выводы
Для обеспечения безопасной работы с сетью необходимо выполнить 2 пункта:
1. Использовать CNI плагин с поддержкой NetworkPolicy.
1. Необходимо правильно настроить NetworkPolicy.


### 13Итоги    - 01:48:00
Сегодня мы изучили:
- зачем нужен CNI и как он устроен;
- какие есть популярные реализации.

### 14Домашнее задание    - 01:49:00
Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера
Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 15Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
