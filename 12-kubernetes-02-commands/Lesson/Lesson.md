## Ход выполнения ДЗ к занятию "12.2 Команды для работы с Kubernetes"

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

**Ответ:**

#### API-объекты RBAC

Управление доступом на основе ролей (RBAC) — это метод регулирования доступа к компьютерам и сетевым ресурсам, опирающийся на роли отдельных пользователей в компании. 

RBAC можно использовать со всеми ресурсами Kubernetes, которые поддерживают CRUD (Create, Read, Update, Delete). Примеры таких ресурсов:
- пространства имен;
- Pod'ы;
- Deployment'ы;
- постоянные тома (PersistentVolumes);
- ConfigMap'ы.

#### А вот примеры возможных операций с ними:

- create (создание);
- get (получение);
- delete (удаление);
- list (просмотр списка);
- update (обновление).

##### Для управления RBAC в Kubernetes, нам необходимо объявить:
- Role и ClusterRole. Это просто наборы правил, представляющие набор разрешений. 
- Role может использоваться только для предоставления доступа к ресурсам внутри пространств имен. 
- ClusterRole может предоставлять те же разрешения, что и Role, а также давать доступ к ресурсам, доступных в пределах всего кластера, и так называемым нересурсным endpoint'ам (вроде /healthz — прим. перев.).
- Subjects. Subject (субъект) — это сущность, которая будет выполнять операции в кластере. Ей могут являться пользователи, сервисы или даже группы.
- RoleBinding и ClusterRoleBinding. Как следует из названия, это просто привязка субъекта к Role или ClusterRole.


#### В Kubernetes имеются следующие роли по умолчанию:

- view: доступ только для чтения, исключает секреты;
- edit: перечисленное выше + возможность редактировать большинство ресурсов, исключает роли и привязки ролей;
- admin: перечисленное выше + возможность управлять ролями и привязками ролей на уровне пространств имен;
- cluster-admin: все возможные привилегии.

#### Примечание: нашему пользователю необходимо выдать разрешения на:
- чтение конфигурации подов в app-namespace
- чтение логов подов в app-namespace
Следовательно необходимо выдать роль `view`

1. Создадим пространство имен `my-project-dev`
2. Создадим пользователя jean

#### Создание и аутентификация пользователей с помощью клиентских сертификатов X.509

Как правило, имеется два типа пользователей: учетные записи служб (service accounts), управляемые Kubernetes, и обычные пользователи. Мы сфокусируемся на последних. Вот как они описываются в официальной документации:

> Предполагается, что обычными пользователями управляет внешняя, независимая служба. В ее роли может выступать администратор, распределяющий закрытые ключи, хранилище пользователей вроде Keystone или Google Accounts, или даже файл со списком имен пользователей и паролей. В связи с этим в Kubernetes нет объектов, представляющих обычных пользователей. Обычных пользователей нельзя добавить в кластер через вызов API.

Существует несколько способов управления обычными пользователями:

- Базовая аутентификация (basic auth):
  - передача конфигурации API-серверу со следующим (или похожим) содержимым: password, username, uid, group;
- Клиентский сертификат X.509:
  - создание секретного ключа пользователя и запроса на подпись сертификата;
  - заверение его в центре сертификации (Kubernetes CA) для получения сертификата пользователя;
- Bearer-токены (JSON Web Tokens, JWT):
  - OpenID Connect;
  - слой аутентификации поверх OAuth 2.0;
  - веб-хуки (webhooks).

Мы будем использовать сертификаты X.509 и OpenSSL из-за их простоты. 
Создание пользователей проходит в несколько этапов — мы пройдем их все. Операции следует выполнять под учеткой пользователя с правами администратора кластера (cluster-admin). Вот все шаги по созданию пользователя (на примере jean):

