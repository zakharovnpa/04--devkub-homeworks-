## Определение момента старта сервера NFS при его инсталляции

### 1.

* Тест запуска NFS
```
controlplane $ kubectl get po,pvc,pv,sc
No resources found
```

* Установка helm
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
* Лог
```

```
* Тест запуска NFS
```
controlplane $ kubectl get po,pvc,pv,sc
No resources found
```

### 2.  Добавление репозитория чартов
* Установка
```
helm repo add stable https://charts.helm.sh/stable && helm repo update
```
* Лог
```
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
```
* Тест запуска NFS
```
controlplane $ kubectl get po,pvc,pv,sc
No resources found
```

### 3.
*  Установка nfs-server через helm 
```
helm install nfs-server stable/nfs-server-provisioner
```
* Лог
```
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sun Jul 17 02:28:36 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
```
* Тест запуска NFS
```
controlplane $ date
Sun Jul 17 02:29:13 UTC 2022
controlplane $ 
controlplane $ kubectl get po,pvc,pv,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          40s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   40s
controlplane $ 
```

### 4. Вывод: при установке NFS сервера запускается storageclass с именем `nfs` а так же provisioner `cluster.local/nfs-server-nfs-server-provisioner`

* controlplane $ kubectl get sc nfs -o yaml
```yml
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    meta.helm.sh/release-name: nfs-server
    meta.helm.sh/release-namespace: default
  creationTimestamp: "2022-07-17T02:28:36Z"
  labels:
    app: nfs-server-provisioner
    app.kubernetes.io/managed-by: Helm
    chart: nfs-server-provisioner-1.1.3
    heritage: Helm
    release: nfs-server
  name: nfs
  resourceVersion: "5696"
  uid: 2959ecb0-7eab-45cb-b708-21286e6ed2b3
mountOptions:
- vers=3
provisioner: cluster.local/nfs-server-nfs-server-provisioner
reclaimPolicy: Delete
volumeBindingMode: Immediate
 
```
* controlplane $ kubectl get pod nfs-server-nfs-server-provisioner-0 -o yaml
```yml
---
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 6fadab3d6f60eb8477dc5a518e38b51cab1d4c29ca4af85cc98968e6923ad8ab
    cni.projectcalico.org/podIP: 192.168.1.4/32
    cni.projectcalico.org/podIPs: 192.168.1.4/32
  creationTimestamp: "2022-07-17T02:28:36Z"
  generateName: nfs-server-nfs-server-provisioner-
  labels:
    app: nfs-server-provisioner
    chart: nfs-server-provisioner-1.1.3
    controller-revision-hash: nfs-server-nfs-server-provisioner-64bd6d7f65
    heritage: Helm
    release: nfs-server
    statefulset.kubernetes.io/pod-name: nfs-server-nfs-server-provisioner-0
  name: nfs-server-nfs-server-provisioner-0
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: StatefulSet
    name: nfs-server-nfs-server-provisioner
    uid: 5982b8a2-1367-4c7c-9da0-2b62d3b6748d
  resourceVersion: "5727"
  uid: a78c44ad-1fcc-4dfa-9da4-89448f655292
spec:
  containers:
  - args:
    - -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    env:
    - name: POD_IP
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: status.podIP
    - name: SERVICE_NAME
      value: nfs-server-nfs-server-provisioner
    - name: POD_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    image: quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    imagePullPolicy: IfNotPresent
    name: nfs-server-provisioner
    ports:
    - containerPort: 2049
      name: nfs
      protocol: TCP
    - containerPort: 2049
      name: nfs-udp
      protocol: UDP
    - containerPort: 32803
      name: nlockmgr
      protocol: TCP
    - containerPort: 32803
      name: nlockmgr-udp
      protocol: UDP
    - containerPort: 20048
      name: mountd
      protocol: TCP
    - containerPort: 20048
      name: mountd-udp
      protocol: UDP
    - containerPort: 875
      name: rquotad
      protocol: TCP
    - containerPort: 875
      name: rquotad-udp
      protocol: UDP
    - containerPort: 111
      name: rpcbind
      protocol: TCP
    - containerPort: 111
      name: rpcbind-udp
      protocol: UDP
    - containerPort: 662
      name: statd
      protocol: TCP
    - containerPort: 662
      name: statd-udp
      protocol: UDP
    resources: {}
    securityContext:
      capabilities:
        add:
        - DAC_READ_SEARCH
        - SYS_RESOURCE
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /export
      name: data
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-4xgtw
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostname: nfs-server-nfs-server-provisioner-0
  nodeName: node01
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: nfs-server-nfs-server-provisioner
  serviceAccountName: nfs-server-nfs-server-provisioner
  subdomain: nfs-server-nfs-server-provisioner
  terminationGracePeriodSeconds: 100
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - emptyDir: {}
    name: data
  - name: kube-api-access-4xgtw
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T02:28:36Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T02:28:43Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T02:28:43Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T02:28:36Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://8204ff9d1f7d18edb8b9d9fdf648e719c31e9a15432040f16a1f59d427571e1f
    image: quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    imageID: quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    lastState: {}
    name: nfs-server-provisioner
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-17T02:28:42Z"
  hostIP: 172.30.2.2
  phase: Running
  podIP: 192.168.1.4
  podIPs:
  - ip: 192.168.1.4
  qosClass: BestEffort
  startTime: "2022-07-17T02:28:36Z"

```
* controlplane $ kubectl describe sc nfs  
```      
Name:                  nfs
IsDefaultClass:        No
Annotations:           meta.helm.sh/release-name=nfs-server,meta.helm.sh/release-namespace=default
Provisioner:           cluster.local/nfs-server-nfs-server-provisioner
Parameters:            <none>
AllowVolumeExpansion:  True
MountOptions:
  vers=3
ReclaimPolicy:      Delete
VolumeBindingMode:  Immediate
Events:             <none>

```

