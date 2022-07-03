## Ход выполнения ДЗ по теме "12.5 Сетевые решения CNI"

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

##### Подготовка кластера к выполнению ДЗ
1. Создан кластер на ЯО:
  1. 1 управляющая нода cp1
  2. 2 рабочие ноды node1, node2
```
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm6kdtgn7a54j3gmfbe | node1 | ru-central1-a | RUNNING | 51.250.86.192 | 10.128.0.34 |
| fhmpr3ehr27lhjbngras | node2 | ru-central1-a | RUNNING | 51.250.91.26  | 10.128.0.17 |
| fhmtrqairbmsnvmuolat | cp1   | ru-central1-a | RUNNING | 51.250.95.178 | 10.128.0.33 |
+----------------------+-------+---------------+---------+---------------+-------------+

```
2. Установлен CNI Flanel
3. На каждой ноде работает kube-proxy, iptables
4. 

#### Установка Calico 
1. Установка производилась при развертывании кластера с помощью Kubespray
2. 
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
2. Развертывание 

Для начала необходимо развернуть объекты из подготовленных манифестов.
```shell script
# Развертывание
kubectl apply -f ./templates/main/

# Проверка созданных подов
kubectl get po
``` 
  1. Проверка подов в неймспейс default
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
3. Запуск развертывания подов `kubectl apply -f tamplates/main/`
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl apply -f tamplates/main/
deployment.apps/backend created
service/backend created
deployment.apps/cache created
service/cache created
deployment.apps/frontend created
service/frontend created
```

  * Првоерка статуса подов
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl -n default get po
NAME                       READY   STATUS    RESTARTS   AGE
backend-869fd89bdc-5rb7v   1/1     Running   0          14s
cache-b7cbd9f8f-8z4vj      1/1     Running   0          14s
frontend-c74c5646c-m9k8c   1/1     Running   0          14s
```

4. Проверка доступности каждого пода из пода Backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-5rb7v -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-m9k8c - 10.244.2.3
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-5rb7v -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-5rb7v - 10.244.1.2
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-5rb7v -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-8z4vj - 10.244.2.2

```
5. Проверка доступности каждого пода из пода frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-m9k8c -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-m9k8c - 10.244.2.3
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-m9k8c -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-5rb7v - 10.244.1.2
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-m9k8c -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-8z4vj - 10.244.2.2
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

Согласно комментария преподавателя к выполнению этого задания, необходтимо так настроить сетевые политики, как указана на этой схеме:

![network-policy](/12-kubernetes-05-cni/Files/network-poplicy.png)

1. Применяем политику, которая запрещает все сетевые взамиодействия

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
  * Взаимодействия между подами сохранились, т.к. наш плагин CNI Flanel не поддерживает сетевые политики
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get networkpolicies.networking.k8s.io 
NAME                   POD-SELECTOR   AGE
default-deny-ingress   <none>         9m30s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-5rb7v -- curl -s -m 1 frontend
Praqma Network MultiTool (with NGINX) - frontend-c74c5646c-m9k8c - 10.244.2.3
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-8z4vj -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-5rb7v - 10.244.1.2

```
  * Endpoint
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get ep
NAME         ENDPOINTS          AGE
backend      10.244.1.2:80      52m
cache        10.244.2.2:80      52m
frontend     10.244.2.3:80      52m
kubernetes   10.128.0.33:6443   24h

```

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ mkdir -p network-policy
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ cd network-policy/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ vim default.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ vim frontend.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ vim frontend.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ vim backend.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ vim cache.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/network-policy$ ls -lha
итого 24K
drwxrwxr-x 2 maestro maestro 4,0K июн 28 10:47 .
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 ..
-rw-rw-r-- 1 maestro maestro  383 июн 28 10:47 backend.yaml
-rw-rw-r-- 1 maestro maestro  391 июн 28 10:47 cache.yaml
-rw-rw-r-- 1 maestro maestro  150 июн 28 10:45 default.yaml
-rw-rw-r-- 1 maestro maestro  193 июн 28 10:46 frontend.yaml

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
#### Установка Calico для политики
1. Убедиться, что  в диспетчере контроллеров Kubernetes установлены следующие флаги:
```
--cluster-cidr=<your-pod-cidr>
--allocate-node-cidrs=true
```
2. Загрузите Flanel сетевой манифест для хранилища данных Kubernetes API.
```
curl https://projectcalico.docs.tigera.io/manifests/canal.yaml -O
```
3. Процесс скачивания 
```
yc-user@cp1:~$ curl https://projectcalico.docs.tigera.io/manifests/canal.yaml -O
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  223k  100  223k    0     0   682k      0 --:--:-- --:--:-- --:--:--  680k
yc-user@cp1:~$ 
```
4. Если вы используете модуль CIDR 10.244.0.0/16, перейдите к следующему шагу. 
5. Введите следующую команду, чтобы установить Calico
```
kubectl apply -f canal.yaml
```


6. Результат установки
```
yc-user@cp1:~$ kubectl apply -f canal.yaml
configmap/canal-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrole.rbac.authorization.k8s.io/flannel configured
clusterrolebinding.rbac.authorization.k8s.io/canal-flannel created
clusterrolebinding.rbac.authorization.k8s.io/canal-calico created
daemonset.apps/canal created
serviceaccount/canal created
deployment.apps/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
poddisruptionbudget.policy/calico-kube-controllers created

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
