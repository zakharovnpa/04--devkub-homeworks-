# Домашнее задание к занятию "12.5 Сетевые решения CNI" - Захаров Сергей Николаевич

Уточнение: показать что не только что-то работает, но и то, что что-то не работает.
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.

## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

### Ответ:



Пояснение:
- можно использовать любое приложение для тестирования доступа
- главное - протестировать межподовое взаимодействие
  - показать как есть доступ по зеленым стрелкам
  - показать что нет доступа по красным стрелкам не схеме из лекции
  
  
#### Развертывание приложений Frontend, Backend, Cache

##### 1. Запуск развертывания подов `kubectl apply -f tamplates/main/`
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

##### 2. Проверка доступности каждого пода из пода Backend
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
##### 3. Проверка доступности каждого пода из пода frontend
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
##### 4. Проверка доступности каждого пода из пода cache
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

##### 5. Согласно комментария преподавателя к выполнению этого задания, необходимо настроить сетевые политики так, как указана на этой схеме:

![network-policy](/12-kubernetes-05-cni/Files/network-poplicy.png)

* Открыть доступ:
- frontend -> backend
- backend -> cache

##### 6. Остальные возможные взаимодействия должны быть запрещены. 
* Закрыть доступ:
- backend  -> frontend
- cache  -> backend
- cache  -> frontend
- frontend -> cache



##### 7. Проверяем какие политики настроены к этому времени. Никакие не настроены.
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get networkpolicies.networking.k8s.io
No resources found in default namespace.

```

#### Создаем файлы политик доступа


##### 1. Разрешение доступа frontend -> backend. Доступ будем разрешать только для frontend
```yml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend        # Название политики
  namespace: default    # Используется только в namespace default
spec:                   # Описание политики 
  podSelector:          # По отношению к какому поду применяется политика
    matchLabels:        # Условие - по совпадению Labels, указанного на следующей строке
      app: frontend     # Условие для совпадения - название пода содержит слово frontend
  policyTypes:          # Какой будет тип сетевой политики
    - Ingress           # Входящий тип, т.е. контролруются входящие соединения

```

2. Политика , разрешающая доступ из backend в Cache

```yml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cache       # Имя политики
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: cache
  policyTypes:
    - Ingress
    - Egress
  ingress:        # Для входящих соединений 
    - from:       # От (и далее описано что для backend)
      - podSelector:
          matchLabels:
            app: backend
      ports:                  # Описание портов и протоколов
        - protocol: TCP
          port: 80
        - protocol: TCP
          port: 443

```
3. Политика, разрешающая доступ из frontend в Backend
```yml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend       # Имя политики
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Ingress
  ingress:        # Для входящих соединений
    - from:       # От (и далее описано что для frontend)
      - podSelector:
          matchLabels:
            app: frontend
      ports:                  # Описание портов и протоколов
        - protocol: TCP
          port: 80
        - protocol: TCP
          port: 443

```
4. Политика, разрешающая доступ к Fronend только от Fronend (всем остальным заапрещено)
```yml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend       # Имя политики
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: frontend
  policyTypes:
    - Ingress         # Для входящих соединений

```

  
#####  3. Применяем политики

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl apply -f network-policy/
networkpolicy.networking.k8s.io/backend created
networkpolicy.networking.k8s.io/cache created
networkpolicy.networking.k8s.io/frontend created
```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get networkpolicies.networking.k8s.io
NAME       POD-SELECTOR   AGE
backend    app=backend    54m
cache      app=cache      93m
frontend   app=frontend   21s
```

  
#####  4. Результаты прменения политик

* Есть доступ frontend -> backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-cxlvz -- curl -s -m 1 backend
Praqma Network MultiTool (with NGINX) - backend-869fd89bdc-rwrkw - 10.233.111.1
```
* Нет доступа backend -> frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-rwrkw -- curl -s -m 1 frontend
command terminated with exit code 28
```
* Есть доступ backend -> cache
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec backend-869fd89bdc-rwrkw -- curl -s -m 1 cache
Praqma Network MultiTool (with NGINX) - cache-b7cbd9f8f-ls8rm - 10.233.119.2
```
* Нет доступа cache -> backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-ls8rm -- curl -s -m 1 backend
command terminated with exit code 28
```
* Нет доступа frontend -> cache
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec frontend-c74c5646c-cxlvz -- curl -s -m 1 cache
command terminated with exit code 28
```
* Нет доступа cache -> frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl exec cache-b7cbd9f8f-ls8rm -- curl -s -m 1 frontend
command terminated with exit code 28
```
 * Условие задачи выполнено.

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой `calicoctl get <type>`. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

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
