## Лекция по теме "Команды для работы с Kubernetes"

Андрей
Копылов
1Андрей Копылов
TechLead
PremiumBonus
Андрей Копылов

### План занятия
1. Команда kubeadm
2. Команда kubectl
3. Итоги
4. Домашнее задание

### 3Главные команды
- kubeadm — серверная команда для настройки и управления кластером;
- kubectl — команда для управления отдельными ресурсами в рамках неймспейса или кластера.

### 4Команда kubeadm

### 5kubeadm init
Инициализация кластера
Полезные флаги:
* --apiserver-advertise-address — этот адрес будет слушать apiserver;
* --apiserver-bind-port — этот порт будет слушать apiserver;
* --control-plane-endpoint — потребуется для других мастеров;
* --cri-socket — сокет ContainerRuntime, по умолчанию ищет сам;
* --node-name — название ноды;
* --service-cidr — диапазон адресов для Сервисов.
* 
### 6kubeadm join
Служит для подключения к существующему кластеру

Полезные флаги:
* --control-plane — флаг указывает, что эта нода станет мастером;
* --token — токен от мастера для подключения;
* + все прошлые.

### 7kubeadm token

Управление токенами для подключения к кластеру
Полезные команды:
* create — создать новый токен;
* list — просмотр существующих токенов;
* delete — удаление токена.

### 8kubeadm conﬁg
Служит для просмотра конфигов инициализации кластера
Полезные команды:
* print init-defaults — просмотр конфига инициализации;
* images list — получение списка служебных конфигов;
* migrate — обновление конфигурации до новой версии.

### 9kubeadm upgrade
Удобная обёртка для обновления ноды кластера
Полезные команды:
* plan — проверяет доступные обновления;
* apply — применяет обновление на кластер;
* node — обновление отдельной ноды.

### 10kubeadm reset
**Сбрасывает конфиги на сервере до изначальных**
Помогает при ошибках конфигурирования и позволяет
начать всё сначала.

### 11kubeadm version
Просто выводит версию kubeadm в консоль :)
Полезна при установке и обновлении — уточняет версию, с
которой надо обновляться.

### 12Команда kubectl

### 13kubectl get
Получение списка ресурсов определённого типа
Полезные флаги:
* --all-namespaces — выводит ресурс из всех NS;
* --selector — применяется для фильтрации;
* --output — полезно при сохранении ресурса в файл
(например, для бекапа).

### 14kubectl describe
Получение детальной информации об объекте в кластере
Полезные флаги:
* --show-events — можно скрыть список событий.

### 15kubectl exec
ыполнение команды в контейнере отдельного пода
Полезные флаги:
* -с, --container — выбор отдельного контейнера в поде;
* -t, --tty — направляет ввод через терминал;
* -i, --stdin — позволяет направить stdin в контейнер.

### 16kubectl edit
Изменение ресурса напрямую в кластере. Вызовет
системный консольный редактор
Полезные флаги:
* --validate — позволяет отключить проверку конфига.

### 17kubectl logs
Получение логов от ресурса или конкретного контейнера
в поде
Полезные флаги:
* --all-containers — получение логов от всех контейнеров в поде сразу;
* -f, --follow — позволяет следить за логами в реальном времени.

### 18kubectl apply / delete
Создание и удаление ресурсов. Обычно применяются с файлами
Полезные флаги:
* -f — указывается файл с ресурсами для применения;
* --grace-period — можно задать таймаут для действия.

### 19kubectl cordon / uncordon / drain / taint
Манипуляции с нодами. Исключение ноды из планирования,
возврат в планировщик и установка режима обслуживания
Полезные флаги:
* --ignore-daemosets(drain) — игнорирует поды демонов,
позволяя им оставаться и работать на ноде.
* -- taint - добавляет запах, признак кноде, чтобы на нее могли присоединяться конкретные поды, или не присоединяться если у них нет соотв. толеранотности.

### 20kubectl port-forward      -00:21:17
Проксирование трафика до выбранного ресурса
Полезные флаги:
* --address — можно указать, какой адрес должен слушать
локально.