* Создайте пользователя на мастере, а затем перейдите в его домашнюю директорию для выполнения остальных шагов:
```
useradd jean && cd /home/jean
```
* Создайте закрытый ключ:
```
openssl genrsa -out jean.key 2048
```
* Создайте запрос на подпись сертификата (certificate signing request, CSR). CN — имя пользователя, O — группа. Можно устанавливать разрешения по группам. Это упростит работу, если, например, у вас много пользователей с одинаковыми полномочиями:
```
# Без группы
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean"

# С группой под названием $group
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group"

# Если пользователь входит в несколько групп
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group1/O=$group2/O=$group3"
```

### Выполнение задания:

Выполняется по статье [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/)

#### 1. Создание пользователей
1. Создайте пользователя на мастере, а затем перейдите в его домашнюю директорию для выполнения остальных шагов:
```
useradd jean && cd /home/jean
```
* Создаем пользователя с домашним каталогом
```
root@PC-Ubuntu:/home# sudo useradd -m jean
root@PC-Ubuntu:/home# 
root@PC-Ubuntu:/home# ls -lha
итого 20K
drwxr-xr-x  5 root          root          4,0K июн  8 20:45 .
drwxr-xr-x 20 root          root          4,0K июн  4 09:13 ..
drwxr-xr-x  2 gitlab-runner gitlab-runner 4,0K мая 10 12:53 gitlab-runner
drwxr-xr-x  2 jean          jean          4,0K июн  8 20:45 jean
drwxr-xr-x 34 maestro       maestro       4,0K июн  8 20:37 maestro

```
* Переходим в домашний каталог
```
root@PC-Ubuntu:/home# cd jean/
root@PC-Ubuntu:/home/jean# pwd
/home/jean

```
#### 2. Создание токена / ключа / сертификата
1. Создаем закрытый ключ:
```
openssl genrsa -out jean.key 2048
```
```
root@PC-Ubuntu:/home/jean# openssl genrsa -out jean.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
....................+++++
.+++++
e is 65537 (0x010001)
```
* Результат:
```
root@PC-Ubuntu:/home/jean# ls -lha
-rw------- 1 root root 1,7K июн  8 20:51 jean.key

```

2. Создаем запрос на подпись сертификата (certificate signing request, CSR). CN — имя пользователя, O — группа. Можно устанавливать разрешения по группам. Это упростит работу, если, например, у нас много пользователей с одинаковыми полномочиями:
```
# Без группы
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean"
```
* Эти команды не вводились:
```
# С группой под названием $group
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group"

# Если пользователь входит в несколько групп
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group1/O=$group2/O=$group3"
```
* Результат:
```
root@PC-Ubuntu:/home/jean# ls -lha
-rw-r--r-- 1 root root  883 июн  8 20:53 jean.csr
-rw------- 1 root root 1,7K июн  8 20:51 jean.key
```
3. Подписываем CSR в Kubernetes CA. Мы должны использовать сертификат CA и ключ, которые обычно находятся в /etc/kubernetes/pki. Сертификат будет действителен в течение 500 дней:
* Пример:
```
openssl x509 -req -in jean.csr \
-CA /etc/kubernetes/pki/ca.crt \
-CAkey /etc/kubernetes/pki/ca.key \
-CAcreateserial \
-out jean.crt -days 500
```
* Результат после выполнения команды из примера выше:
```
root@PC-Ubuntu:/home/jean# openssl x509 -req -in jean.csr \
> -CA /etc/kubernetes/pki/ca.crt \
> -CAkey /etc/kubernetes/pki/ca.key \
> -CAcreateserial \
> -out jean.crt -days 500
Signature ok
subject=CN = jean
Can't open /etc/kubernetes/pki/ca.crt for reading, No such file or directory
139956666627392:error:02001002:system library:fopen:No such file or directory:../crypto/bio/bss_file.c:69:fopen('/etc/kubernetes/pki/ca.crt','r')
139956666627392:error:2006D080:BIO routines:BIO_new_file:no such file:../crypto/bio/bss_file.c:76:
unable to load certificate
```
4. Вышла ошибка доступа (неверно указано (дано для примера) расположение `ca.crt`, `ca.key`) 
* Изменяем директории с файлами `ca.crt`, `ca.key` на верные /home/maestro/.minikube/
```
root@PC-Ubuntu:/home/jean# openssl x509 -req -in jean.csr -CA /home/maestro/.minikube/ca.crt -CAkey /home/maestro/.minikube/ca.key -CAcreateserial -out jean.crt -days 500
Signature ok
subject=CN = jean
Getting CA Private Key
```
* Результат
```
root@PC-Ubuntu:/home/jean# ls -lha
-rw-r--r-- 1 root root  985 июн  8 21:03 jean.crt
-rw-r--r-- 1 root root  883 июн  8 20:53 jean.csr
-rw------- 1 root root 1,7K июн  8 20:51 jean.key
```


