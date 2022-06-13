# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes" - Захаров Сергей Николаевич

Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods


**Ответ:**

#### Запуск приложения
1. Находимся на ноде `minikube`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get nodes
NAME       STATUS   ROLES                  AGE     VERSION
minikube   Ready    control-plane,master   6d20h   v1.23.3
```
2. Создаем деплой командой `kubectl create deployment <app_name> --image=name_repo/name_image:tagged`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create deployment k8s-hello-world --namespace default --image=zakharovnpa/k8s-hello-world:05.06.22
deployment.apps/k8s-hello-world created
```
3. Деплой создан `k8s-hello-world`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
k8s-hello-world   1/1     1            1           18h
```
4. Один инстас приложения уже работает. Для масштабирования запускаем приложение командой `kubectl scale deployment k8s-hello-world --replicas=2`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=2
deployment.apps/k8s-hello-world scaled
```

5. Просмотр количества подов командой `kubectl get pods -l app=k8s-hello-world`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                               READY   STATUS             RESTARTS        AGE
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0               45h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0               14m
```


## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)

#### 1. Создание пользователей
1. Создаем пользователя на мастере, а затем переходим в его домашнюю директорию для выполнения остальных шагов:
```
useradd jean && cd /home/jean
```
#### 2. Создание токена / ключа / сертификата
1. Создаем закрытый ключ:
```
openssl genrsa -out jean.key 2048
```
2. Создаем запрос на подпись сертификата (certificate signing request, CSR). CN — имя пользователя, O — группа:
```
openssl req -new -key jean.key -out jean.csr -subj "/CN=jean"
```
3. Подписываем CSR в Kubernetes CA. Мы должны использовать сертификат CA и ключ, которые находятся в /home/maestro/.minikube. Сертификат будет действителен в течение 500 дней:
```
openssl x509 -req -in jean.csr \
-CA /etc/kubernetes/pki/ca.crt \
-CAkey /etc/kubernetes/pki/ca.key \
-CAcreateserial \
-out jean.crt -days 500
```

4. Создаем каталог .certs. В нем мы будем хранить открытый и закрытый ключи пользователя:
```
mkdir .certs && mv jean.crt jean.key .certs
```

#### 3. Создание пользователя внутри Minikube
1. Создаем пользователя внутри Minikube (добавляем пользователя в файл-конфиг minikube). Файл находится здесь: `/home/maestro/.kube/config`
```
kubectl config set-credentials jean \
--client-certificate=/home/jean/.certs/jean.crt \
--client-key=/home/jean/.certs/jean.key
```

2. Редактируем файл конфигурации пользователя. 
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: /home/maestro/.minikube/ca.crt
    server: https://192.168.59.100:8443
  name: minikube
contexts:
- context:
    cluster: kubernetes
    user: jean
  name: jean-context
current-context: jean-context
kind: Config
preferences: {}
users:
- name: jean
  user:
    client-certificate: /home/jean/.certs/jean.crt
    client-key: /home/jean/.certs/jean.key
```

3. Сделаем пользователя владельцем всех созданных файлов и каталогов:
```
chown -R jean: /home/jean/
```

4. Задаем контекст `jean-context` для пользователя в нашем кластере minikube:
```
kubectl config set-context jean-context --cluster=minikube --user=jean
```


#### 4. Создание пространств имен:

1. Создаем неймспейс
```
kubectl create namespace my-project-dev
kubectl create namespace my-project-prod
```

2. Поскольку мы пока не определили авторизацию пользователя, у него нет доступа к ресурсам кластера. Результат запроса от имени пользователя jean при правильных настройках пользователя:
```
sudo -u jean kubectl logs -l app=k8s-hello-world
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
sudo -u jean kubectl logs -l app=k8s-hello-world
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
sudo -u jean kubectl get pods
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
sudo -u jean kubectl get pods -n default
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```


#### 5. Создание ролей для пользователя
1. Создание Role и ClusterRole

Мы будем использовать ClusterRole, доступный по умолчанию. Впрочем, также покажем, как создавать свои Role и ClusterRole. 

* По сути Role и ClusterRole — это всего лишь набор действий (называемых как verbs, т.е. дословно — «глаголов»), разрешенных для определенных ресурсов и пространств имен. 

2. Смотрим какие API ресурсы нам доступны (вывод сокращен, показано только ресурсы для ролей):

```
kubectl api-resources
NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io/v1           true         RoleBinding
roles                                          rbac.authorization.k8s.io/v1           true         Role
```

#### 6. Привязка Role или ClusterRole к пользователю

