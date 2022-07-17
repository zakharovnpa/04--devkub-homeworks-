### Подключение к PVC, PV

```yml
controlplane $ cat pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```

```yml
controlplane $ cat pod.yaml 
---
apiVersion: v1
kind: Pod
metadata:
  name: pod
spec:
  containers:
    - name: nginx
      image: nginx
#      volumeMounts:
#        - mountPath: "/static"
#          name: my-volume
#  volumes:
#    - name: my-volume
#      persistentVolumeClaim:
#        claimName: pvc
```
* Запускаем под, в котором не указаны спецификации PV
```
controlplane $ kubectl apply -f pod.yaml 
pod/pod created
```
```
controlplane $ kubectl get po pod -o wide
NAME   READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
pod    1/1     Running   0          30m   192.168.1.5   node01   <none>           <none>
```
```
controlplane $ kubectl get po pod -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 35438b3f60e77bf92dbefe6552deea21ff660138cfdd8d2314ad953e52a2b2b6
    cni.projectcalico.org/podIP: 192.168.1.5/32
    cni.projectcalico.org/podIPs: 192.168.1.5/32
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"pod","namespace":"default"},"spec":{"containers":[{"image":"nginx","name":"nginx"}]}}
  creationTimestamp: "2022-07-17T03:41:22Z"
  name: pod
  namespace: default
  resourceVersion: "11324"
  uid: 4233ff54-47b8-420c-842b-d19286dd3746
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-dfvr6
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: node01
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
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
  - name: kube-api-access-dfvr6
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
    lastTransitionTime: "2022-07-17T03:41:22Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T03:41:28Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T03:41:28Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-17T03:41:22Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://0590cfbcb615ecceb83f7ef7a24e0fd66a05b3d16e0440dfee0c9ad375ff0447
    image: docker.io/library/nginx:latest
    imageID: docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-17T03:41:27Z"
  hostIP: 172.30.2.2
  phase: Running
  podIP: 192.168.1.5
  podIPs:
  - ip: 192.168.1.5
  qosClass: BestEffort
  startTime: "2022-07-17T03:41:22Z"
```
```
controlplane $ kubectl logs pod        
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/17 03:41:27 [notice] 1#1: using the "epoll" event method
2022/07/17 03:41:27 [notice] 1#1: nginx/1.23.0
2022/07/17 03:41:27 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/17 03:41:27 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/17 03:41:27 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/17 03:41:27 [notice] 1#1: start worker processes
2022/07/17 03:41:27 [notice] 1#1: start worker process 31
```
```
controlplane $ kubectl describe po pod        
Name:         pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sun, 17 Jul 2022 03:41:22 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: 35438b3f60e77bf92dbefe6552deea21ff660138cfdd8d2314ad953e52a2b2b6
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:  192.168.1.5
Containers:
  nginx:
    Container ID:   containerd://0590cfbcb615ecceb83f7ef7a24e0fd66a05b3d16e0440dfee0c9ad375ff0447
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 17 Jul 2022 03:41:27 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dfvr6 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-dfvr6:
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
  Normal  Scheduled  31m   default-scheduler  Successfully assigned default/pod to node01
  Normal  Pulling    31m   kubelet            Pulling image "nginx"
  Normal  Pulled     30m   kubelet            Successfully pulled image "nginx" in 3.693374057s
  Normal  Created    30m   kubelet            Created container nginx
  Normal  Started    30m   kubelet            Started container nginx
controlplane $ 
```


* Запускаем PVC
```
ontrolplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
```
```
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-a222b1e0-f971-4a9a-9055-b86dea2e7709   2Gi        RWO            nfs            15m
```
```
ontrolplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pvc-a222b1e0-f971-4a9a-9055-b86dea2e7709
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                 Age   From                                                                                                                      Message
  ----    ------                 ----  ----                                                                                                                      -------
  Normal  ExternalProvisioning   16m   persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           16m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_79611106-8d24-42f5-b730-33a05a4deb3a  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  16m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_79611106-8d24-42f5-b730-33a05a4deb3a  Successfully provisioned volume pvc-a222b1e0-f971-4a9a-9055-b86dea2e7709
```