5. Создаем каталог .certs. В нем мы будем хранить открытый и закрытый ключи пользователя:
```
mkdir .certs && mv jean.crt jean.key .certs
```
* Результат
```
root@PC-Ubuntu:/home/jean# cd .certs/
root@PC-Ubuntu:/home/jean/.certs# 
root@PC-Ubuntu:/home/jean/.certs# ls -lha
итого 16K
drwxr-xr-x 2 root root 4,0K июн  8 21:06 .
drwxr-xr-x 3 jean jean 4,0K июн  8 21:06 ..
-rw-r--r-- 1 root root  985 июн  8 21:03 jean.crt
-rw------- 1 root root 1,7K июн  8 20:51 jean.key

```
#### 3. Создание пользователя внутри Minikube
1. Создаем пользователя внутри Minikube (добавляем пользователя в файл-конфиг minikube). Файл находится здесь: `/home/maestro/.kube/config`
```
kubectl config set-credentials jean \
--client-certificate=/home/jean/.certs/jean.crt \
--client-key=/home/jean/.certs/jean.key
```
* Результат:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl config set-credentials jean \
> --client-certificate=/home/jean/.certs/jean.crt \
> --client-key=/home/jean/.certs/jean.key
User "jean" set.

```

2. Задайте контекст `jean-context` для пользователя в нашем кластере minikube:
```
kubectl config set-context jean-context \
--cluster=kubernetes --user=jean
```
* Результат:
```
root@PC-Ubuntu:/home/jean# kubectl config set-context jean-context \
> --cluster=kubernetes --user=jean
Context "jean-context" created.

```

3. Отредактируем файл конфигурации пользователя. В нем содержится информация, необходимая для аутентификации в кластере. Можно воспользоваться файлом конфигурации кластера, который обычно лежит в /etc/kubernetes: переменные certificate-authority-data и server должны быть такими же, как в упомянутом файле:
```
apiVersion: v1
clusters:
- cluster:
  certificate-authority-data: {Сюда вставьте данные}
  server: {Сюда вставьте данные}
name: kubernetes
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
* Наш искомый файл лежит здесь: `/home/maestro/.kub/config`
```
root@PC-Ubuntu:/home/jean/.certs# cat /home/maestro/.kube/config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/maestro/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Sun, 05 Jun 2022 12:26:01 +04
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: cluster_info
    server: https://192.168.59.100:8443
  name: minikube
contexts:
- context:
    cluster: kubernetes
    user: jean
  name: jean-context
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sun, 05 Jun 2022 12:26:01 +04
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: jean
  user:
    client-certificate: /home/jean/.certs/jean.crt
    client-key: /home/jean/.certs/jean.key
- name: minikube
  user:
    client-certificate: /home/maestro/.minikube/profiles/minikube/client.crt
    client-key: /home/maestro/.minikube/profiles/minikube/client.key
```



