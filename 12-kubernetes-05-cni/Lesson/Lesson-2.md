## Ход выполнения ДЗ по теме "12.5 Сетевые решения CNI" - вариант 2. Работа в лкстере, развернутом с помощью Kubespray

После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

### Подготовка к решению.

Условие:
 - сейчас установен Flannel
 - надо установить Calico, т.к. у него есть больше возможностей
 - Calico по умолчанию устанавливается с помощью Kubespray
 - необходимо настроить политику безопасности (политику доступа) к какому-то нашему приложению "hello-world"
 - приложение можно брать любое, можно взять multitool 
 - доступ нужно обеспечить "из вне", т.е. на уровне межподового взаимодействия
 - продемонстрировать как что-то работает согласно задания
 - продемонстрировать как что-то не работает там где нужны ограничения доступа (согласно задания)

1. Установить в кластер приложение hello-world
2. Предостаить к нему доступ извне

### Ход решения.

#### Подготовка кластера к выполнению ДЗ
1. Созданы 3 ВМ в Яндекс.Облаке
```
+----------------------+-----------+---------------+---------+---------------+-------------+
|          ID          |   NAME    |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-----------+---------------+---------+---------------+-------------+
| fhmnubq1atmak79pgmar | cp1-cl2   | ru-central1-a | RUNNING | 51.250.13.231 | 10.128.0.21 |
| fhmpcgarg4plkog5aog4 | node2-cl2 | ru-central1-a | RUNNING | 51.250.70.254 | 10.128.0.7  |
| fhmv869ceiavpkpdk4o3 | node1-cl2 | ru-central1-a | RUNNING | 51.250.92.206 | 10.128.0.36 |
+----------------------+-----------+---------------+---------+---------------+-------------+
```
2. К каждой ВМ нужно сделать первое подключение по SSH, для проборса ключей
3. Подготовлены файлы для Kubespray
  * `host.ayml` записаны `EXTERNAL IP`  адреса в ansible-hosts, user
  * `k8s-claster.yaml` - в параметр `supplementary_addresses_in_ssl_keys` записан ip адрес ВМ, на которой будет устанавливаться Kubernetes. 
  Это позволит в дальнейшем подключаться к кластеру с удаленной ОС
4. С помощью Kubespray развернут кластер 

```
PLAY RECAP ************************************************************************************************************************************************************************************************************************
cp1-cl2                    : ok=748  changed=143  unreachable=0    failed=0    skipped=1229 rescued=0    ignored=9   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
node1-cl2                  : ok=497  changed=93   unreachable=0    failed=0    skipped=722  rescued=0    ignored=2   
node2-cl2                  : ok=497  changed=93   unreachable=0    failed=0    skipped=721  rescued=0    ignored=2   

Суббота 02 июля 2022  08:19:15 +0400 (0:00:00.123)       0:16:55.913 ********** 
=============================================================================== 
kubernetes/kubeadm : Join to cluster ------------------------------------- 34.02s
kubernetes/preinstall : Install packages requirements -------------------- 29.91s
download : download_file | Validate mirrors ------------------------------ 25.77s
kubernetes/control-plane : kubeadm | Initialize first master ------------- 24.89s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down CoreDNS templates --- 19.67s
kubernetes/control-plane : Master | wait for kube-controller-manager ----- 19.55s
kubernetes-apps/ansible : Kubernetes Apps | Start Resources ---------------18.18s
download : download_container | Download image if required --------------- 15.16s
download : download_container | Download image if required --------------- 12.70s
network_plugin/calico : Calico | Create calico manifests ----------------- 11.56s
download : download_container | Download image if required --------------- 11.11s
kubernetes/preinstall : Preinstall | wait for the apiserver to be running --10.87s
network_plugin/calico : Wait for calico kubeconfig to be created ---------- 10.15s
download : download_container | Download image if required ---------------- 9.49s
network_plugin/calico : Start Calico resources ---------------------------- 8.92s
download : download_container | Download image if required ---------------- 8.57s
kubernetes/preinstall : Update package management cache (APT) ------------- 8.47s
download : download_file | Download item ---------------------------------- 7.99s
etcd : reload etcd -------------------------------------------------------- 7.39s
container-engine/containerd : containerd | Unpack containerd archive ------ 6.92s

```
5. После развертывания кластера, ноебходимо зайти на Control Plane и настроить доступ к кластеру обычного пользователя. 
  * Запустить команду:
```
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
```
6. Доступ к кластеру появился
```
yc-user@cp1-cl2:~$ {
>     mkdir -p $HOME/.kube
>     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
>     sudo chown $(id -u):$(id -g) $HOME/.kube/config
> }
yc-user@cp1-cl2:~$ 
yc-user@cp1-cl2:~$ kubectl get nodes
NAME        STATUS   ROLES           AGE    VERSION
cp1-cl2     Ready    control-plane   10m    v1.24.2
node1-cl2   Ready    <none>          9m5s   v1.24.2
node2-cl2   Ready    <none>          9m5s   v1.24.2

```
7. Для удаленного пользователя необходимо установить на ОС kubectl и скопировать файл с сервера Control Plane `~./kube/config` в домашнюю директорию удаленного пользователя, изменив адрес сервера с локальнго на внешний адрес.


#### Установка Calico 
1. Установка производилась при развертывании кластера с помощью Kubespray
```
yc-user@cp1-cl2:~$ calicoctl version
Client Version:    v3.23.1
Git commit:        967e24543
Cluster Version:   v3.23.1
Cluster Type:      kubespray,kubeadm,kdd
```
```
yc-user@cp1-cl2:~$ calicoctl get nodes -o wide
NAME        ASN       IPV4             IPV6   
cp1-cl2     (64512)   10.128.0.21/24          
node1-cl2   (64512)   10.128.0.36/24          
node2-cl2   (64512)   10.128.0.7/24   
```
```
yc-user@cp1-cl2:~$ calicoctl get ipPool
NAME           CIDR             SELECTOR   
default-pool   10.233.64.0/18   all()  
```
```
yc-user@cp1-cl2:~$ calicoctl get profile
NAME                                                 
projectcalico-default-allow                          
kns.default                                          
kns.kube-node-lease                                  
kns.kube-public                                      
kns.kube-system                                      
ksa.default.default                                  
ksa.kube-node-lease.default                          
ksa.kube-public.default                              
ksa.kube-system.attachdetach-controller              
ksa.kube-system.bootstrap-signer                     
ksa.kube-system.calico-node                          
ksa.kube-system.certificate-controller               
ksa.kube-system.clusterrole-aggregation-controller   
ksa.kube-system.coredns                              
ksa.kube-system.cronjob-controller                   
ksa.kube-system.daemon-set-controller                
ksa.kube-system.default                              
ksa.kube-system.deployment-controller                
ksa.kube-system.disruption-controller                
ksa.kube-system.dns-autoscaler                       
ksa.kube-system.endpoint-controller                  
ksa.kube-system.endpointslice-controller             
ksa.kube-system.endpointslicemirroring-controller    
ksa.kube-system.ephemeral-volume-controller          
ksa.kube-system.expand-controller                    
ksa.kube-system.generic-garbage-collector            
ksa.kube-system.horizontal-pod-autoscaler            
ksa.kube-system.job-controller                       
ksa.kube-system.kube-proxy                           
ksa.kube-system.namespace-controller                 
ksa.kube-system.node-controller                      
ksa.kube-system.nodelocaldns                         
ksa.kube-system.persistent-volume-binder             
ksa.kube-system.pod-garbage-collector                
ksa.kube-system.pv-protection-controller             
ksa.kube-system.pvc-protection-controller            
ksa.kube-system.replicaset-controller                
ksa.kube-system.replication-controller               
ksa.kube-system.resourcequota-controller             
ksa.kube-system.root-ca-cert-publisher               
ksa.kube-system.service-account-controller           
ksa.kube-system.service-controller                   
ksa.kube-system.statefulset-controller               
ksa.kube-system.token-cleaner                        
ksa.kube-system.ttl-after-finished-controller        
ksa.kube-system.ttl-controller                       
```