```yml
controlplane $ kubectl get pvc -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{},"name":"pvc","namespace":"default"},"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"2Gi"}},"storageClassName":"nfs"}}
      pv.kubernetes.io/bind-completed: "yes"
      pv.kubernetes.io/bound-by-controller: "yes"
      volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
      volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
    creationTimestamp: "2022-07-17T03:49:22Z"
    finalizers:
    - kubernetes.io/pvc-protection
    name: pvc
    namespace: default
    resourceVersion: "12186"
    uid: a222b1e0-f971-4a9a-9055-b86dea2e7709
  spec:
    accessModes:
    - ReadWriteOnce
    resources:
      requests:
        storage: 2Gi
    storageClassName: nfs
    volumeMode: Filesystem
    volumeName: pvc-a222b1e0-f971-4a9a-9055-b86dea2e7709
  status:
    accessModes:
    - ReadWriteOnce
    capacity:
      storage: 2Gi
    phase: Bound
kind: List
metadata:
  resourceVersion: ""
```

```
controlplane $ kubectl logs pod        
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/17 03:41:27 [notice] 1#1: using the "epoll" event method
2022/07/17 03:41:27 [notice] 1#1: nginx/1.23.0
2022/07/17 03:41:27 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/17 03:41:27 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/17 03:41:27 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/17 03:41:27 [notice] 1#1: start worker processes
2022/07/17 03:41:27 [notice] 1#1: start worker process 31
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl describe po pod        
Name:         pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sun, 17 Jul 2022 03:41:22 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: 35438b3f60e77bf92dbefe6552deea21ff660138cfdd8d2314ad953e52a2b2b6
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:  192.168.1.5
Containers:
  nginx:
    Container ID:   containerd://0590cfbcb615ecceb83f7ef7a24e0fd66a05b3d16e0440dfee0c9ad375ff0447
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 17 Jul 2022 03:41:27 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dfvr6 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-dfvr6:
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
  Normal  Scheduled  31m   default-scheduler  Successfully assigned default/pod to node01
  Normal  Pulling    31m   kubelet            Pulling image "nginx"
  Normal  Pulled     30m   kubelet            Successfully pulled image "nginx" in 3.693374057s
  Normal  Created    30m   kubelet            Created container nginx
  Normal  Started    30m   kubelet            Started container nginx
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-a222b1e0-f971-4a9a-9055-b86dea2e7709   2Gi        RWO            nfs            25m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-0d7b1d00-f661-49a6-a81c-b11e56009297   2Gi        RWO            nfs            35s
controlplane $ 
controlplane $ kubectl get po pod -o wide
NAME   READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
pod    1/1     Running   0          24s   192.168.1.6   node01   <none>           <none>
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pod
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/17 04:17:19 [notice] 1#1: using the "epoll" event method
2022/07/17 04:17:19 [notice] 1#1: nginx/1.23.0
2022/07/17 04:17:19 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/17 04:17:19 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/17 04:17:19 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/17 04:17:19 [notice] 1#1: start worker processes
2022/07/17 04:17:19 [notice] 1#1: start worker process 30
controlplane $ 
controlplane $ kubectl describe po pod
Name:         pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sun, 17 Jul 2022 04:17:17 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: 915f60b869fcd9a7c952717cdcb162cf8ff32808148438e2d7fe8e3186e0d38a
              cni.projectcalico.org/podIP: 192.168.1.6/32
              cni.projectcalico.org/podIPs: 192.168.1.6/32
Status:       Running
IP:           192.168.1.6
IPs:
  IP:  192.168.1.6
Containers:
  nginx:
    Container ID:   containerd://940abd96178537d49435010f6b89bc91b75f8400ee9655506426ace8eac73904
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 17 Jul 2022 04:17:19 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n4jzz (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-n4jzz:
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
  Normal  Scheduled  63s   default-scheduler  Successfully assigned default/pod to node01
  Normal  Pulling    62s   kubelet            Pulling image "nginx"
  Normal  Pulled     62s   kubelet            Successfully pulled image "nginx" in 324.709544ms
  Normal  Created    62s   kubelet            Created container nginx
  Normal  Started    61s   kubelet            Started container nginx
```