4. Теперь нужно скопировать приведенный выше конфиг в каталог .kube в домашней папке пользователя jean:
```
mkdir .kub && vi .kub/config
```
5. Из этого файла-шаблона создаем новый конфиг:
```
apiVersion: v1
clusters:
- cluster:
  certificate-authority-data: {Сюда вставьте данные}
  server: {Сюда вставьте данные}
name: kubernetes
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
6. Редактируем его, дополняя данные
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

7. Осталось сделать пользователя владельцем всех созданных файлов и каталогов:
```
chown -R jean: /home/jean/
```
* Результат:
```
root@PC-Ubuntu:/home/jean# chown -R jean: /home/jean/
root@PC-Ubuntu:/home/jean# 
root@PC-Ubuntu:/home/jean# ls -lha
итого 32K
drwxr-xr-x 4 jean jean 4,0K июн 10 08:08 .
drwxr-xr-x 5 root root 4,0K июн  8 20:45 ..
-rw-r--r-- 1 jean jean  220 фев 25  2020 .bash_logout
-rw-r--r-- 1 jean jean 3,7K фев 25  2020 .bashrc
drwxr-xr-x 2 jean jean 4,0K июн  8 21:06 .certs
-rw-r--r-- 1 jean jean  883 июн  8 20:53 jean.csr
drwxr-xr-x 2 jean jean 4,0K июн 10 08:14 .kub
-rw-r--r-- 1 jean jean  807 фев 25  2020 .profile
```
8. На данном этапе запрос от ползовтеля jean:
```
root@PC-Ubuntu:/home/jean# kubectl get pods -n my-project-prod 
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```


##### 3.1 Пример ошибочного действия. Когда контекст нового пользователя был добавлен в другой кластер (kubernetes), которого у нас нет. Мы не могли выполнить действия от имени ного пользователя, т.к. не было доступа к файлу `/home/maestro/.minikube/profiles/minikube/client.key`. Выходила ошибка отклонения доступа. 

1. Также необходимо присвоить права пользователя jean файлу /home/maestro/.minikube/profiles/minikube/client.key
* Но при этом пропадает доступ у пользователя maestro
```
-rw------- 1 jean    jean    1,7K мая 31 23:23 client.key
```

2. Пользователь jean успешно создан. Запускать команды от имени jean:
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean whoami
jean

```

3. Делаем запрос от имени jean, а на самом деле от имени пользователя minikube (админа в кластере)
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl get pods -n default
[sudo] пароль для maestro: 
NAME                               READY   STATUS             RESTARTS        AGE
hello-node-8657b68576-b5s8h        0/1     CrashLoopBackOff   923 (31s ago)   5d13h
hello-world-2-7d8857465b-8bssw     0/1     ImagePullBackOff   0               5d4h
hello-world-3-5df85bbcc9-9g2mq     0/1     ImagePullBackOff   0               5d4h
hello-world-4-c485f65f-2wqgn       1/1     Running            0               3d5h
hello-world-4-c485f65f-f4wsb       1/1     Running            0               3d5h
hello-world-4-c485f65f-hpdhw       1/1     Running            0               3d3h
hello-world-4-c485f65f-kcgpz       1/1     Running            0               3d3h
hello-world-4-c485f65f-mq7p2       1/1     Running            0               3d3h
hello-world-9b56d5d7-69ch2         0/1     ImagePullBackOff   0               5d13h
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0               4d23h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0               3d2h
maestro@PC-Ubuntu:~/Рабочий стол$ 
maestro@PC-Ubuntu:~/Рабочий стол$ 
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl get pods -n my-project-prod
No resources found in my-project-prod namespace.
```

##### 3.2 Для правильного решения необходимо в конфиге пользователя указать наш кластер - minikube
1. Задаем контекст `jean-context` для пользователя в нашем кластере minikube:
```
kubectl config set-context jean-context \
--cluster=minikube --user=jean
```
* Результат:
```
root@PC-Ubuntu:/home/jean# kubectl config set-context jean-context \
> --cluster=minikube --user=jean
Context "jean-context" created.

```

#### 4. Создание пространств имен:

1. Создаем неймспейс
```
kubectl create namespace my-project-dev
kubectl create namespace my-project-prod
```
* Результат:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create namespace my-project-dev
namespace/my-project-dev created
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create namespace my-project-prod
namespace/my-project-prod created

```

2. Поскольку мы пока не определили авторизацию пользователей, у них не должно быть доступа к ресурсам кластера:


* Для пользователя jean
```
kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "jean" cannot list resource "nodes" in API group "" at the cluster scope
```
```
kubectl get pods -n default
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
kubectl get pods -n my-project-prod
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "my-project-prod"
```
```
kubectl get pods -n my-project-dev
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "my-project-dev"
```