Если kubctl установлен на локальной машине то с помощью этой команды можно сделать прокси до нашего кубернетиса,
который может быть недоступен извне и отправлять запросы с нашему поду.

### 21kubectl label, kubectl annotate      -00:22:33
Управление метками и аннотациями ресурсов
Полезные флаги:
* list — вместо изменения выводит список текущих меток/аннотаций для ресурса.

На основе label можно делать фильтрацию. Можно сделать фильтр моего какого-то ресурса. 
Annotate - это для создания аннотации для ресурса и может использоваться как признак для какого-то действия.

### 22kubectl conﬁg     -00:24:27
Управление локальным конфиг-файлом
Полезные команды:
- current-context — получение текущего кластера/пользователя для команд;
- get-contexts — вывод списка доступных контекстов;
- use-context — изменение текущего контекста на указанный.

Это файл в котором описаны контексты, пользователи, файлы. И этот контекст можно переулючать и выбрать тот контекст который нужен сейчас.

### 23Kubernetes Dashboard      -00:25:30
![commands_01](/12-kubernetes-02-commands/Files/commands_01.png)

Позволяет видеть ресурсы кластера. Но некоторые вещи можно быстрее сделат и посмотреть с kubectl.
Есть другой ресурс - lens/Он ставится на нашу машину и является аналогом дашборда кубера. Там можно переключаться между контекстами.
* k9s - консольная утилита для тех же задач. Он использует UI.

### 24Итоги
Сегодня мы изучили:
- команду kubeadm;
- команду kubectl.
И узнали про:
- kubernetes dashboard.

### Практическая часть лекции   -00:29:05

Подготовка соего ПК:
1. Создана директория для учебных целей `/root/learning-kubernetis`
2. Склонирован в нее репозиторий от преподавателя: https://github.com/aak74/kubernetes-for-beginners
3. Запущен PyCharm от root и открыть проект `kubernetes-for-beginners`

#### -00:31:24 - О команде cubectl
![cubectl-command_01](/12-kubernetes-02-commands/Files/cubectl-command_01.png)
* Команды слева - относятся к управлению нодами
* Команды справа - команды для управления, не относятся к управлению нод.
* Команды  врамочках - для управлению нодами в том числе

![cubeadm-command_01](/12-kubernetes-02-commands/Files/cubeadm-command_01.png)

#### -00:34:20 kubectl get

#### -00:37:25 k9s
![k9s_01](/12-kubernetes-02-commands/Files/k9s_01.png)
Выход из него: `:q`
Редактировать с помощью этой утилиты тоже можно.

#### -00:39:20 kubectl get pods -l app=event-processing
#### -00:40:10 kubectl logs
#### -00:40:50 kubectl delete
#### -00:41:20 watch 'kubectl pods'
#### -00:48:15 kubectl describe
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl describe node minikube
Name:               minikube
Roles:              control-plane,master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=minikube
                    kubernetes.io/os=linux
                    minikube.k8s.io/commit=362d5fdc0a3dbee389b3d3f1034e8023e72bd3a7
                    minikube.k8s.io/name=minikube
                    minikube.k8s.io/primary=true
                    minikube.k8s.io/updated_at=2022_05_31T23_23_39_0700
                    minikube.k8s.io/version=v1.25.2
                    node-role.kubernetes.io/control-plane=
                    node-role.kubernetes.io/master=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 31 May 2022 23:23:35 +0400
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  minikube
  AcquireTime:     <unset>
  RenewTime:       Tue, 07 Jun 2022 17:17:47 +0400
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Tue, 07 Jun 2022 17:13:37 +0400   Tue, 07 Jun 2022 11:03:07 +0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Tue, 07 Jun 2022 17:13:37 +0400   Tue, 07 Jun 2022 11:03:07 +0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Tue, 07 Jun 2022 17:13:37 +0400   Tue, 07 Jun 2022 11:03:07 +0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Tue, 07 Jun 2022 17:13:37 +0400   Tue, 07 Jun 2022 11:03:07 +0400   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.59.100
  Hostname:    minikube
Capacity:
  cpu:                2
  ephemeral-storage:  17784752Ki
  hugepages-2Mi:      0
  memory:             3834736Ki
  pods:               110