* controlplane $ kubectl describe pod nfs-server-nfs-server-provisioner-0        

```
Name:         nfs-server-nfs-server-provisioner-0
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sun, 17 Jul 2022 02:28:36 +0000
Labels:       app=nfs-server-provisioner
              chart=nfs-server-provisioner-1.1.3
              controller-revision-hash=nfs-server-nfs-server-provisioner-64bd6d7f65
              heritage=Helm
              release=nfs-server
              statefulset.kubernetes.io/pod-name=nfs-server-nfs-server-provisioner-0
Annotations:  cni.projectcalico.org/containerID: 6fadab3d6f60eb8477dc5a518e38b51cab1d4c29ca4af85cc98968e6923ad8ab
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  StatefulSet/nfs-server-nfs-server-provisioner
Containers:
  nfs-server-provisioner:
    Container ID:  containerd://8204ff9d1f7d18edb8b9d9fdf648e719c31e9a15432040f16a1f59d427571e1f
    Image:         quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    Image ID:      quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    Ports:         2049/TCP, 2049/UDP, 32803/TCP, 32803/UDP, 20048/TCP, 20048/UDP, 875/TCP, 875/UDP, 111/TCP, 111/UDP, 662/TCP, 662/UDP
    Host Ports:    0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP
    Args:
      -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    State:          Running
      Started:      Sun, 17 Jul 2022 02:28:42 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      POD_IP:          (v1:status.podIP)
      SERVICE_NAME:   nfs-server-nfs-server-provisioner
      POD_NAMESPACE:  default (v1:metadata.namespace)
    Mounts:
      /export from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4xgtw (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-4xgtw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  20m   default-scheduler  Successfully assigned default/nfs-server-nfs-server-provisioner-0 to node01
  Normal  Pulling    20m   kubelet            Pulling image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0"
  Normal  Pulled     20m   kubelet            Successfully pulled image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0" in 5.126938583s
  Normal  Created    20m   kubelet            Created container nfs-server-provisioner
  Normal  Started    20m   kubelet            Started container nfs-server-provisioner
```
* controlplane $ kubectl logs nfs-server-nfs-server-provisioner-0
```
I0717 02:28:42.499433       1 main.go:64] Provisioner cluster.local/nfs-server-nfs-server-provisioner specified
I0717 02:28:42.499466       1 main.go:88] Setting up NFS server!
I0717 02:28:42.621014       1 server.go:149] starting RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0717 02:28:42.621095       1 server.go:160] ending RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0717 02:28:42.621404       1 server.go:134] Running NFS server!
```