* Для пользователя Sarah
```
kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "sarah" cannot list resource "nodes" in API group "" at the cluster scope
```
```
kubectl get pods -n default
Error from server (Forbidden): pods is forbidden: User "sarah" cannot list resource "pods" in API group "" in the namespace "default"
```
```
kubectl get pods -n my-project-prod
Error from server (Forbidden): pods is forbidden: User "sarah" cannot list resource "pods" in API group "" in the namespace "my-project-prod"
```
```
kubectl get pods -n my-project-dev
Error from server (Forbidden): pods is forbidden: User "sarah" cannot list resource "pods" in API group "" in the namespace "my-project-dev"
```

3. Результат запроса от имени пользователя jean при правильных настройках пользователя:
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl logs -l app=k8s-hello-world
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl logs -l app=k8s-hello-world
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl get pods
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ sudo -u jean kubectl get pods -n default
Error from server (Forbidden): pods is forbidden: User "jean" cannot list resource "pods" in API group "" in the namespace "default"

```


#### 5. Создание ролей для пользователя
1. Создание Role и ClusterRole

Мы будем использовать ClusterRole, доступный по умолчанию. Впрочем, также покажем, как создавать свои Role и ClusterRole. 

* По сути Role и ClusterRole — это всего лишь набор действий (называемых как verbs, т.е. дословно — «глаголов»), разрешенных для определенных ресурсов и пространств имен. 

* Вот пример YAML-файла:
```yml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: Role
metadata:
  name: list-deployments
  namespace: my-project-dev
rules:
  - apiGroups: [ apps ]
    resources: [ deployments ]
    verbs: [ get, list ]
-------------------------------------------------
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: list-deployments
rules:
  - apiGroups: [ apps ]
    resources: [ deployments ]
    verbs: [ get, list ]
```
2. Чтобы создать Role и ClusterRole на основе этого файла, выполните команду:
```
kubectl create -f /path/to/your/yaml/file
```

#### 6. Привязка Role или ClusterRole к пользователям

[Использование авторизации RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#referring-to-resources)

1. Теперь привяжем ClusterRole по умолчанию (edit и view) к нашим пользователям следующим образом:

- jean:
  - edit — в пространстве имен my-project-dev;
  - view — в пространстве имен my-project-prod;
- sarah:
  - edit — в пространстве имен my-project-prod.


2. RoleBinding'и нужно задавать по пространствам имен, а не по пользователям. Другими словами, для авторизации jean мы создадим два RoleBinding'а. 

* Пример YAML-файла, определяющего RoleBinding'и для jean:
```yml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jean
  namespace: my-project-dev
subjects:
- kind: User
  name: jean
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: edit
  apiGroup: rbac.authorization.k8s.io
---------------------------------------------
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jean
  namespace: my-project-prod
subjects:
- kind: User
  name: jean
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
```

3. Мы разрешаем jean просматривать (view) my-project-prod и редактировать (edit) my-project-dev. То же самое необходимо сделать с авторизациями для sarah. 

* Для их активации выполните команду:
```
kubectl apply -f /path/to/your/yaml/file
```
В данном случае была использована `kubectl apply` вместо `kubectl create`. Разница между ними в том, что create создает объект и больше ничего не делает, а apply — не только создает объект (в случае, если его не существует), но и обновляет при необходимости.

#### 7. Проверка получения пользователями нужных разрешений
1. Давайте проверим, получили ли наши пользователи нужные разрешения.
- Пользователь: sarah (edit в my-project-prod)
```
  - my-project-prod
    - может выводить список pod'ов (1);
    - может создавать deployment'ы (2).
  - my-project-dev
    - не может выводить список pod'ов (4);
    - не может создавать deployment'ы (5).