1. RoleBinding'и нужно задавать по пространствам имен, а не по пользователям. Другими словами, для авторизации jean мы создадим RoleBinding. 
2. Мы разрешаем jean просматривать (view) неймспейс default и привяжем ClusterRole view к нашему пользователю
4. Создаем файл:

```yml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jean
  namespace: default
subjects:
- kind: User
  name: jean
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
```
5. Активируем привязку ролей:
```
kubectl apply -f /home/jean/jean-rolebinding.yml
rolebinding.rbac.authorization.k8s.io/jean created
```
* В данном случае была использована `kubectl apply` вместо `kubectl create`. Разница между ними в том, что create создает объект и больше ничего не делает, а apply — не только создает объект (в случае, если его не существует), но и обновляет при необходимости.


#### 7. Проверка получения пользователем нужных разрешений
1. Проверим, получили ли наш пользователь jean нужные разрешения.
* Было:
```
sudo -u jean kubectl get pods
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
* Стало:
```
sudo -u jean kubectl get pods
NAME                               READY   STATUS             RESTARTS          AGE
hello-node-8657b68576-b5s8h        0/1     CrashLoopBackOff   961 (4m56s ago)   6d
hello-world-2-7d8857465b-8bssw     0/1     ImagePullBackOff   0                 5d15h
hello-world-3-5df85bbcc9-9g2mq     0/1     ImagePullBackOff   0                 5d15h
hello-world-4-c485f65f-2wqgn       1/1     Running            0                 3d16h
hello-world-4-c485f65f-f4wsb       1/1     Running            0                 3d16h
hello-world-4-c485f65f-hpdhw       1/1     Running            0                 3d14h
hello-world-4-c485f65f-kcgpz       1/1     Running            0                 3d14h
hello-world-4-c485f65f-mq7p2       1/1     Running            0                 3d14h
hello-world-9b56d5d7-69ch2         0/1     ImagePullBackOff   0                 6d
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0                 5d10h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0                 3d13h

```
3. Просмотр логов пользователем jean:
```
sudo -u jean kubectl logs -l app=k8s-hello-world
Получен запрос на URL: /
Получен запрос на URL: /
Получен запрос на URL: /favicon.ico
Получен запрос на URL: /

```
4. Просмотр описания пода
```
sudo -u jean kubectl describe pods k8s-hello-world
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

Name:         k8s-hello-world-6969845fcf-tbtzv
Namespace:    default
Priority:     0
Node:         minikube/192.168.59.100
Start Time:   Tue, 07 Jun 2022 19:52:55 +0400
Labels:       app=k8s-hello-world
              pod-template-hash=6969845fcf
Annotations:  <none>
Status:       Running
IP:           172.17.0.14
IPs:
  IP:           172.17.0.14