Allocatable:
  cpu:                2
  ephemeral-storage:  17784752Ki
  hugepages-2Mi:      0
  memory:             3834736Ki
  pods:               110
System Info:
  Machine ID:                 50272951ed9f4553a467aee05fec17fc
  System UUID:                ccfe3129-fd18-bf4a-a51e-1f6fb9b59e87
  Boot ID:                    f2c8cf75-9b8a-4dd0-b805-1e61a9ddfadf
  Kernel Version:             4.19.202
  OS Image:                   Buildroot 2021.02.4
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://20.10.12
  Kubelet Version:            v1.23.3
  Kube-Proxy Version:         v1.23.3
PodCIDR:                      10.244.0.0/24
PodCIDRs:                     10.244.0.0/24
Non-terminated Pods:          (16 in total)
  Namespace                   Name                                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                         ------------  ----------  ---------------  -------------  ---
  default                     hello-node-8657b68576-b5s8h                  0 (0%)        0 (0%)      0 (0%)           0 (0%)         2d7h
  default                     hello-world-2-7d8857465b-8bssw               0 (0%)        0 (0%)      0 (0%)           0 (0%)         47h
  default                     hello-world-3-5df85bbcc9-9g2mq               0 (0%)        0 (0%)      0 (0%)           0 (0%)         46h
  default                     hello-world-4-85c647846-2485t                0 (0%)        0 (0%)      0 (0%)           0 (0%)         46h
  default                     hello-world-9b56d5d7-69ch2                   0 (0%)        0 (0%)      0 (0%)           0 (0%)         2d7h
  default                     k8s-hello-world-6969845fcf-5v7xk             0 (0%)        0 (0%)      0 (0%)           0 (0%)         42h
  ingress-nginx               ingress-nginx-controller-cc8496874-xgfnk     100m (5%)     0 (0%)      90Mi (2%)        0 (0%)         3d19h
  kube-system                 coredns-64897985d-wfr44                      100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     6d17h
  kube-system                 etcd-minikube                                100m (5%)     0 (0%)      100Mi (2%)       0 (0%)         6d17h
  kube-system                 kube-apiserver-minikube                      250m (12%)    0 (0%)      0 (0%)           0 (0%)         6d17h
  kube-system                 kube-controller-manager-minikube             200m (10%)    0 (0%)      0 (0%)           0 (0%)         6d17h
  kube-system                 kube-proxy-lqzfd                             0 (0%)        0 (0%)      0 (0%)           0 (0%)         6d17h
  kube-system                 kube-scheduler-minikube                      100m (5%)     0 (0%)      0 (0%)           0 (0%)         6d17h
  kube-system                 storage-provisioner                          0 (0%)        0 (0%)      0 (0%)           0 (0%)         6d17h
  kubernetes-dashboard        dashboard-metrics-scraper-58549894f-dtk44    0 (0%)        0 (0%)      0 (0%)           0 (0%)         3d19h
  kubernetes-dashboard        kubernetes-dashboard-ccd587f44-nr7vc         0 (0%)        0 (0%)      0 (0%)           0 (0%)         3d19h
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                850m (42%)  0 (0%)
  memory             260Mi (6%)  170Mi (4%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:              <none>
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl describe pods k8s-hello-world-6969845fcf-5v7xk
Name:         k8s-hello-world-6969845fcf-5v7xk
Namespace:    default
Priority:     0
Node:         minikube/192.168.59.100
Start Time:   Sun, 05 Jun 2022 23:02:45 +0400
Labels:       app=k8s-hello-world
              pod-template-hash=6969845fcf
Annotations:  <none>
Status:       Running
IP:           172.17.0.11
IPs:
  IP:           172.17.0.11
Controlled By:  ReplicaSet/k8s-hello-world-6969845fcf
Containers:
  k8s-hello-world:
    Container ID:   docker://5caeb85ded09def5d031af16b4bee41e51da22b0b948ed15846cee0551453725
    Image:          zakharovnpa/k8s-hello-world:05.06.22
    Image ID:       docker-pullable://zakharovnpa/k8s-hello-world@sha256:1ea8575845aa74617f31afd497856fc2b12e6f0fe21c002638e67e02ac089d0a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 05 Jun 2022 23:02:50 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-l5jdn (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-l5jdn:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/Рабочий стол$ 

```
#### -00:49:40 kubectl get -o yaml / json
#### -00:53:20 kubectl logs -f -c
#### -00:55:20 watch 'kubectl get pods -l app'
#### -01:00:10 kubectl taint node master  node-role.kubernetes.io/master
Для того, чтобы на ноде появилась рабочая нагрузка

#### -01:05:00 kubectl edit deploy main - для входа в режим редактирования деплоя
```

```


#### -01:07:00 kubectl scale deployment main --replicas=2 - позволяет масштабировать кол-во запущенных контейнеров



#### -01:09:55 kubectl apply
#### -01:11:30 kubectl drain
#### -01:13:00 про taint, tolerante 
#### -01:14:40 kubectl port-forward
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl port-forward k8s-hello-world-6969845fcf-5v7xk 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080

```
- kubectl port-forward можно прокинуть не только до пода, но и до деплоя и до сервиса.
- kubectl expouse создаст сервис, на который можно будет обращаться.
- kubectl port-forward  - он делает трафик доступным через kube-api-server

#### -01:21:30 kubectl get svc
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get svc -n default -o wide
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
k8s-hello-world   LoadBalancer   10.100.178.38   <pending>     8080:32429/TCP   14h     app=k8s-hello-world
kubernetes        ClusterIP      10.96.0.1       <none>        443/TCP          6d20h   <none>
```

#### -01:23:30 kubectl config get-context
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl config get-contexts
CURRENT   NAME       CLUSTER    AUTHINFO   NAMESPACE
*         minikube   minikube   minikube   default
```

#### -01:24:20 kubectl --context=prod get nodes
#### -01:25:54 kubectl config use-context=prod

#### -01:27:00 kubectl uncordon node01
#### -01:28:30 kubectl create deployment   -  можно использовать в ДЗ
#### -01:28:50 watch 'kubectl get pods -n default
#### -01:28:50 kubectl create deployment nginx --namespace default image=nginx
#### -01:30:20 kubectl delete deployments.apps -n default nginx
#### -01:31:00 kubeadm


-01:32:40 - рекомендация устанавливать kubectl на локальный ПК. Устанавливать его надо под обычным пользователем.
-01:34:20 - рекомендация устанавливать `bash complition` - автодополнение команд


### 25Домашнее задание    -01:35:55

-01:37:20 - пояснение по Заданию №3. Надо сделать все наоборот. Надо изменить кол-во реплик на 5 команда `kubectl edit` или `kubectl scale`. Проверить что их стало 5 вместо двух первоначальных. Команда `kubectl get pods`

-01:38:00 - по Заданию №2. Сложное задание. Самое интересное и исследовательское. Выполнив это задание мы будем готовы делать много других вещей.  Нужо сначала завести пользователя кубера. Поптом предоставить доступа. ИЛи. Не создавать пользователя, а создать сервис-аккаунт и для этого сервис-аккаунта предоставить какой-то набор прав с тем чтобы плзователи имели доступ. Подскахки: RBAC, ServiceAccounte, Role, RoleBinding.

Итого:
- Нужно завести пользователя кубернетис (можно глянуть в интернете или в чатике)
- потом дать права доступа пользователю.

- Создать сервис-акаунт
- Сервис-аккаунту предоставить права доступа
- Подсказки: RBAC, ServiceAccounte, Role, RoleBinding.
- Подсказка: `kubectl create clasterrole readonlyuser`


- Ответ должен выгледеть так:
  - Каким образом мы создаем пользователя или Сервисеаккаунт (какие команды)
  - Продемонстрировать с помощью команд кубконфиг, блок юзерс. там должен быть пользователь. Показать, что  пользователя что он не может создать намеспейс,
но может посмотреть логи, дескрайб. А другие команды ползователь не может выполнить.
  - Продемонстрировать что этот пользователь другие команды не может выполнить.
- Подсказка: `kubectl create clasterrole readonlyuser`


Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера
Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 26Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
27