#### Развертывание приложений Frontend, Backend, Cache
1. Подготовка манифестов для создания деплойментов
* Manifest Frontend
```yml
---
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
    spec:                  # Описание пода
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

* Manifest Backend
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: backend
  name: backend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:                  # Описание пода
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: backend

```

* Manifest cache
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: cache
  name: cache
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cache
  template:
    metadata:
      labels:
        app: cache
    spec:                  # Описание пода
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: cache
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: cache

```
##### Процесс развертывание приложений

1. Для начала необходимо развернуть поды из подготовленных манифестов.
```shell script
# Развертывание
kubectl apply -f ./templates/main/

# Проверка созданных подов
kubectl get po
``` 
2. Проверка какие поды есть в неймспейс default
```
maestro@PC-Ubuntu:~$ kubectl get ns
NAME              STATUS   AGE
default           Active   20h
kube-node-lease   Active   20h
kube-public       Active   20h
kube-system       Active   20h
```
  * Подов никаких нет в неймспейс default
```
maestro@PC-Ubuntu:~$ kubectl -n default get po
No resources found in default namespace.
```
  * Если поды есть, то очищаем ноду от ранее созданных деплойментов
```
kubectl -n default delete deployment --all
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get nodes -o wide
NAME        STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
cp1-cl2     Ready    control-plane   29m   v1.24.2   10.128.0.21   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node1-cl2   Ready    <none>          27m   v1.24.2   10.128.0.36   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node2-cl2   Ready    <none>          27m   v1.24.2   10.128.0.7    <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
```

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
No resources found in default namespace.
```
3. Запуск развертывания подов `kubectl apply -f tamplates/main/`
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl apply -f manifest/main/
deployment.apps/backend created
service/backend created
deployment.apps/cache created
service/cache created
deployment.apps/frontend created
service/frontend created

```

  * Првоерка статуса подов
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                       READY   STATUS              RESTARTS   AGE
backend-869fd89bdc-rwrkw   0/1     ContainerCreating   0          4s
cache-b7cbd9f8f-ls8rm      0/1     ContainerCreating   0          4s
frontend-c74c5646c-cxlvz   0/1     ContainerCreating   0          4s

```

4. Проверка доступности каждого пода из пода Backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-rwrkw -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-cxlvz - 10.233.111.2
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-rwrkw -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-rwrkw - 10.233.111.1
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-rwrkw -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-ls8rm - 10.233.119.2
```
5. Проверка доступности каждого пода из пода frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-cxlvz -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-cxlvz - 10.233.111.2
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-cxlvz -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-rwrkw - 10.233.111.1
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-cxlvz -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-ls8rm - 10.233.119.2
```
6. Проверка доступности каждого пода из пода cache
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-8z4vj -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-m9k8c - 10.244.2.3
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-8z4vj -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-5rb7v - 10.244.1.2
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-8z4vj -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-8z4vj - 10.244.2.2

```

#### Применение сетевых политик и проверка доступности подов

1. Согласно комментария преподавателя к выполнению этого задания, необходтимо так настроить сетевые политики, как указана на этой схеме:

![network-policy](/12-kubernetes-05-cni/Files/network-poplicy.png)

* Открыть доступ:
- frontend -> backend
- backend -> cache

2. Остальные возможные взаимодействия должны быть запрещены. 
* Закрыть доступ:
- backend  -> frontend
- cache  -> backend
- cache  -> frontend
- frontend -> cache



1. Проверяем какие политики настроены к этому времени. Никакие не настроены.
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get networkpolicies.networking.k8s.io
No resources found in default namespace.

```



2. Применяем политику, которая запрещает все сетевые взамиодействия

  * default.yaml
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}   # Здесь не указан ни один под, поэтому мы все взаимодействия запретили
  policyTypes:
    - Ingress