Controlled By:  ReplicaSet/k8s-hello-world-6969845fcf
Containers:
  k8s-hello-world:
    Container ID:   docker://a38c7a1a1a3f94b86190b8c2a13b5428a5c38f63de293f533a6921ec1d9cd6a3
    Image:          zakharovnpa/k8s-hello-world:05.06.22
    Image ID:       docker-pullable://zakharovnpa/k8s-hello-world@sha256:1ea8575845aa74617f31afd497856fc2b12e6f0fe21c002638e67e02ac089d0a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 07 Jun 2022 19:52:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vcdtv (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-vcdtv:
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
```
5. Попытка создания нового пода пользователем jean приводит к ошибке., т.к. разрешения на это у него нет:
```
sudo -u jean kubectl create deployment 2-k8s-hello-world --image=zakharovnpa/k8s-hello-world:05.06.22
error: failed to create deployment: deployments.apps is forbidden: User "jean" cannot create resource "deployments" in API group "apps" in the namespace "default"
```
#### 8. Таблица возможностей пользователя jean
```
sudo -u jean kubectl auth can-i --list
[sudo] пароль для maestro: 
Resources                                       Non-Resource URLs   Resource Names   Verbs
selfsubjectaccessreviews.authorization.k8s.io   []                  []               [create]
selfsubjectrulesreviews.authorization.k8s.io    []                  []               [create]
bindings                                        []                  []               [get list watch]
configmaps                                      []                  []               [get list watch]
endpoints                                       []                  []               [get list watch]
events                                          []                  []               [get list watch]
limitranges                                     []                  []               [get list watch]
namespaces/status                               []                  []               [get list watch]
namespaces                                      []                  []               [get list watch]
persistentvolumeclaims/status                   []                  []               [get list watch]
persistentvolumeclaims                          []                  []               [get list watch]
pods/log                                        []                  []               [get list watch]
pods/status                                     []                  []               [get list watch]
pods                                            []                  []               [get list watch]
replicationcontrollers/scale                    []                  []               [get list watch]
replicationcontrollers/status                   []                  []               [get list watch]
replicationcontrollers                          []                  []               [get list watch]
resourcequotas/status                           []                  []               [get list watch]
resourcequotas                                  []                  []               [get list watch]
serviceaccounts                                 []                  []               [get list watch]
services/status                                 []                  []               [get list watch]
services                                        []                  []               [get list watch]
controllerrevisions.apps                        []                  []               [get list watch]
daemonsets.apps/status                          []                  []               [get list watch]
daemonsets.apps                                 []                  []               [get list watch]
deployments.apps/scale                          []                  []               [get list watch]
deployments.apps/status                         []                  []               [get list watch]
deployments.apps                                []                  []               [get list watch]
replicasets.apps/scale                          []                  []               [get list watch]
replicasets.apps/status                         []                  []               [get list watch]
replicasets.apps                                []                  []               [get list watch]
statefulsets.apps/scale                         []                  []               [get list watch]
statefulsets.apps/status                        []                  []               [get list watch]
statefulsets.apps                               []                  []               [get list watch]
horizontalpodautoscalers.autoscaling/status     []                  []               [get list watch]
horizontalpodautoscalers.autoscaling            []                  []               [get list watch]
cronjobs.batch/status                           []                  []               [get list watch]
cronjobs.batch                                  []                  []               [get list watch]
jobs.batch/status                               []                  []               [get list watch]
jobs.batch                                      []                  []               [get list watch]
endpointslices.discovery.k8s.io                 []                  []               [get list watch]
daemonsets.extensions/status                    []                  []               [get list watch]
daemonsets.extensions                           []                  []               [get list watch]
deployments.extensions/scale                    []                  []               [get list watch]
deployments.extensions/status                   []                  []               [get list watch]
deployments.extensions                          []                  []               [get list watch]
ingresses.extensions/status                     []                  []               [get list watch]
ingresses.extensions                            []                  []               [get list watch]
networkpolicies.extensions                      []                  []               [get list watch]
replicasets.extensions/scale                    []                  []               [get list watch]
replicasets.extensions/status                   []                  []               [get list watch]
replicasets.extensions                          []                  []               [get list watch]
replicationcontrollers.extensions/scale         []                  []               [get list watch]
ingresses.networking.k8s.io/status              []                  []               [get list watch]
ingresses.networking.k8s.io                     []                  []               [get list watch]
networkpolicies.networking.k8s.io               []                  []               [get list watch]
poddisruptionbudgets.policy/status              []                  []               [get list watch]
poddisruptionbudgets.policy                     []                  []               [get list watch]
                                                [/api/*]            []               [get]
                                                [/api]              []               [get]
                                                [/apis/*]           []               [get]
                                                [/apis]             []               [get]
                                                [/healthz]          []               [get]
                                                [/healthz]          []               [get]
                                                [/livez]            []               [get]
                                                [/livez]            []               [get]
                                                [/openapi/*]        []               [get]
                                                [/openapi]          []               [get]
                                                [/readyz]           []               [get]
                                                [/readyz]           []               [get]
                                                [/version/]         []               [get]
                                                [/version/]         []               [get]
                                                [/version]          []               [get]
                                                [/version]          []               [get]

```

#### 9. Примеры создания роли пользователя только для чтоения логов пода:

```
kubectl create clusterrole pod-logs --verb=get,list,watch --resource=pods/log
```



## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

**Ответ:**

1. Один инстас приложения уже работает. Для масштабирования запускаем приложение командой `kubectl scale deployment k8s-hello-world --replicas=2`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=2
deployment.apps/k8s-hello-world scaled
```

2. Просмотр количества подов командой `kubectl get pods -l app=k8s-hello-world`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                               READY   STATUS             RESTARTS        AGE
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0               45h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0               14m
```
3. Масштабируем приложение до 5 инстансов
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=5
deployment.apps/k8s-hello-world scaled
```
4. Работает 5 экземпляров приложения
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods -l app=k8s-hello-world
NAME                               READY   STATUS    RESTARTS   AGE
k8s-hello-world-6969845fcf-4lp47   1/1     Running   0          5s
k8s-hello-world-6969845fcf-5v7xk   1/1     Running   0          5d11h
k8s-hello-world-6969845fcf-bv6kp   1/1     Running   0          5s
k8s-hello-world-6969845fcf-lwncw   1/1     Running   0          5s
k8s-hello-world-6969845fcf-tbtzv   1/1     Running   0          3d14h
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