```
```
(1) kubectl get pods -n my-project-prod 
No resources found. 
```
```
(2) kubectl run nginx --image=nginx --replicas=1 -n my-project-prod 
deployment.apps/nginx created 
```
```
(3) kubectl get pods -n my-project-prod 
NAME                    READY  STATUS   RESTARTS  AGE 
nginx-7db9fccd9b-t14qw  1/1    Running  0         4s 
```
```
(4) kubectl get pods -n my-project-dev
Error from server (Forbidden): pods is forbidden: User "sarah" cannot list resource "pods" in API group "" in the namespace "my-project-dev"
```
```
(5) kubectl run nginx --image=nginx --replicas=1 -n my-project-dev 
Error from server (Forbidden): deployments.apps is forbidden: User "sarah" cannot create resource "deployments" in API group "apps" in the namespace "my-project-dev"
```
- Пользователь: jean (view в my-project-prod и edit в my-project-dev)
```
- my-project-prod
  - может выводить список pod'ов (1);
  - может выводить список deployment'ов (2);
  - не может удалять deployment'ы (3).
- my-project-dev:
  - может выводить список pod'ов (4);
  - может создавать deployment'ы (5);
  - может выводить список deployment'ов (6);
  - может удалять deployment'ы (7).
```
```
(1) kubectl get pods -n my-project-prod 
NAME                    READY  STATUS   RESTARTS  AGE 
nginx-7db9fccd9b-t14qw  1/1    Running  0         101s 

(2) kubectl get deploy -n my-project-prod 
NAME   READY  UP-TO-DATE  AVAILABLE  AGE 
nginx  1/1    1           1          110s 

(3) kubectl delete deploy/nginx -n my-project-prod 
Error from server (Forbidden): deployments.extensions "nginx" is forbidden: User "jean" cannot delete resource "deployments" in API group "extensions" in the namespace "my-project-prod" 

(4) kubectl get pods -n my-project-dev
No resources found. 

(5) kubectl run nginx --image=nginx --replicas=1 -n my-project-dev 
deployment.apps/nginx created 

(6) kubectl get deploy -n my-project-dev 
NAME   READY  UP-TO-DATE  AVAILABLE  AGE 
nginx  0/1    1           0          13s 

(7) kubectl delete deploy/nginx -n my-project-dev 
deployment.extensions "nginx" deleted 

(8) kubectl get deploy -n my-project-dev 
No resources found.
```

#### 8. Управление пользователями и их авторизацией

1. Итак, мы успешно задали различные роли и авторизации пользователей. Возникает вопрос: как теперь управлять всем этим? Как узнать, правильно ли заданы права доступа для конкретного пользователя? Как узнать, кто обладает полномочиями на выполнение определенного действия? Как получить общую картину разрешений пользователей?

Нам необходимы ответы на все эти вопросы, чтобы обеспечить безопасность кластера. Команда `kubectl auth can-i` позволяет выяснить, может ли пользователь выполнить определенное действие:
```
# kubectl auth can-i $action $resource --as $subject

(1) kubectl auth can-i list pods 
(2) kubectl auth can-i list pods --as jean
```
Первая команда (1) позволяет пользователю узнать, может ли он выполнить некое действие. Вторая (2) — позволяет администратору выдать себя за пользователя, чтобы узнать, может ли тот выполнить определенное действие. Подобное «перевоплощение» разрешено только для пользователей с привилегиями администратора кластера.

Это практически все, что можно сделать с помощью встроенного инструментария. Именно поэтому представлю и некоторые Open Source-проекты, позволяющие расширить возможности, предлагаемые командой kubectl auth can-i. Прежде чем представить их, установим зависимости: Go и Krew.

* Пример вывода команд:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl auth can-i list pods
yes
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl auth can-i list nodes
Warning: resource 'nodes' is not namespace scoped
yes
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl auth can-i list nod
Warning: the server doesn't have a resource type 'nod'
yes
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl auth can-i --list --namespace=foo
Resources                                       Non-Resource URLs   Resource Names   Verbs
*.*                                             []                  []               [*]
                                                [*]                 []               [*]
selfsubjectaccessreviews.authorization.k8s.io   []                  []               [create]
selfsubjectrulesreviews.authorization.k8s.io    []                  []               [create]
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



## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

**Ответ:**



---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