```
 
  * Какие сейчас в кластере есть Endpoint. На каждом поде 
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get ep
NAME         ENDPOINTS          AGE
backend      10.233.111.1:80    21h
cache        10.233.119.2:80    21h
frontend     10.233.111.2:80    21h
kubernetes   10.128.0.21:6443   22h

```


* Применяем политику `default.yaml`
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl apply -f network-policy/default.yaml 
networkpolicy.networking.k8s.io/default-deny-ingress created
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get networkpolicies.networking.k8s.io 
NAME                   POD-SELECTOR   AGE
default-deny-ingress   <none>         9m30s

```





## Задание 2: изучить, что запущено по умолчанию

Самый простой способ — проверить командой `calicoctl get <type>`. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

Поясненеи:
  - после установки calicoctl сделать get параметров
  - приложить вывод из консоли или скриншот
  
### Ответ
1. Утилита calicoctl была установлена при развертывании кластера с помощью Kubespray

```
yc-user@cp1-cl2:~$ calicoctl version
Client Version:    v3.23.1
Git commit:        967e24543
Cluster Version:   v3.23.1
Cluster Type:      kubespray,kubeadm,kdd

```
2. Выводы calicoctl
  * calicoctl get nodes
```
yc-user@cp1-cl2:~$ calicoctl get nodes -o wide
NAME        ASN       IPV4             IPV6   
cp1-cl2     (64512)   10.128.0.21/24          
node1-cl2   (64512)   10.128.0.36/24          
node2-cl2   (64512)   10.128.0.7/24 
```
  * calicoctl get ipPool
```
yc-user@cp1-cl2:~$ calicoctl get ipPool
NAME           CIDR             SELECTOR   
default-pool   10.233.64.0/18   all()   
```
  * calicoctl get profile
```
yc-user@cp1-cl2:~$ calicoctl get profile
NAME                                                 
projectcalico-default-allow                          
kns.default                                          
kns.kube-node-lease                                  
kns.kube-public                                      
kns.kube-system                                      
ksa.default.default                                  
ksa.kube-node-lease.default                          
ksa.kube-public.default                              
ksa.kube-system.attachdetach-controller              
ksa.kube-system.bootstrap-signer                     
ksa.kube-system.calico-node                          
ksa.kube-system.certificate-controller               
ksa.kube-system.clusterrole-aggregation-controller   
ksa.kube-system.coredns                              
ksa.kube-system.cronjob-controller                   
ksa.kube-system.daemon-set-controller                
ksa.kube-system.default                              
ksa.kube-system.deployment-controller                
ksa.kube-system.disruption-controller                
ksa.kube-system.dns-autoscaler                       
ksa.kube-system.endpoint-controller                  
ksa.kube-system.endpointslice-controller             
ksa.kube-system.endpointslicemirroring-controller    
ksa.kube-system.ephemeral-volume-controller          
ksa.kube-system.expand-controller                    
ksa.kube-system.generic-garbage-collector            
ksa.kube-system.horizontal-pod-autoscaler            
ksa.kube-system.job-controller                       
ksa.kube-system.kube-proxy                           
ksa.kube-system.namespace-controller                 
ksa.kube-system.node-controller                      
ksa.kube-system.nodelocaldns                         
ksa.kube-system.persistent-volume-binder             
ksa.kube-system.pod-garbage-collector                
ksa.kube-system.pv-protection-controller             
ksa.kube-system.pvc-protection-controller            
ksa.kube-system.replicaset-controller                
ksa.kube-system.replication-controller               
ksa.kube-system.resourcequota-controller             
ksa.kube-system.root-ca-cert-publisher               
ksa.kube-system.service-account-controller           
ksa.kube-system.service-controller                   
ksa.kube-system.statefulset-controller               
ksa.kube-system.token-cleaner                        
ksa.kube-system.ttl-after-finished-controller        
ksa.kube-system.ttl-controller  
```

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
